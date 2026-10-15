-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_get_ent_role_mapid(numeric, character varying)
-- Type: FUNCTION

-- Name: lablakr_get_ent_role_mapid(numeric, character varying); Type: FUNCTION; Schema: lablakr; Owner: -
--

CREATE FUNCTION lablakr.lablakr_get_ent_role_mapid(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_role_map_id numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

DECLARE 
	v_entity_role_id numeric;
begin 
	
    select entity_role_id into v_entity_role_id
    from lablakr.lablakr_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    select entity_role_map_id into p_entity_role_map_id
    from lablakr.lablakr_entity_role_map RM
    where RM.entity_role_id = v_entity_role_id
    and RM.source_object_id = p_source_object_id ;
    
end; 

$$;


--
