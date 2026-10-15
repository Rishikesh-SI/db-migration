-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_get_match_contents_r(text[])
-- Type: FUNCTION

-- Name: labsaw_get_match_contents_r(text[]); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_get_match_contents_r(p_match_code text[], OUT p_result numeric, OUT p_match_contents_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_language_erm_id numeric := 4;
	v_preview_erm_id numeric := 941;
	v_review_erm_id numeric := 1041;
	v_matches_er_id numeric[];
	v_i numeric := 0;
	v_match_code text;
	v_match_erm_id numeric;
	v_match_content_json jsonb;
	v_filter_arr numeric[];
	v_match_preview_content jsonb;
	v_match_review_content jsonb;
	v_matches_content_json_arr jsonb[];
	
begin
	
	select array(select er.entity_role_id
				 from labsaw.labsaw_entity_type et
				 join labsaw.labsaw_entity_role er
				 on er.entity_type_id = et.entity_type_id
				 where lower(et.entity_type_name) = 'matches')
	into v_matches_er_id;
	
	v_i := 0;
	
	foreach v_match_code in array p_match_code
	loop
		
		v_match_erm_id := null;
		v_match_content_json := '{"match_code":null,"preview":null,"review":null}'::jsonb;
		v_filter_arr := null;
		v_match_preview_content := null;
		v_match_review_content := null;
		
		select entity_role_map_id
		into v_match_erm_id
		from labsaw.labsaw_entity_role_map
		where entity_role_id =any(v_matches_er_id)
		and source_object_id = v_match_code;
		
		if v_match_erm_id is not null then
			
			v_match_content_json := jsonb_set(v_match_content_json,'{match_code}',('"'||v_match_code||'"')::jsonb,false);
			
			v_filter_arr := array[v_language_erm_id, v_preview_erm_id, v_match_erm_id];
			
			select web_listing_json
			into v_match_preview_content
			from labsaw.labsaw_asset_list
			where tagged_entity @> v_filter_arr::int[]
			and is_published = 1
			and published_date <= current_timestamp at time zone 'utc'
			and asset_type_id in (1,2,4,5,29);
			
			if v_match_preview_content is not null then
				
				v_match_content_json := jsonb_set(v_match_content_json,'{preview}',v_match_preview_content,false);
				
			end if;
			
			v_filter_arr := array[v_language_erm_id, v_review_erm_id, v_match_erm_id];
			
			select web_listing_json
			into v_match_review_content
			from labsaw.labsaw_asset_list
			where tagged_entity @> v_filter_arr::int[]
			and is_published = 1
			and published_date <= current_timestamp at time zone 'utc'
			and asset_type_id in (1,2,4,5,29);
			
			if v_match_review_content is not null then
				
				v_match_content_json := jsonb_set(v_match_content_json,'{review}',v_match_review_content,false);
				
			end if;
			
			v_matches_content_json_arr[v_i] := v_match_content_json;
			
			v_i := v_i + 1;
			
		end if;
		
	end loop;
	
	if array_length(v_matches_content_json_arr,1) <> 0 then
		
		select ('{"matches":['||string_agg(match_content_json::text,',')||']}')::jsonb
		from (select match_content_json
			  from unnest(v_matches_content_json_arr) u(match_content_json)
			 ) row
		into p_match_contents_json;
		
	end if;
	
	if p_match_contents_json is not null then
		
		p_result := 1;
		
	else
		
		p_result := 0;
		
	end if;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


--
