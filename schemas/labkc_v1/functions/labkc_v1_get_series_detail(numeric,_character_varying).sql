-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_series_detail(numeric, character varying)
-- Type: FUNCTION

-- Name: labkc_v1_get_series_detail(numeric, character varying); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_series_detail(p_asset_type_id numeric, p_source_object_id character varying, OUT p_entity_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE 
	v_entity_role_id numeric;
begin 
	
    select  entity_role_id into v_entity_role_id
    from labkc_v1.labkc_v1_asset_type 
    where asset_type_id = p_asset_type_id ; 
    
    /*select entity_role_map_id  into p_entity_role_map_id
    from labkc_v1.labkc_v1_entity_role_map RM
    where RM.entity_role_id = v_entity_role_id
    and RM.source_object_id = p_source_object_id ;*/
	
	select row_to_json(row) into p_entity_data from(
	select RM.entity_role_map_id,RM.entity_role_id,em.entity_name,
		   em.entity_display_name,em.show_content,em.show_data,RM.source_object_id
    from labkc_v1.labkc_v1_entity_role_map RM
	left join labkc_v1.labkc_v1_entity_master em on RM.entity_master_id=em.entity_master_id
    where RM.entity_role_id = v_entity_role_id
    and RM.source_object_id = p_source_object_id)row ;
    
end; 

$$;


--
