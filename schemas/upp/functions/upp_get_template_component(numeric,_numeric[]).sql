-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_get_template_component(numeric, numeric[])
-- Type: FUNCTION

-- Name: upp_get_template_component(numeric, numeric[]); Type: FUNCTION; Schema: upp; Owner: -
--

CREATE FUNCTION upp.upp_get_template_component(p_templeteid numeric, p_componentid numeric[], OUT p_templatecomponent jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$ 

 

 

declare
 v_json			 varchar(4000) := '{"component":';
 v_asset_type_id numeric := 13 ;
  			
begin

     select array_to_json(array_agg(a))
     into p_templatecomponent
     from
     (select tc.* , t.template_name ,
          	(select array_to_json(array_agg(a))
             from   (select em.entity_role_map_id, m.entity_name, em.is_linkable, em.is_visible, em.priority, em.aemap_guid
            		 from upp.upp_asset_entity_map em
                     inner join upp.upp_entity_role_map r 
                     on (em.entity_role_map_id = r.entity_role_map_id)
                     inner join upp.upp_entity_master m
                     on(r.entity_master_id = m.entity_master_id)
            		 where em.asset_type_id = v_asset_type_id
                     and em.asset_id = tc.template_component_map_id
                     and em.is_active = 1 
                     and em.is_deleted = 0 
                     and m.is_active = 1 
                     and m.is_deleted = 0 
                    )a 
             )entity
      from upp.upp_template_component_map tc
      join upp.upp_template t 
      on (tc.template_id = t.template_id)
      join (select component_id from unnest(coalesce(p_componentid,array[0]))component_id) tm
      on(tc.component_id = tm.component_id or tm.component_id = 0)
      where (tc.template_id = p_templeteid or coalesce(p_templeteid,0) = 0 )
      and
      tc.is_published = 1
      and t.is_active = 1
      and t.is_deleted = 0
      and tc.is_active = 1
      and tc.is_deleted = 0
      -- and (tc.template_id = p_templeteid or coalesce(p_templeteid,0) = 0 )
      -- limit 3
      )a
     ; 
    
     p_templatecomponent := v_json ||  p_templatecomponent || '}' ;                                         
end;
    

 $$;


--
