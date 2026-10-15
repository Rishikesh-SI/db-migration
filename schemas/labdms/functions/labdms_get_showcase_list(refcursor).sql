-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_showcase_list(refcursor)
-- Type: FUNCTION

-- Name: labdms_get_showcase_list(refcursor); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_showcase_list(p_data refcursor) RETURNS void
    LANGUAGE plpgsql
    AS $$

begin

     /*open p_data for
	 select distinct 
	 m.template_component_map_id ,
    m.template_id ,
    m.component_id ,
   ( m.title ||' '||t.template_name||'-'||coalesce(c.entity_name,' ')) as title,
    m.display_title ,
    m.title_mobile ,
    m.title_app ,
    m.show_in_web,
    m.show_in_mobile,
    m.show_in_app ,
    m.fetch_from ,
    m.created_date ,
    m.updated_date ,
    m.created_by ,
    m.updated_by,
    m.is_active ,
    m.is_deleted,
    m.is_published,
    m.tcmap_guid ,
    m.parent_container_id ,
    m.parent_tcmap_id ,
    m.meta_info ,
    m.menu_id ,
   -- t2.page_id,
    c.entity_role_map_id,
    c.entity_name
   
    from labdms.labdms_template_component_map m
    join labdms.labdms_template t on m.template_id=t.template_id
    join labdms.labdms_template t2 on t.template_id=t2.parent_id
    left  join (select a.asset_id,a.entity_role_map_id,d.entity_name
    from labdms.labdms_asset_entity_map a 
    join (select a.entity_role_map_id,c.entity_name 
         from labdms.labdms_entity_role_map a
         join labdms.labdms_entity_category b on a.entity_role_id=b.entity_role_id
         join labdms.labdms_entity_master c on a.entity_master_id=c.entity_master_id
         where category_name ='language')d 
         on a.entity_role_map_id=d.entity_role_map_id
         where asset_type_id=11) c on c.asset_id=t2.page_id
        
    where  component_id = 9
    and t2.page_id<>0 
	and m.is_deleted=0
	and t.is_deleted=0
	and t2.is_deleted=0
	
	union all 
	
	select distinct 
	 m.template_component_map_id ,
    m.template_id ,
    m.component_id ,
   ( m.title ||' ('||t.template_name||' - '||coalesce('tamil',' ')||')') as title,
    m.display_title ,
    m.title_mobile ,
    m.title_app ,
    m.show_in_web,
    m.show_in_mobile,
    m.show_in_app ,
    m.fetch_from ,
    m.created_date ,
    m.updated_date ,
    m.created_by ,
    m.updated_by,
    m.is_active ,
    m.is_deleted,
    m.is_published,
    m.tcmap_guid ,
    m.parent_container_id ,
    m.parent_tcmap_id ,
    m.meta_info ,
    m.menu_id ,
   -- t2.page_id,
   5 entity_role_map_id,
   'english' entity_name
   
    from labdms.labdms_template_component_map m
    join labdms.labdms_template t on m.template_id=t.template_id
	where component_id=9 and t.is_master=1
	;*/
	
	open p_data for
	 select distinct 
	 tcm.template_component_map_id ,
    tcm.template_id ,
    tcm.component_id ,
   ( tcm.title ||' '||t.template_name||'-'||coalesce(em.entity_name,' ')) as title,
    tcm.display_title ,
    tcm.title_mobile ,
    tcm.title_app ,
    tcm.show_in_web,
    tcm.show_in_mobile,
    tcm.show_in_app ,
    tcm.fetch_from ,
    tcm.created_date ,
    tcm.updated_date ,
    tcm.created_by ,
    tcm.updated_by,
    tcm.is_active ,
    tcm.is_deleted,
    tcm.is_published,
    tcm.tcmap_guid ,
    tcm.parent_container_id ,
    tcm.parent_tcmap_id ,
    tcm.meta_info ,
    tcm.menu_id ,
   -- t2.page_id,
    erm.entity_role_map_id,
    em.entity_name	
					from labdms.labdms_template_component_map tcm
					join labdms.labdms_template t
					on t.template_id = tcm.template_id
					join labdms.labdms_template t1
					on t1.parent_id = t.template_id
					left join labdms.labdms_asset_entity_map aem
					on aem.asset_id = t1.page_id
					and aem.asset_type_id = 11
					left join labdms.labdms_entity_role_map erm
					on erm.entity_role_map_id = aem.entity_role_map_id
					left join labdms.labdms_entity_category ec
					on ec.entity_role_id = erm.entity_role_id
					left join labdms.labdms_entity_master em
					on em.entity_master_id = erm.entity_master_id
					where tcm.component_id = 9
					and ec.category_name ='Language'
					and t1.page_id<>0 
	and tcm.is_deleted=0
	and t.is_deleted=0
	and t1.is_deleted=0;
end;

$$;


--
