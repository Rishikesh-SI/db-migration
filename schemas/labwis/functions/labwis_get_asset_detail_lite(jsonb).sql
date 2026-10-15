-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwis
-- Object: labwis_get_asset_detail_lite(jsonb)
-- Type: FUNCTION

-- Name: labwis_get_asset_detail_lite(jsonb); Type: FUNCTION; Schema: labwis; Owner: -
--

CREATE FUNCTION labwis.labwis_get_asset_detail_lite(p_input jsonb, OUT p_output jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
DECLARE
  	v_asset_type_id NUMERIC; 
  	v_asset_id NUMERIC; 
  	v_title character varying;
  	v_image_file_name character varying;
	v_short_desc character varying;
	v_primary_url character varying;
	v_secondary_url character varying;
	v_asset_map jsonb;
	v_json jsonb := '{}';
BEGIN
  -- Extract input values
  v_asset_type_id := (p_input->'data'->>'asset_type_id')::NUMERIC;
  v_asset_id := (p_input->'data'->>'asset_id')::NUMERIC;
  
  select asset_title,
	image_file_name as image_name ,
	short_desc,
	web_detail_jsn->'data'->>'pri-ent_url' as primary_url,
  	web_detail_jsn->'data'->>'sec-ent_url' as secondary_url,
	web_detail_jsn->'data'->>'asset_map' as asset_map
into
	v_title,
	v_image_file_name,
	v_short_desc,
	v_primary_url,
	v_secondary_url,
	v_asset_map
	
	from labwis.labwis_asset_list
	where is_published=1 and is_active=1 and is_deleted=0
	and asset_id = v_asset_id
	and asset_type_id = v_asset_type_id 
	--and published_version_number=max(published_version_number)
	LIMIT 1;

	v_json := jsonb_build_object(
    'data', jsonb_build_object(
      'title', COALESCE(v_title, ''),
      'primary_url', COALESCE(v_primary_url, ''),
      'secondary_url', COALESCE(v_secondary_url, ''),
      'short_desc', COALESCE(v_short_desc, ''),
      'image_file_name', COALESCE(v_image_file_name, ''),
	  'asset_map',COALESCE(v_asset_map, '[]')
      
    )
  );

    
    p_output  := v_json::jsonb;
  

END;
$$;


--
