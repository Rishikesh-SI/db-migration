-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_gallery_listing_to_del_thumbnail_r(character varying, jsonb, character varying)
-- Type: FUNCTION

-- Name: _get_gallery_listing_to_del_thumbnail_r(character varying, jsonb, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_gallery_listing_to_del_thumbnail_r(p_schema character varying, p_thumbnail_json jsonb, p_user_guid character varying, OUT p_result numeric, OUT p_gallery_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare

i record;
v_thumbnail  text[];

begin

	for i in select b->>'thumbnail' as thumbnail 
	from (select b
		  from jsonb_array_elements(p_thumbnail_json->'data') b)as a 
	loop 

	v_thumbnail := array_append(v_thumbnail,i.thumbnail) ;

	end loop ;

-- raise notice '%',v_thumbnail;
		execute
		'select (''{"data":''||json_agg(row_to_json(row))::text||''}'')::jsonb
			from (select gallery_id, gallery_name, gallery_path, status, season_id, gallery_type, 
			thumbnail, null as entities, null as gallery_resolution,
						user_guid, image_type, is_gif_created, gif_frame_path, frame_id
				  from '||p_schema||'.'||p_schema||'_gallery
				  where thumbnail =any($1) and user_guid = ' || p_user_guid ||'
				  and is_active=1 and is_deleted=0
				 )row'
			into p_gallery_json
			using v_thumbnail;

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
$_$;


--
