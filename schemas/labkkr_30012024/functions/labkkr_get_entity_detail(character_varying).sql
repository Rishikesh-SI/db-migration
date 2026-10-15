-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_get_entity_detail(character varying)
-- Type: FUNCTION

-- Name: labkkr_get_entity_detail(character varying); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_get_entity_detail(p_entity_name character varying, OUT p_entity_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
     

declare
	
	v_entity_name labkkr.labkkr_entity_master.entity_display_name%type := lower(p_entity_name);
    v_entity_arr numeric[];
    v_entity_json_arr jsonb[];
    v_entity_json_count numeric;
    v_entity_json jsonb;
    v_json text := '{"entitydata":[';
    
begin
	
    select array
    (select entity_master_id
     from   labkkr.labkkr_entity_master
     where  (lower(entity_name) = v_entity_name
             or lower(entity_display_name) = v_entity_name))
	into   v_entity_arr;
    
    select array
    (select row_to_json(row) jsonrow
     from
     (select erm.priority, 1 is_visible, erm.entity_role_map_id, em.entity_name, 0 is_linkable
      from   labkkr.labkkr_entity_role_map erm
      join   labkkr.labkkr_entity_master em
      on     em.entity_master_id = erm.entity_master_id
      where  erm.entity_master_id in (select entity_master_id
                                     from   unnest(v_entity_arr) u(entity_master_id))
     ) row
    )
    into   v_entity_json_arr;
    
    select count(1)
    into   v_entity_json_count
    from   unnest(v_entity_json_arr) entity_json;
    
	foreach v_entity_json in array v_entity_json_arr
	loop
    	v_json := v_json||v_entity_json||',';
  	end loop;
    
    if v_entity_json_count > 0 then
    	v_json := substring(v_json,1,(length(v_json)-1));
	else
    	v_json := substring(v_json,1,(length(v_json)));
	end if;
    
    v_json := v_json||']}';
    
    p_entity_json := v_json::jsonb;
    
end;

     
$$;


--
