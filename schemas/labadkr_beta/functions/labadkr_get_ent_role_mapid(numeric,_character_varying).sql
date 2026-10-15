-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_get_ent_role_mapid(numeric, character varying)
-- Type: FUNCTION

-- Name: labadkr_get_ent_role_mapid(numeric, character varying); Type: FUNCTION; Schema: labadkr_beta; Owner: -
--

CREATE FUNCTION labadkr_beta.labadkr_get_ent_role_mapid(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_role_map_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE 
	v_entity_role_id numeric;
begin 
	
    select entity_role_id into v_entity_role_id
    from labadkr.labadkr_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    select entity_role_map_id into p_entity_role_map_id
    from labadkr.labadkr_entity_role_map RM
    where RM.entity_role_id = v_entity_role_id
    and RM.source_object_id = p_source_object_id ;
    
end; 

$$;


--
