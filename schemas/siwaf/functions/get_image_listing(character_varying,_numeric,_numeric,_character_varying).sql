-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_image_listing(character varying, numeric, numeric, character varying)
-- Type: FUNCTION

-- Name: _get_image_listing(character varying, numeric, numeric, character varying); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_image_listing(p_schema_prefix character varying, p_page_number numeric, p_item_number numeric, p_search_keyword character varying, OUT p_result numeric, OUT p_image_count numeric, OUT p_image_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_offset numeric := p_item_number * (p_page_number - 1);
	v_search_keyword text;
	v_image_id_arr numeric[];
	v_filter_query text := ' ';
	v_filter_timestamp timestamp := current_timestamp at time zone 'utc' - '1 month'::interval;
	
begin
	
	if p_search_keyword is not null then
		
		v_search_keyword := '''*'||replace(lower(p_search_keyword),' ',':* & *')||':*''';
		
		raise notice 'v_search_keyword : %',v_search_keyword;
		
		execute 'with tab as
					(select asset_id, asset_type_id
						from '||$1||'.'||$1||'_asset_list
						where tvs @@@ to_tsquery($2))
					select array(/*select image_id
									from '||$1||'.'||$1||'_image
									where search_keyword @@@ to_tsquery($2)
									union*/
									select aam.asset_id as image_id
									from '||$1||'.'||$1||'_article_asset_map aam
									join tab t
									on t.asset_id = aam.article_id
									and t.asset_type_id = 1
									where aam.asset_type_id = 3
									union
									select aam.asset_id as image_id
									from '||$1||'.'||$1||'_album_asset_map aam
									join tab t
									on t.asset_id = aam.album_id
									and t.asset_type_id = 2
									where aam.asset_type_id = 3
									union
									select v.image_id
									from '||$1||'.'||$1||'_video v
									join tab t
									on t.asset_id = v.video_id
									and t.asset_type_id = 4
								)'
		into v_image_id_arr
		using p_schema_prefix, v_search_keyword;
		
		v_filter_query := ' where image_id =any($2) ';
		
	end if;
	
	if v_filter_query = ' ' then
		v_filter_query := ' where created_date >= $3 ';
	end if;
	
	execute 'select count(1)
				from '||$1||'.'||$1||'_image'
				||v_filter_query
	into p_image_count
	using p_schema_prefix, v_image_id_arr, v_filter_timestamp;
	
	execute 'select (''{"items":''||json_agg(row_to_json(row))::text||''}'')::jsonb
				from (select row_number() over() + $4 slno, *
						from (select image_id, image_caption, image_path, image_file_name, title_alias
								from '||$1||'.'||$1||'_image'
								||v_filter_query||
		  						'order by created_date desc
		  						limit $4
		  						offset $5
							) tab
					) row'
	into p_image_json
	using p_schema_prefix, v_image_id_arr, v_filter_timestamp, p_item_number, v_offset;
	
	if p_image_json is not null then
		p_result := 1;
	else
		p_result := 0;
		p_image_json := '{"items":[]}';
	end if;

-- exception
-- 	when others then
-- 	 	p_result := -1;
-- 		p_image_json := '{"items":[]}';
	
end;

$_$;


--
