-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_template_component(numeric)
-- Type: FUNCTION

-- Name: zeven_get_template_component(numeric); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_template_component(p_templeteid numeric, OUT p_templatecomponent jsonb) RETURNS jsonb
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
            		 from zeven.zeven_asset_entity_map em
                     inner join zeven.zeven_entity_role_map r 
                     on (em.entity_role_map_id = r.entity_role_map_id)
                     inner join zeven.zeven_entity_master m
                     on(r.entity_master_id = m.entity_master_id)
            		 where em.asset_type_id = v_asset_type_id
                     and em.asset_id = tc.template_component_map_id
                     and em.is_active = 1 
                     and em.is_deleted = 0 
                     and m.is_active = 1 
                     and m.is_deleted = 0 
                    )a 
             )entity
      from zeven.zeven_template_component_map tc
      join zeven.zeven_template t 
      on (tc.template_id = t.template_id)
      where tc.is_published = 1
      and t.is_active = 1
      and t.is_deleted = 0
      and (tc.template_id = p_templeteid or coalesce(p_templeteid,0) = 0 )
      )a
     ; 
    
     p_templatecomponent := v_json ||  p_templatecomponent || '}' ;                                         
END;
    

 

 

$$;


--
