-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_get_entity_detail_by_sourceobject_id(jsonb)
-- Type: FUNCTION

-- Name: labuww_get_entity_detail_by_sourceobject_id(jsonb); Type: FUNCTION; Schema: labuww; Owner: -
--

CREATE FUNCTION labuww.labuww_get_entity_detail_by_sourceobject_id(p_in_json jsonb, OUT p_out_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
v_source_object_id character varying;	
v_canonical_url character varying;
v_entity_role_id numeric;
	
BEGIN
	

 -- select 1/0;
  select p_in_json->'data'->>'source_object_id',
  		 p_in_json->'data'->>'canonical_url',
		 p_in_json->'data'->>'entity_role_id'
		 INTO
		 v_source_object_id,
		 v_canonical_url,
		 v_entity_role_id;
		 
	if 	 v_source_object_id is not null and v_entity_role_id is not null and v_source_object_id<>'' THEN
	
	select row_to_json(row) into p_out_json from (select a.entity_role_map_id as source_object_entity_role_map_id,
									  b.entity_display_name as source_object_entity_display_name,
									  b.canonical_url as source_object_entity_canonical_url,
									  b.entity_url as source_object_entity_url,
									  a.source_object_id,
									  b.add_info									   
									  from labuww.labuww_entity_role_map a
									  join labuww.labuww_entity_master b on a.entity_master_id = b.entity_master_id
									  where a.entity_role_id=v_entity_role_id and a.source_object_id=v_source_object_id)row;
	
	elsif v_canonical_url is not null and v_entity_role_id is not null and v_canonical_url<>'' THEN
	
	select row_to_json(row) into p_out_json from (select a.entity_role_map_id as source_object_entity_role_map_id,
									  b.entity_display_name as source_object_entity_display_name,
									  b.canonical_url as source_object_entity_canonical_url,
									  b.entity_url as source_object_entity_url,
									  a.source_object_id,
									  b.add_info									   
									  from labuww.labuww_entity_role_map a
									  join labuww.labuww_entity_master b on a.entity_master_id = b.entity_master_id
									  where a.entity_role_id=v_entity_role_id and b.canonical_url=v_canonical_url)row;

	end if;
		 
		                                                  
    END;
$$;


--
