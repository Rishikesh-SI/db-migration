-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_podcast_rss_data_r(character varying, numeric, numeric[], numeric, character varying, text)
-- Type: FUNCTION

-- Name: _get_podcast_rss_data_r(character varying, numeric, numeric[], numeric, character varying, text); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_podcast_rss_data_r(p_schema_prefix character varying, p_time numeric, p_entity_role_map_id numeric[], p_item_count numeric, p_language_url character varying, p_sports_name text, OUT p_rss_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_time numeric := p_time;
	v_limit_query text := ' ';
	-- v_asset_type_id numeric := coalesce(p_asset_type_id,0);
	v_entity_count numeric;
	v_entity_filter_query text := ' ';
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_language_url character varying(5) := coalesce(p_language_url,' ');
	v_language_entity_role_map_id numeric;
	v_language_filter_query text := ' ';
	v_entity_role_map_id numeric[] := p_entity_role_map_id;
	v_podcast jsonb;
	v_sports_name text := coalesce(lower(p_sports_name),' ');
	v_sport_filter_query text := ' ';
	  
begin
	
	if v_time is null then
		execute 'select round(extract(epoch from ('''||v_current_timestamp||''' - min(published_date)))/3600)
				from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list where asset_type_id = 29'
		into v_time;
	end if;
	
	if p_item_count is not null then
		v_limit_query := ' limit '||p_item_count;
	end if;
	
	execute 'select erm.entity_role_map_id
			from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
			join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
			on erm.entity_master_id = em.entity_master_id
			join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_category ec
			on ec.entity_role_id = erm.entity_role_id
			where coalesce(em.canonical_url,'''||' '||''') = '''||case v_language_url when ' ' then v_language_url else '/'||v_language_url end||'''
			and ec.category_name = '''||'Language'||''''
	into v_language_entity_role_map_id;
	
	if v_sports_name is not null then
		v_sport_filter_query := ' and lower(pem.entity_name) = $2 ';
	end if;
	
	if v_language_entity_role_map_id is not null and p_schema_prefix <> 'yho' then
		v_language_filter_query := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
												where aem.asset_id = al.asset_id
												and aem.asset_type_id = 29
												and aem.entity_role_map_id = '||v_language_entity_role_map_id||')';
	end if;
	
	select count(1) into v_entity_count from (select entity_id from unnest(p_entity_role_map_id) u(entity_id)) a;
    	
	if v_entity_count > 0 then
		v_entity_filter_query := ' and exists(select 1
												from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
												where aem.asset_id = al.asset_id
												and aem.asset_type_id = al.asset_type_id
												and aem.entity_role_map_id in (select entity_role_map_id
																				from unnest($1) u(entity_role_map_id))
												group by aem.asset_id, aem.asset_type_id
												having count(1) = '||v_entity_count||')';
	end if;
	
	execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
				from (select v.title, v.title_alias, v.video_url, v.duration, v.video_desc, sd.meta_info, v.published_date, u.display_name,
								v.updated_date, i.image_path, i.image_file_name, al.primary_entity_role_map_id, al.secondary_entity_role_map_id,
								pem.entity_name as primary_entity_name, sem.entity_name as secondary_entity_name 
						from '||p_schema_prefix||'.'||p_schema_prefix||'_video v
						join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
						on al.asset_id = v.video_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
						on i.image_id = v.image_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_seo_data sd
						on sd.asset_id = al.asset_id
						and sd.asset_type_id = al.asset_type_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_user u
						on u.user_id = al.author_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
						on serm.entity_role_map_id = al.secondary_entity_role_map_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
						on sem.entity_master_id = serm.entity_master_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
						on perm.entity_role_map_id = al.primary_entity_role_map_id
						join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
						on pem.entity_master_id = perm.entity_master_id
						where al.asset_type_id = 29 '
						||v_entity_filter_query
						||v_language_filter_query
						||v_sport_filter_query
						||' order by v.published_date desc '
					||v_limit_query
				||') row'
	into p_rss_json
	using v_entity_role_map_id, v_sports_name;
	
	execute 'select channel_detail
				from '||p_schema_prefix||'.'||p_schema_prefix||'_channel_master
				where channel_detail->>''SportsName'' = $1'
    into v_podcast	
	using v_sports_name;
	
	p_rss_json := jsonb_set(p_rss_json,'{channel}',coalesce(v_podcast,'null'),true);
	
/*exception
	when others then
		p_rss_json := '{}'::jsonb;*/

end;

$_$;


--
