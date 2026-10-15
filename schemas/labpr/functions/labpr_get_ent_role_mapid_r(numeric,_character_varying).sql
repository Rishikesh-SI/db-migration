-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_get_ent_role_mapid_r(numeric, character varying)
-- Type: FUNCTION

-- Name: labpr_get_ent_role_mapid_r(numeric, character varying); Type: FUNCTION; Schema: labpr; Owner: -
--

CREATE FUNCTION labpr.labpr_get_ent_role_mapid_r(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_role_map_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE 
	v_entity_role_id numeric;
begin 
	
    select entity_role_id into v_entity_role_id
    from labpr.labpr_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    select entity_role_map_id into p_entity_role_map_id
    from labpr.labpr_entity_role_map RM
    where RM.entity_role_id = v_entity_role_id
    and RM.source_object_id = p_source_object_id ;
    
end; 

$$;


--
