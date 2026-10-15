-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_get_ent_role_mapid_r(numeric, character varying)
-- Type: FUNCTION

-- Name: labhkind_get_ent_role_mapid_r(numeric, character varying); Type: FUNCTION; Schema: labhkind; Owner: -
--

CREATE FUNCTION labhkind.labhkind_get_ent_role_mapid_r(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_role_map_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE 
	v_entity_role_id numeric;
	v_entity_role_id_1 numeric[];
begin 
	
    select entity_role_id into v_entity_role_id
    from labhkind.labhkind_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
	if v_entity_role_id = 4 then
	 v_entity_role_id_1 := array[22,23,24,25];
	 else 
	 v_entity_role_id_1 := array[3];
	end if;
	
    select entity_role_map_id into p_entity_role_map_id
    from labhkind.labhkind_entity_role_map RM
    where RM.entity_role_id = any(v_entity_role_id_1)
    and RM.source_object_id = p_source_object_id ;
    
end; 

$$;


--
