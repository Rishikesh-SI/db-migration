-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_ent_role_mapid(numeric, character varying)
-- Type: FUNCTION

-- Name: labdms_get_ent_role_mapid(numeric, character varying); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_ent_role_mapid(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_role_map_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare 
	v_entity_role_id numeric;
begin 
	
    select  entity_role_id into v_entity_role_id
    from labdms.labdms_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    select entity_role_map_id  into p_entity_role_map_id
    from labdms.labdms_entity_role_map rm
    where rm.entity_role_id = v_entity_role_id
    and rm.source_object_id = p_source_object_id ;
    
end; 

$$;


--
