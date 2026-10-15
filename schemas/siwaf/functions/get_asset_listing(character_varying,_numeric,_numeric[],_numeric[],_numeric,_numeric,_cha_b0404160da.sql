-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_asset_listing(character varying, numeric, numeric[], numeric[], numeric, numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_asset_listing(character varying, numeric, numeric[], numeric[], numeric, numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_asset_listing(p_schema_prefix character varying, p_status numeric, p_entity_role_map_id numeric[], p_any_entity_role_map_id numeric[], p_content_source_id numeric, p_asset_type_id numeric, p_search_keywords character varying, p_page_number numeric, p_item_number numeric, OUT p_result numeric, OUT p_asset_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_entity_count numeric := coalesce(array_length(p_entity_role_map_id,1),0);
	v_entity_filter_query text := ' ';
	v_any_entity_count numeric := coalesce(array_length(p_any_entity_role_map_id,1),0);
	v_any_entity_filter_query text := ' ';
	v_content_source_filter_query text := ' ';
	v_asset_type_filter_query text := ' ';
	v_search_keywords text := p_search_keywords;
	v_search_filter_query text := ' ';
	v_from_row_number numeric := ((p_page_number - 1) * p_item_number) + 1;
	v_to_row_number numeric := p_page_number * p_item_number;
	v_from_to_row_query text := ' ';
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_asset_count numeric;
	
begin
	
	if p_status in (1,2) then
		
		if v_entity_count > 0 then
			v_entity_filter_query := ' and exists(select 1
											from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
											where aem.asset_id = al.asset_id
											and aem.asset_type_id = al.asset_type_id
											and entity_role_map_id in(select v_entity_role_map_id from unnest($1) u(v_entity_role_map_id))
											group by aem.asset_id, aem.asset_type_id
											having count(1) = '||v_entity_count||')';
		end if;
		
		if v_any_entity_count > 0 then
			v_any_entity_filter_query := ' and exists(select 1
												from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
												where aem.asset_id = al.asset_id
												and aem.asset_type_id = al.asset_type_id
												and entity_role_map_id in(select v_any_entity_role_map_id from unnest($2) u(v_any_entity_role_map_id))
												group by aem.asset_id, aem.asset_type_id
												having count(1) = 1)';
		end if;
		
		if p_content_source_id is not null then
			v_content_source_filter_query := ' and al.content_source_id = '||p_content_source_id;
		end if;
		
		if v_search_keywords is not null then
			v_search_keywords := replace(v_search_keywords,':','');
			v_search_keywords:='*'||replace(''||v_search_keywords||'',' ',':* & *')||':*';
			v_search_filter_query := ' and (to_tsvector(al.asset_title) @@@ to_tsquery('''||v_search_keywords||''')
										or to_tsvector(al.short_desc) @@@ to_tsquery('''||v_search_keywords||'''))';
     	end if;
		
		if p_asset_type_id is not null then
			v_asset_type_filter_query := ' and al.asset_type_id = '||p_asset_type_id;
		end if;
		
		execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb, cnt
				from (select asset_id, asset_type_id, asset_title, total_assets, duration, image_file_name, image_path,
							published_version_number as version_number, created_date, published_date, updated_date,
							row_number() over(order by case '||p_status||' when 1 then al.published_date when 2 then al.updated_date end desc) slno,
							count(1) over() as cnt
						from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
						where al.asset_type_id in(1,2,4,5,6)
						and al.is_published = case '||p_status||' when 1 then 1 when 2 then 0 end
						and al.is_trashed = case '||p_status||' when 1 then 0 when 2 then 1 end
						and al.published_date <= '''||v_current_timestamp||''''
						||v_entity_filter_query
						||v_any_entity_filter_query
						||v_content_source_filter_query
						||v_asset_type_filter_query
						||v_search_filter_query
					||') row
				where slno between '||v_from_row_number||' and '||v_to_row_number
				||' group by cnt'
		into p_asset_json, v_asset_count
		using p_entity_role_map_id, p_any_entity_role_map_id;
		
		if v_asset_count is not null then
			p_asset_json := jsonb_set(p_asset_json,'{asset_count}',v_asset_count::text::jsonb,true);
		else
			p_asset_json := '{"data":[],"asset_count":0}'::jsonb;
		end if;
		
		p_result := 1;
		
	else
		
		select * from siwaf._get_draft_asset_listing(p_schema_prefix, p_entity_role_map_id, p_any_entity_role_map_id, p_content_source_id,
											p_asset_type_id, p_search_keywords, p_page_number, p_item_number)
		into p_result, p_asset_json;
		
	end if;
	
/*exception
	when others then
		p_result := -1;
		p_asset_json := '{"data":[],"asset_count":0}'::jsonb;*/
end;

$_$;


--
