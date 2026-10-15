-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_get_gallery_listing_for_service(numeric)
-- Type: FUNCTION

-- Name: labmi_v1_get_gallery_listing_for_service(numeric); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_get_gallery_listing_for_service(p_item_count numeric, OUT p_result numeric, OUT p_gallery_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
	
	select ('{"data":'||json_agg(row_to_json(row))::text||'}')::jsonb
	from (select gallery_id, gallery_name, gallery_path, status, season_id, gallery_type, thumbnail, null as entities, null as gallery_resolution,
		  		user_guid, image_type, is_gif_created, gif_frame_path, frame_id
		  from labmi_v1.labmi_v1_gallery
		  where coalesce(is_gif_created,0) = 0 and gallery_type=3 and is_deleted=0 and is_active=1
		  limit p_item_count
		 )row
	into p_gallery_json;
	
	if p_gallery_json is not null then
		p_result := 1;
	else
		p_result := 0;
		p_gallery_json := '{"data":[]}'::jsonb;
	end if;
	
exception
	when others then
		p_result := -1;
		p_gallery_json := '{"data":[]}'::jsonb;
	
end;
$$;


--
