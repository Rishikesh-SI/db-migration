-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_rss_data_r(character varying, numeric, numeric, numeric[], numeric)
-- Type: FUNCTION

-- Name: _get_rss_data_r(character varying, numeric, numeric, numeric[], numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_rss_data_r(p_schema_prefix character varying, p_time numeric, p_asset_type_id numeric, p_entity_role_map_id numeric[], p_item_count numeric, OUT p_rss_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_time numeric := p_time;
	v_limit_query text := ' ';
	v_asset_type_id numeric := coalesce(p_asset_type_id,0);
	v_entity_count numeric;
	v_entity_filter_query text := ' ';
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
     
begin
	
	if v_time is null then
		execute 'select round(extract(epoch from ('''||v_current_timestamp||''' - min(published_date)))/3600)
				from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list where asset_type_id in(1,2,4)'
		into v_time;
	end if;
	
	if p_item_count is not null then
		v_limit_query := 'limit '||p_item_count;
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
			from (select al.title_alias, al.asset_title, description, al.published_date, al.short_desc, al.image_path,
						al.image_file_name, al.asset_type_id, al.asset_id, pem.entity_display_name as p_entity_name,
						sem.entity_display_name as s_entity_name, u.user_id, u.display_name as user_name,
						lem.entity_display_name as l_entity_name, al.updated_date, lem.canonical_url as language_url, images::jsonb,
						videos::jsonb, case coalesce(aem.entity_role_map_id,0) when 0 then 0 else 1 end as is_instant_asset,
						sd.meta_info->>''meta_desc'' as seo_meta_desc, tab.duration, tab.video_url
					from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
					join (select asset_id, asset_type_id, description, images, videos, duration, video_url
							from (select a.article_id as asset_id, 1 as asset_type_id, full_text as description,
										(select array_to_json(array_agg(a1))
											from (select aam.article_id asset_id, aam.is_cover, i.*
													from '||p_schema_prefix||'.'||p_schema_prefix||'_article_asset_map aam
													join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
													on i.image_id = aam.asset_id
													where aam.asset_type_id = 3
													and aam.article_id = a.article_id
												)a1
										)::text as images,
										(select array_to_json(array_agg(a1))
											from (select aam.article_id asset_id, v.*
													from '||p_schema_prefix||'.'||p_schema_prefix||'_article_asset_map aam
													join '||p_schema_prefix||'.'||p_schema_prefix||'_video v
													on v.video_id = aam.asset_id
													where aam.asset_type_id = 4
													and aam.article_id = a.article_id
												)a1
										)::text as videos, null as duration, null as video_url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_article a
									where a.is_published = 1
									and a.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
									and a.published_date <= '''||v_current_timestamp||'''
									and 1 = case '||v_asset_type_id||' when 0 then 1 else '||v_asset_type_id||' end
									union
									select a.album_id as asset_id, 2 as asset_type_id, album_desc as description,
											(select array_to_json(array_agg(a1))
												from (select aam.album_id asset_id, aam.is_cover, i.*
														from '||p_schema_prefix||'.'||p_schema_prefix||'_album_asset_map aam
														join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
														on i.image_id = aam.asset_id
														where aam.asset_type_id = 3
														and aam.album_id = a.album_id
													)a1
											)::text as images, null as videos, null as duration, null as video_url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_album a
									where a.is_published = 1
									and a.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
									and a.published_date <= '''||v_current_timestamp||'''
									and 2 = case '||v_asset_type_id||' when 0 then 2 else '||v_asset_type_id||' end
									union
									select v.video_id as asset_id, 4 as asset_type_id, video_desc as description, null as images,
											null as videos, v.duration, v.video_url
									from '||p_schema_prefix||'.'||p_schema_prefix||'_video v
									where v.is_published = 1
									and v.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
									and v.published_date <= '''||v_current_timestamp||'''
									and 4 = case '||v_asset_type_id||' when 0 then 4 else '||v_asset_type_id||' end
								) t
							) tab
					on al.asset_id = tab.asset_id
					and al.asset_type_id = tab.asset_type_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_author_action aa
					on aa.asset_id = al.asset_id
					and aa.asset_type_id = al.asset_type_id
					and aa.action_id = 4
					join '||p_schema_prefix||'.'||p_schema_prefix||'_user u
					on u.user_id = aa.author_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
					on perm.entity_role_map_id = al.primary_entity_role_map_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
					on pem.entity_master_id = perm.entity_master_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
					on serm.entity_role_map_id = al.secondary_entity_role_map_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
					on sem.entity_master_id = serm.entity_master_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map lerm
					on lerm.entity_role_map_id = al.language_id
					join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master lem
					on lem.entity_master_id = lerm.entity_master_id
                         left join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
                         on aem.asset_id = al.asset_id
                         and aem.asset_type_id = al.asset_type_id
                         and aem.entity_role_map_id = (select iaerm.entity_role_map_id
                         						from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map iaerm
                                                       join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master iaem
                                                       on iaem.entity_master_id = iaerm.entity_master_id
                                                       where iaem.entity_name = ''Facebook Instant Article'')
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_seo_data sd
					on sd.asset_id = al.asset_id
					and sd.asset_type_id = al.asset_type_id
					where al.is_published = 1
					and al.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
					and al.published_date <= '''||v_current_timestamp||'''
					and al.asset_type_id = case '||v_asset_type_id||' when 0 then al.asset_type_id else '||v_asset_type_id||' end'
					||v_entity_filter_query
					||'order by is_instant_asset desc, published_date desc '
					||v_limit_query
				||') row'
	into p_rss_json
	using p_entity_role_map_id;
    
    
/*exception
	when others then
		p_rss_json := '{}'::jsonb;*/

end;

$_$;


--
