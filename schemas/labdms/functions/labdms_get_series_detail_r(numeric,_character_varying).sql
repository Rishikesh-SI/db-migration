-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_series_detail_r(numeric, character varying)
-- Type: FUNCTION

-- Name: labdms_get_series_detail_r(numeric, character varying); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_series_detail_r(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare 
	v_entity_role_id numeric;
begin 
	
    select  entity_role_id into v_entity_role_id
    from labdms.labdms_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    /*select entity_role_map_id  into p_entity_role_map_id
    from labdms.labdms_entity_role_map rm
    where rm.entity_role_id = v_entity_role_id
    and rm.source_object_id = p_source_object_id ;*/
	
	select row_to_json(row) into p_entity_data from(
	select rm.entity_role_map_id,rm.entity_role_id,em.entity_name,
		   em.entity_display_name,em.show_content,em.show_data,rm.source_object_id
    from labdms.labdms_entity_role_map rm
	left join labdms.labdms_entity_master em on rm.entity_master_id=em.entity_master_id
    where rm.entity_role_id = v_entity_role_id
    and rm.source_object_id = p_source_object_id)row ;
    
end; 

$$;


--
