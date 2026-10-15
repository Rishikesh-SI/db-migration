-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_get_template_component(numeric, numeric)
-- Type: FUNCTION

-- Name: isl_get_template_component(numeric, numeric); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_get_template_component(p_templeteid numeric, p_componentid numeric, OUT p_templatecomponent jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

 

 

DECLARE
 v_json			 varchar(4000) := '{"component":';
 v_asset_type_id numeric := 13 ;
  			
BEGIN

     select array_to_json(array_agg(a))
     into p_templatecomponent
     from
     (select tc.* , t.template_name ,
          	(select array_to_json(array_agg(a))
             from   (select em.entity_role_map_id, m.entity_name, em.is_linkable, em.is_visible, em.priority, em.aemap_guid
            		 from isl.isl_asset_entity_map em
                     inner join isl.isl_entity_role_map r 
                     on (em.entity_role_map_id = r.entity_role_map_id)
                     inner join isl.isl_entity_master m
                     on(r.entity_master_id = m.entity_master_id)
            		 where em.asset_type_id = v_asset_type_id
                     and em.asset_id = tc.template_component_map_id
                     and em.is_active = 1 
                     and em.is_deleted = 0 
                     and m.is_active = 1 
                     and m.is_deleted = 0 
                    )a 
             )entity
      from isl.isl_template_component_map tc
      join isl.isl_template t 
      on (tc.template_id = t.template_id)
      where (tc.component_id = p_componentid or coalesce(p_componentid,0) = 0 )
      and tc.is_published = 1
      and t.is_active = 1
      and t.is_deleted = 0
      and tc.is_active = 1
      and tc.is_deleted = 0
      and (tc.template_id = p_templeteid or coalesce(p_templeteid,0) = 0 )
      )a
     ; 
    
     p_templatecomponent := v_json ||  p_templatecomponent || '}' ;                                         
END;
    
$$;


--
