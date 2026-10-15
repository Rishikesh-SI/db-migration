-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_gallery_listing_for_service(character varying, numeric)
-- Type: FUNCTION

-- Name: _get_gallery_listing_for_service(character varying, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_gallery_listing_for_service(p_schema character varying, p_item_count numeric, OUT p_result numeric, OUT p_gallery_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
begin
	execute
	'select (''{"data":''||json_agg(row_to_json(row))::text||''}'')::jsonb
	from (select gallery_id, gallery_name, gallery_path, status, season_id, gallery_type, 
				thumbnail, null as entities, null as gallery_resolution,
		  		user_guid, image_type, is_gif_created, gif_frame_path, frame_id
		  from '||p_schema||'.'||p_schema||'_gallery
		  where coalesce(is_gif_created,0) = 0 
		  and gallery_type=3 and is_deleted=0 and is_active=1
		  limit '|| p_item_count|| '
		 )row'
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
