-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_showcase_detail_r(character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_showcase_detail_r(character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_showcase_detail_r(p_schema_prefix character varying, p_showcase_id numeric, p_page_id numeric, p_page_number numeric, OUT p_result numeric, OUT p_showcase_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$
declare
	
	v_fetch_from numeric;
	v_fallback numeric;
	v_page1_asset_count numeric;
	v_page_asset_count numeric;
	v_priority numeric;
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_tagged_asset_count numeric;
	v_tagged_existing_asset_count numeric;
	v_fallback_asset_count numeric;
	v_entity_role_map_id_arr numeric[];
	v_any_entity_role_map_id_arr numeric[];
	v_page_entity_role_map_id_arr numeric[];
	v_any_page_entity_role_map_id_arr numeric[];
	v_entity_count numeric;
	v_any_entity_count numeric;
	v_language_entity_role_map_id numeric;
	v_entity_filter_query text := ' ';
	v_any_entity_filter_query text := ' ';
	v_assets_json jsonb;
	
begin
	
	execute 'select fetch_from, (meta_info->>''fb'')::numeric,
	           (meta_info->>''page1_size'')::numeric, 
			   (meta_info->>''page_size'')::numeric,
			  coalesce((meta_info->>''priority'')::numeric,0)
			from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_map
			where template_component_map_id = '||p_showcase_id
	into v_fetch_from, v_fallback, v_page1_asset_count, v_page_asset_count, v_priority;
	
	execute 'select language_id
			from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list
			where asset_id = '||p_page_id||'
			and asset_type_id = 11'
	into v_language_entity_role_map_id;
	
	v_page1_asset_count := 5;
	v_page_asset_count := 10;
	
	
	if v_page1_asset_count is null then
		v_from_row_number := (p_page_number * v_page_asset_count - (v_page_asset_count - 1));
		v_to_row_number := (p_page_number * v_page_asset_count);
	else
		if p_page_number = 1 then
			v_from_row_number := (p_page_number * (v_page_asset_count - (v_page_asset_count - 1)));
          else
          	v_from_row_number := v_page1_asset_count + (((p_page_number - 1) * v_page_asset_count) - (v_page_asset_count - 1));
          end if;
   		v_to_row_number := v_page1_asset_count + ((p_page_number - 1) * v_page_asset_count);
	end if;
	
	execute 'select array(select entity_role_map_id
						from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map
						where asset_id = '||p_showcase_id||'
						and asset_type_id = 13
						and is_required = 1)'
	into v_entity_role_map_id_arr;
	
	execute 'select array(select entity_role_map_id
						from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map
						where asset_id = '||p_showcase_id||'
						and asset_type_id = 13
						and is_required <> 1)'
	into v_any_entity_role_map_id_arr;
	
	if v_fetch_from = 1 then
		execute 'select array(select entity_role_map_id
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map
							where asset_id = '||p_page_id||'
							and asset_type_id = 11
							and is_required = 1)'
		into v_page_entity_role_map_id_arr;
		select v_entity_role_map_id_arr||v_page_entity_role_map_id_arr
		into v_entity_role_map_id_arr;
		select array(select distinct entity_role_map_id from unnest(v_entity_role_map_id_arr) u(entity_role_map_id))
		into v_entity_role_map_id_arr;
		execute 'select array(select entity_role_map_id
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map
							where asset_id = '||p_page_id||'
							and asset_type_id = 11
							and is_required <> 1)'
		into v_any_page_entity_role_map_id_arr;
		select v_any_entity_role_map_id_arr||v_any_page_entity_role_map_id_arr
		into v_any_entity_role_map_id_arr;
		select array(select distinct any_entity_role_map_id from unnest(v_any_entity_role_map_id_arr) u(any_entity_role_map_id))
		into v_any_entity_role_map_id_arr;
	end if;
	
	select array_length(v_entity_role_map_id_arr, 1), array_length(v_any_entity_role_map_id_arr, 1)
	into v_entity_count, v_any_entity_count;
	
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
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select asset_id, asset_type_id, asset_order, is_fallback
					from (select asset_id, asset_type_id, row_number() over(order by is_fallback, asset_order) as asset_order, is_fallback,
								row_number() over(order by is_fallback, asset_order) as slno
							from (select tcam.asset_id, tcam.asset_type_id, tcam.asset_order, 0 as is_fallback
									from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
									where tcam.template_component_map_id = '||p_showcase_id||'
									and exists(select 1
												from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
												where aem.asset_id = tcam.asset_id
												and aem.asset_type_id = tcam.asset_type_id
												and aem.entity_role_map_id = '||v_language_entity_role_map_id||')
									union
									select al.asset_id, al.asset_type_id,
											row_number() over(order by al.published_date desc) as asset_order, 1 as is_fallback
									from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
									where al.asset_type_id in(1,2,4)
                                             and not exists(select 1
                                             			from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
                                                            where tcam.template_component_map_id = '||p_showcase_id||'
                                                            and tcam.asset_id = al.asset_id
                                                            and tcam.asset_type_id = al.asset_type_id
                                                            and tcam.asset_type_id <> 12)'
									||v_entity_filter_query
									||v_any_entity_filter_query
								||') tab_a
						) tab_b
					where slno between '||v_from_row_number||' and '||v_to_row_number||'
				) row'
	into v_assets_json
	using v_entity_role_map_id_arr, v_any_entity_role_map_id_arr;
	
	execute 'select (''{"data":[''||string_agg(row_to_json(row)::text,'','')||'']}'')::jsonb
			from (select asset_title, title_alias, short_desc, image_path, image_file_name, responsive, mob_image_name, mob_image_path,
						asset_order, u.display_name as author_name
					from (select tcam.asset_id, tcam.asset_type_id, (tcam.asset_meta->>''title'')::text as asset_title,
								(tcam.asset_meta->>''title_alias'')::text as title_alias,
								(tcam.asset_meta->>''desc'')::text as short_desc,
								(tcam.asset_meta->>''image_path'')::text as image_path,
								(tcam.asset_meta->>''image_name'')::text as image_file_name,
								(tcam.asset_meta->>''responsive'')::numeric as responsive,
								(tcam.asset_meta->>''mob_image_name'')::text as mob_image_name,
								(tcam.asset_meta->>''mob_image_path'')::text as mob_image_path, tab_c.asset_order
							from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
							join (select asset_id, asset_type_id, asset_order, is_fallback
									from (select (json_array_elements(a->''data'')->>''asset_id'')::numeric as asset_id,
												(json_array_elements(a->''data'')->>''asset_type_id'')::numeric as asset_type_id,
												(json_array_elements(a->''data'')->>''asset_order'')::numeric as asset_order,
												(json_array_elements(a->''data'')->>''is_fallback'')::numeric as is_fallback
											from (select $1::json as a) tab_a
										) tab_b
									where is_fallback = 0
								) tab_c
							on tab_c.asset_id = tcam.asset_id
							and tab_c.asset_type_id = tcam.asset_type_id
							where '||v_priority||' = 1
							union
							select al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, al.short_desc, al.image_path,
									al.image_file_name, (tcam.asset_meta->>''responsive'')::numeric as responsive,
									(tcam.asset_meta->>''mob_image_name'')::text as mob_image_name,
									(tcam.asset_meta->>''mob_image_path'')::text as mob_image_path, tab_c.asset_order
							from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
							join (select asset_id, asset_type_id, asset_order, is_fallback
									from (select (json_array_elements(a->''data'')->>''asset_id'')::numeric as asset_id,
												(json_array_elements(a->''data'')->>''asset_type_id'')::numeric as asset_type_id,
												(json_array_elements(a->''data'')->>''asset_order'')::numeric as asset_order,
												(json_array_elements(a->''data'')->>''is_fallback'')::numeric as is_fallback
											from (select $1::json as a) tab_a
										) tab_b
									where is_fallback = 0
								) tab_c
							on tab_c.asset_id = tcam.asset_id
							and tab_c.asset_type_id = tcam.asset_type_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
							on al.asset_id = tcam.asset_id
							and al.asset_type_id = tcam.asset_type_id
							where tcam.asset_type_id <> 12
							and '||v_priority||' = 0
							union
							select tcam.asset_id, tcam.asset_type_id, (tcam.asset_meta->>''title'')::text as asset_title,
								(tcam.asset_meta->>''title_alias'')::text as title_alias,
								(tcam.asset_meta->>''desc'')::text as short_desc,
								(tcam.asset_meta->>''image_path'')::text as image_path,
								(tcam.asset_meta->>''image_name'')::text as image_file_name,
								(tcam.asset_meta->>''responsive'')::numeric as responsive,
								(tcam.asset_meta->>''mob_image_name'')::text as mob_image_name,
								(tcam.asset_meta->>''mob_image_path'')::text as mob_image_path, tab_c.asset_order
							from '||p_schema_prefix||'.'||p_schema_prefix||'_template_component_asset_map tcam
							join (select asset_id, asset_type_id, asset_order, is_fallback
									from (select (json_array_elements(a->''data'')->>''asset_id'')::numeric as asset_id,
												(json_array_elements(a->''data'')->>''asset_type_id'')::numeric as asset_type_id,
												(json_array_elements(a->''data'')->>''asset_order'')::numeric as asset_order,
												(json_array_elements(a->''data'')->>''is_fallback'')::numeric as is_fallback
											from (select $1::json as a) tab_a
										) tab_b
									where is_fallback = 0
								) tab_c
							on tab_c.asset_id = tcam.asset_id
							and tab_c.asset_type_id = tcam.asset_type_id
							where tcam.asset_type_id = 12
							and '||v_priority||' = 0
							union
							select al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, al.short_desc, al.image_path,
									al.image_file_name, 0 as responsive, null as mob_image_name, null as mob_image_path,
									tab_c.asset_order
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
							join (select asset_id, asset_type_id, asset_order, is_fallback
									from (select (json_array_elements(a->''data'')->>''asset_id'')::numeric as asset_id,
												(json_array_elements(a->''data'')->>''asset_type_id'')::numeric as asset_type_id,
												(json_array_elements(a->''data'')->>''asset_order'')::numeric as asset_order,
												(json_array_elements(a->''data'')->>''is_fallback'')::numeric as is_fallback
											from (select $1::json as a) tab_a
										) tab_b
									where is_fallback = 1
								) tab_c
							on tab_c.asset_id = al.asset_id
							and tab_c.asset_type_id = al.asset_type_id
						) tab_d
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_author_action aa
					on aa.asset_id = tab_d.asset_id
					and aa.asset_type_id = tab_d.asset_type_id
					and aa.action_id = 4
					left join '||p_schema_prefix||'.'||p_schema_prefix||'_user u
					on u.user_id = aa.author_id
					order by asset_order
				) row'
	into p_showcase_json
	using v_assets_json;
	
	p_result := 1;
	
	if p_showcase_json is null then
		p_result := 0;
		p_showcase_json := '{"data":[]}'::jsonb;
	end if;
	
exception
	when others then
		p_result := -1;
		p_showcase_json := '{"data":[]}'::jsonb;
end;
$_$;


--
