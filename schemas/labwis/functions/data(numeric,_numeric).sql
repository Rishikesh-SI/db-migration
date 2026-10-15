-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: data(numeric, numeric)
-- Type: FUNCTION

-- Name: data(numeric, numeric); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.data(p_parent numeric, p_template numeric) RETURNS SETOF jsonb
    LANGUAGE sql
    AS $$

--********************************PREFACE BLOCK*******************************
--  NAME: 
--
--  Purpose:
--
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             03/08/2017      CREATION
--********************************END PREFACE BLOCK***************************

with t as
(
   select template_component_map_id,
   component_id, 
   title, 
   display_title, 
   title_mobile, 
   title_app, 
   show_in_web, 
   show_in_mobile, 
   show_in_app, 
   fetch_from,
   parent_container_id, 
   parent_tcmap_id,
   meta_info,
   tcmap_guid,
   layout_info,
	is_protected
   from   labwis.labwis_template_component_map
   where  template_id = p_template
   and is_active=1
   and is_deleted=0
order by 1, 12
)
select jsonb_build_object('template_component_map_id', template_component_map_id,
                          'component_id', component_id,
                          'title', title, 
                          'display_title',display_title,
                          'title_mobile', title_mobile,
                          'title_app', title_app, 
                          'show_in_web', show_in_web, 
                          'show_in_mobile', show_in_mobile, 
                          'show_in_app', show_in_app,
                          'fetch_from', fetch_from, 
                          'parent_container_id', parent_container_id,
                         'parent_tcmap_id', parent_tcmap_id,
                          'child_components',('{ "componentdata":'||jsonb_agg(f.x)::text||'}')::jsonb
                         ,'entity_data',( select array_to_json(array_agg(a))
                               	    from(
                                       select 
                                        a.entity_role_map_id,
                                        a.priority,
                                        a.is_linkable,a.is_visible,
                                        c.entity_name,
                                        a.is_required,
										a.order_number as entity_order_number,
                                        et.entity_type_name,
                                        eg.group_name 
                               		    from labwis.labwis_asset_entity_map  a
                                        left join labwis.labwis_entity_role_map b on b.entity_role_map_id=a.entity_role_map_id
                                        left join labwis.labwis_entity_master c on c.entity_master_id=b.entity_master_id
                                        left join labwis.labwis_entity_role er on er.entity_role_id=b.entity_role_id
                                        left join labwis.labwis_entity_type et on er.entity_type_id=et.entity_type_id
                                        left join labwis.labwis_entity_group eg on er.entity_group_id=eg.entity_group_id
                                        where 
                                         a.asset_id=template_component_map_id
                                         and 
                                         a.asset_type_id=13
                           			   )a)  ,
                          'meta_info',meta_info,
                          'tcmap_guid',tcmap_guid,
                          'layout_info',layout_info,
						  'is_protected',is_protected
                         
                         )
from   t
left join labwis.data(t.template_component_map_id, p_template) as f(x) on true
where 
 
t.parent_tcmap_id = p_parent
or     (p_parent is null and t.parent_tcmap_id is null)

group by t.template_component_map_id, t.component_id, t.title, t.display_title, t.title_mobile, t.title_app, t.show_in_web, t.show_in_mobile,
t.show_in_app, t.fetch_from, t.parent_container_id, t.parent_tcmap_id,t.meta_info,t.tcmap_guid,t.layout_info,t.is_protected;

$$;


--
