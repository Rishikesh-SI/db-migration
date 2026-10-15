-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_get_showcase_detail_rtesting(character varying, numeric, numeric[], numeric[], numeric[], numeric, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labdms_get_showcase_detail_rtesting(character varying, numeric, numeric[], numeric[], numeric[], numeric, numeric, numeric, numeric); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_get_showcase_detail_rtesting(p_schema_prefix character varying, p_showcase_id numeric, p_entity_role_map_id_arr numeric[], p_other_entity_role_map_id_arr numeric[], p_exclude_entity_role_map_id_arr numeric[], p_page_number numeric, p_page1_item_number numeric, p_item_number numeric, p_is_fallback numeric, OUT p_result numeric, OUT p_showcase_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_fallback numeric := coalesce(p_is_fallback,0);
	v_fallback_query text := ' and is_fallback = $6 ';
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_entity_count numeric;
	v_other_entity_count numeric;
	v_exclude_entity_count numeric;
	v_entity_filter_query_al text := ' ';
	v_entity_filter_query_tcam text := ' ';
	v_other_entity_filter_query_al text := ' ';
	v_other_entity_filter_query_tcam text := ' ';
	v_exclude_entity_filter_query_al text := ' ';
	v_exclude_entity_filter_query_tcam text := ' ';
	v_assets_count numeric;
	v_assets_json jsonb;
	v_showcase_asset_json jsonb;
	v_showcase_json jsonb;
	v_trending_exists numeric;
	v_trending_action_year_month numeric := to_char(current_timestamp at time zone 'utc' - '90 days'::interval,'yyyymm')::numeric;
	v_filter_timestamp timestamp := (current_timestamp at time zone 'utc' - '2 days'::interval)::date::timestamp;
	
begin
	
	select ('{"data":'||row_to_json(row)::text||'}')::jsonb
	from (select template_component_map_id, is_published as status, case is_published when 1 then 0 else 1 end as is_trashed, updated_by,
		  			updated_date as published_date, tcmap_guid as guid, null as version_number, null as count, null as asset_map
		  from labdms.labdms_template_component_map
		  where template_component_map_id = p_showcase_id
		 ) row
	into v_showcase_json;
	
	if p_page1_item_number is null then
		v_from_row_number := (p_page_number * p_item_number - (p_item_number - 1));
		v_to_row_number := (p_page_number * p_item_number);
	else
		if p_page_number = 1 then
			v_from_row_number := (p_page_number * (p_page1_item_number - (p_page1_item_number - 1)));
        else
          	v_from_row_number := p_page1_item_number + (((p_page_number - 1) * p_item_number) - (p_item_number - 1));
        end if;
   		v_to_row_number := p_page1_item_number + ((p_page_number - 1) * p_item_number);
	end if;
	
	select array_length(p_entity_role_map_id_arr, 1), array_length(p_other_entity_role_map_id_arr, 1),
			array_length(p_exclude_entity_role_map_id_arr, 1)
	into v_entity_count, v_other_entity_count, v_exclude_entity_count;
	
	if v_entity_count > 0 then
		
		select count(1)
		into v_trending_exists 
		from labdms.labdms_entity_master em
		join labdms.labdms_entity_role_map erm
		on erm.entity_master_id = em.entity_master_id
		where em.entity_name = 'trending'
		and erm.entity_role_map_id =any(p_entity_role_map_id_arr);
		
		v_fallback := case v_trending_exists when 0 then 2 else 1 end;
		
		v_entity_filter_query_al := ' and al.tagged_entity @> $1 ';
		
		v_entity_filter_query_tcam := ' and exists(select 1
													from labdms.labdms_asset_entity_map aem
													where aem.asset_id = tcam.asset_id
													and aem.asset_type_id = tcam.asset_type_id
													and aem.entity_role_map_id in(select v_entity_role_map_id
																					from unnest($1) u(v_entity_role_map_id))
													group by aem.asset_id, aem.asset_type_id
													having count(1) = '||v_entity_count||')';
	end if;
	
	if v_other_entity_count > 0 then
		
		v_other_entity_filter_query_al := ' and al.tagged_entity && $2 ';
		
		v_other_entity_filter_query_tcam := ' and exists(select 1
															from labdms.labdms_asset_entity_map aem
															where aem.asset_id = tcam.asset_id
															and aem.asset_type_id = tcam.asset_type_id
															and aem.entity_role_map_id in(select other_entity_role_map_id
																							from unnest($2) u(other_entity_role_map_id))
															group by aem.asset_id, aem.asset_type_id
															having count(1) = 1)';
	end if;
	
	if v_exclude_entity_count > 0 then
		
		v_exclude_entity_filter_query_al := ' and not al.tagged_entity && $3 ';
		
		v_exclude_entity_filter_query_tcam := ' and not exists(select 1
																from labdms.labdms_asset_entity_map aem
																where aem.asset_id = tcam.asset_id
																and aem.asset_type_id = tcam.asset_type_id
																and aem.entity_role_map_id in(select other_entity_role_map_id
																								from unnest($3) u(other_entity_role_map_id))
																group by aem.asset_id, aem.asset_type_id
																having count(1) = 1)';
	end if;
	
	execute 'select count(1)
				from (select tcam.asset_id, tcam.asset_type_id
						from labdms.labdms_template_component_asset_map tcam
						join labdms.labdms_asset_list al
						on al.asset_id = tcam.asset_id
						and al.asset_type_id = tcam.asset_type_id
						where tcam.template_component_map_id = '||p_showcase_id
						||' and tcam.asset_type_id <> 12 '
						||v_entity_filter_query_al
						||v_other_entity_filter_query_al
						||v_exclude_entity_filter_query_al
						||'union
						select tcam.asset_id, tcam.asset_type_id
						from labdms.labdms_template_component_asset_map tcam
						where tcam.template_component_map_id = '||p_showcase_id
						||' and tcam.asset_type_id = 12 '
						||v_entity_filter_query_tcam
						||v_other_entity_filter_query_tcam
						||v_exclude_entity_filter_query_tcam
						||'union
						select al.asset_id, al.asset_type_id
						from labdms.labdms_asset_list al
						where al.asset_type_id in(1,2,4,18,19,34,35,5)
						and al.is_published = 1
						and al.is_trashed = 0
						and 0 = '||v_trending_exists||'
						and (al.asset_id, al.asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
																	from labdms.labdms_template_component_asset_map tcam
																	where tcam.template_component_map_id = '||p_showcase_id||'
																	and tcam.asset_type_id <> 12) '
						||v_entity_filter_query_al
						||v_other_entity_filter_query_al
						||v_exclude_entity_filter_query_al
						||' and '||v_fallback||' = 1
						union 
						select distinct asset_id, asset_type_id
						from (select asset_id, asset_type_id, count(1) asset_action_count
								from labdms.labdms_user_action_tracking
								where action_year_month >= $4
								and action_date >= $5
								and asset_type_id in(1,2,4,11,18,19,34,35,5)
								and action_url::jsonb->>''title'' not like ''%{%''
								and action_url::jsonb->>''url'' not like ''%(%''
								and 1 = '||v_trending_exists||'
								and '||v_fallback||' = 1
								and (asset_id, asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
																		from labdms.labdms_template_component_asset_map tcam
																		where tcam.template_component_map_id = '||p_showcase_id||'
																		and tcam.asset_type_id <> 12)
								group by asset_id, asset_type_id
								order by asset_action_count desc
							)row
					) tab'
	into v_assets_count
	using p_entity_role_map_id_arr::int[], p_other_entity_role_map_id_arr::int[], p_exclude_entity_role_map_id_arr::int[],
			v_trending_action_year_month, v_filter_timestamp;
	
	v_showcase_json := jsonb_set(v_showcase_json,'{data,count}',('"'||v_assets_count||'"')::text::jsonb,false);
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select asset_id, asset_type_id, url, slno as asset_order, is_fallback, title
					from (select asset_id, asset_type_id, url, row_number() over(order by is_fallback, asset_order) as slno, is_fallback,
									is_image_available, title
							from (select tcam.asset_id, tcam.asset_type_id, null as url, tcam.asset_order, 0 as is_fallback,
											case length(tcam.asset_meta->>''image_id'') when 0 then 0 else 1 end as is_image_available,
											tcam.asset_meta->>''title'' as title
									from labdms.labdms_template_component_asset_map tcam
									join labdms.labdms_asset_list al
									on al.asset_id = (tcam.asset_meta->>''asset_id'')::numeric
									and al.asset_type_id = (tcam.asset_meta->>''content_type'')::numeric
									where tcam.template_component_map_id = '||p_showcase_id
									
									||v_entity_filter_query_al
									||v_other_entity_filter_query_al
									||v_exclude_entity_filter_query_al
									||'union
									select tcam.asset_id, tcam.asset_type_id, null as url, tcam.asset_order, 0 as is_fallback,
											case length(tcam.asset_meta->>''image_id'') when 0 then 0 else 1 end as is_image_available,
											tcam.asset_meta->>''title'' as title
									from labdms.labdms_template_component_asset_map tcam
									where tcam.template_component_map_id = '||p_showcase_id
									||' and tcam.asset_type_id = 12 '
									||v_entity_filter_query_tcam
									||v_other_entity_filter_query_tcam
									||v_exclude_entity_filter_query_tcam
									||'union
									select al.asset_id, al.asset_type_id, null as url,
											row_number() over(order by al.published_date desc) as asset_order, 2 as is_fallback,
											case coalesce(length(al.image_path),0) when 0 then 0 else 1 end as is_image_available,
											al.asset_title as title
									from labdms.labdms_asset_list al
									where al.asset_type_id in(1,2,4,5)
									and al.is_published = 1
									and al.is_trashed = 0
									and 0 = '||v_trending_exists||'
									and (al.asset_id, al.asset_type_id) not in(select tcam.asset_id, tcam.asset_type_id
																				from labdms.labdms_template_component_asset_map tcam
																				where tcam.template_component_map_id = '||p_showcase_id||'
																				and tcam.asset_type_id <> 12) '
									||v_entity_filter_query_al
									||v_other_entity_filter_query_al
									||v_exclude_entity_filter_query_al
									||' union
									select asset_id, asset_type_id, url, row_number() over(order by asset_action_count desc) as asset_order,
											1 as is_fallback, 1 as is_image_available, title
									from (select asset_id, asset_type_id, url, title, count(1) as asset_action_count
											from (select asset_id, asset_type_id, lower(action_url::jsonb->>''url'') as url,
															replace(action_url::jsonb->>''title'','' - yahoo! cricket'','''') as title
													from labdms.labdms_user_action_tracking
													where action_year_month >= $4
													and action_date >= $5
													and asset_type_id in(1,2,4,11,18,19,34,35,5)
													and action_url::jsonb->>''title'' not like ''%{%''
													and action_url::jsonb->>''url'' not like ''%(%''
													and 1 = '||v_trending_exists||'
													and '||v_fallback||' = 1
												)tab
											group by asset_id, asset_type_id, url, title
											order by asset_action_count desc
											limit 100
										)tab_a
								) tab_b
							where is_image_available = 1 '
							||v_fallback_query
						||') tab_c
					where slno between '||v_from_row_number||' and '||v_to_row_number||'
				) row'
	into v_assets_json
	using p_entity_role_map_id_arr::int[], p_other_entity_role_map_id_arr::int[], p_exclude_entity_role_map_id_arr::int[],
			v_trending_action_year_month, v_filter_timestamp, v_fallback;
	
	raise notice '%',v_assets_json;
	select 1/0;
	
	execute 'with tab as
				(select (json_array_elements(a->''data'')->>''asset_id'')::numeric as asset_id,
						(json_array_elements(a->''data'')->>''asset_type_id'')::numeric as asset_type_id,
						json_array_elements(a->''data'')->>''url'' as url,
						(json_array_elements(a->''data'')->>''asset_order'')::numeric as asset_order,
						(json_array_elements(a->''data'')->>''is_fallback'')::numeric as is_fallback,
						json_array_elements(a->''data'')->>''title'' as title
					from (select $1::json as a) tab_a
				)
				select (json_agg(row_to_json(row))::jsonb)
				from (select tab_e.template_component_asset_map_id, tab_e.template_component_map_id, tab_e.asset_id,
								tab_e.asset_type_id as asset_type, tab_e.asset_meta, tab_e.asset_order, tab_e.published_date as publish_date,
								a.full_text, tab_e.published_version_number,
								(select array_to_json(array_agg(tab))
									from (select aem.priority, aem.entity_role_map_id, em.entity_name as name, aem.is_linkable, aem.is_visible,
													tab_e.asset_id, tab_e.asset_type_id, em.canonical_url as canonical,
													em.entity_display_name as ent_disp_name,
													case when ec.entity_category_id is not null then 1 else 0 end as is_lang
											from labdms.labdms_asset_entity_map aem
											join labdms.labdms_entity_role_map erm
											on erm.entity_role_map_id = aem.entity_role_map_id
											join labdms.labdms_entity_master em
											on em.entity_master_id = erm.entity_master_id
											left join labdms.labdms_entity_category ec
											on ec.entity_role_id = erm.entity_role_id
											and ec.category_name = ''language''
											where aem.asset_id = tab_e.asset_id
											and aem.asset_type_id = tab_e.asset_type_id
										)tab
								) as entitydata,
								(select array_to_json(array_agg(tab))
									from (select tab_e.asset_id, tab_e.asset_type_id, u.user_id as author_id, u.display_name as author_name,
													u.full_name, u.user_name, pam.content_provider_id as content_source_id,
													cp.content_provider_name
											from labdms.labdms_author_action aa
											join labdms.labdms_user u
											on u.user_id = aa.author_id
											left join labdms.labdms_provider_author_map pam
											on aa.author_id = pam.author_id
											left join labdms.labdms_content_provider cp
											on pam.content_provider_id = cp.content_provider_id
											where aa.asset_id = tab_e.asset_id
											and aa.asset_type_id = tab_e.asset_type_id
											and aa.action_id = 4
										)tab
								) as author
						from (select tcam.template_component_asset_map_id, tcam.template_component_map_id, tcam.asset_id, tcam.asset_type_id,
										tcam.asset_meta, t.asset_order, tcam.published_date, tcam.published_version_number,
										null as total_assets
								from labdms.labdms_template_component_asset_map tcam
								join tab t
								on t.asset_id = tcam.asset_id
								and t.asset_type_id = tcam.asset_type_id
								where t.is_fallback = 0
								union
								select null as template_component_asset_map_id, null as template_component_map_id, al.asset_id, al.asset_type_id,
										(select row_to_json(row)::jsonb
											from (select null as url, al.short_desc as desc, al.asset_title as title, al.asset_id,
															null as image_id, al.image_file_name as image_name, al.image_path, 1 as responsive,
															al.title_alias, null as video_embed, al.asset_type_id as content_type,
															null as mob_image_id, null as score_wicket, null as mob_image_name,
															null as mob_image_path, null as content_source_id
												) row
										)::jsonb as asset_meta, t.asset_order, al.published_date, al.published_version_number, al.total_assets
								from labdms.labdms_asset_list al
								join tab t
								on t.asset_id = al.asset_id
								and t.asset_type_id = al.asset_type_id
								where t.is_fallback = 2
								and 0 = '||v_trending_exists||'
							   	union								
								select null as template_component_asset_map_id, null as template_component_map_id, tab_d.asset_id,
										tab_d.asset_type_id,
							   			(select row_to_json(row)::jsonb
											from (select tab_d.url, null as desc, tab_d.title, tab_d.asset_id,
															null as image_id, null as image_name, null as image_path,
															1 as responsive, url as title_alias, null as video_embed,
															tab_d.asset_type_id as content_type, null as mob_image_id, null as score_wicket,
															null as mob_image_name, null as mob_image_path, null as content_source_id
												) row
										)::jsonb as asset_meta, null as asset_order, null published_date, null published_version_number,
													null as total_assets									
								from (select uat.asset_id, uat.asset_type_id, t.url, t.title, count(1) as asset_action_count
										from labdms.labdms_user_action_tracking uat
										join tab t
										on t.asset_id = uat.asset_id
										and t.asset_type_id = uat.asset_type_id
										and t.url = uat.action_url::jsonb->>''url''
										and t.title = replace(uat.action_url::jsonb->>''title'','' - yahoo! cricket'','''')
										where uat.action_year_month >= $2
										and action_date >= $3
										and uat.asset_type_id in(1,2,4,11,18,19,34,35,5)
										and uat.action_url::jsonb->>''title'' not like ''%{%''
										and uat.action_url::jsonb->>''url'' not like ''%(%''
										and 1 = '||v_trending_exists||'
										and '||v_fallback||' = 1
										group by uat.asset_id, uat.asset_type_id, t.url, t.title
									) tab_d
							) tab_e
						left join labdms.labdms_article a
						on a.article_id = tab_e.asset_id
						and tab_e.asset_type_id = 1
						order by asset_order
					) row'
	into v_showcase_asset_json
	using v_assets_json, v_trending_action_year_month, v_filter_timestamp;
	
	v_showcase_json := jsonb_set(v_showcase_json,'{data,asset_map}',v_showcase_asset_json,false);
	
	if v_showcase_json is null then
		p_result := 0;
		p_showcase_json := '{"data":[]}'::jsonb;
	else
		p_result := 1;
		p_showcase_json := v_showcase_json;
	end if;
	
/*exception
	when others then
		p_result := -1;
		p_showcase_json := '{"data":[]}'::jsonb;
*/	
end;

$_$;


--
