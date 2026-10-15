-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labctkr
-- Object: labctkr_get_ent_role_mapid(numeric, character varying)
-- Type: FUNCTION

-- Name: labctkr_get_ent_role_mapid(numeric, character varying); Type: FUNCTION; Schema: labctkr; Owner: -
--

CREATE FUNCTION labctkr.labctkr_get_ent_role_mapid(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_role_map_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE 
	v_entity_role_id numeric;
begin 
	
    select entity_role_id into v_entity_role_id
    from labctkr.labctkr_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    select entity_role_map_id into p_entity_role_map_id
    from labctkr.labctkr_entity_role_map RM
    where RM.entity_role_id = v_entity_role_id
    and RM.source_object_id = p_source_object_id ;
    
end; 

$$;


--
