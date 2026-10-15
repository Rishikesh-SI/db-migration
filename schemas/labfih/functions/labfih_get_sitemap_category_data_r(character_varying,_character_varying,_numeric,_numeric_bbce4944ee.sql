-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_get_sitemap_category_data_r(character varying, character varying, numeric, numeric, character varying, numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labfih_get_sitemap_category_data_r(character varying, character varying, numeric, numeric, character varying, numeric, numeric, numeric); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_get_sitemap_category_data_r(p_schema_prefix character varying, p_language_url character varying, p_sitemap_category_id numeric, p_time numeric, p_asset_type_id character varying, p_page_number numeric, p_item_number numeric, p_content_source_id numeric, OUT p_sitemap_category_data_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	
	v_language_url character varying(5) := coalesce(p_language_url,' ');
	v_language_entity_role_map_id numeric;
	v_page_language_filter_query text := ' ';
	v_is_content_asset numeric;
	v_asset_type_id character varying(10);
	v_entity_role_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_time numeric := coalesce(p_time, 48);
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_content_source_id numeric := p_content_source_id;
	v_content_source_filter_query text := ' ';
	
begin
	
	p_schema_prefix := 'labfih' ;
	
	if p_page_number is not null and p_item_number is not null then
		v_from_row_number := ((p_page_number - 1) * p_item_number) + 1;
		v_to_row_number := p_page_number * p_item_number;
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
	
	
	if v_content_source_id is not null then
    		
		v_content_source_filter_query := ' and (al.web_detail_jsn->''data''->>''content_source_id'')::text::numeric = '||v_content_source_id||'';
		
	end if;
	
	select sc.is_content_asset, coalesce(p_asset_type_id,sc.asset_type_id), cscm.entity_role_id
	into v_is_content_asset, v_asset_type_id, v_entity_role_id 
	from siwaf.siwaf_sitemap_category sc
	join siwaf.siwaf_client_sitemap_category_map cscm
	on cscm.sitemap_category_id = sc.category_id
	where cscm.client_code = p_schema_prefix
	and category_id = p_sitemap_category_id;
	
	if v_is_content_asset = 1 then
		
		if p_sitemap_category_id = 3 then
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select al.asset_title as title, al.title_alias, al.updated_date,
								coalesce(case when pem.canonical_url ~ ''^/'' then 
								RIGHT(pem.canonical_url, LENGTH(pem.canonical_url ) - 1) end,
								lower(replace(pem.canonical_url,'' '',''-''))) primary_entity_name,
								coalesce(case when sem.canonical_url ~ ''^/'' then 
								RIGHT(sem.canonical_url, LENGTH(sem.canonical_url ) - 1) end,
								lower(replace(sem.canonical_url,'' '',''-''))) secondary_entity_name,
								al.image_path||al.image_file_name as thumbnail_image, i.image_caption,
								row_number() over(order by al.published_date desc) slno
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
							join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
							on aem.asset_id = al.asset_id
							and aem.asset_type_id = al.asset_type_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
							on perm.entity_role_map_id = al.primary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
							on pem.entity_master_id = perm.entity_master_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
							on serm.entity_role_map_id = al.secondary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
							on sem.entity_master_id = serm.entity_master_id
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_album_asset_map aam
							on aam.album_id = al.asset_id
							and al.asset_type_id = 2
							and aam.is_cover = 1
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
							on i.image_id = aam.asset_id
							and aam.asset_type_id = 3
							where al.asset_type_id in(select asset_type_id::numeric
													from unnest(string_to_array('''||v_asset_type_id||''','','')) u(asset_type_id))
							and aem.entity_role_map_id = '||v_language_entity_role_map_id||
							' and al.published_date <= '''||v_current_timestamp||'''
          					and al.is_published = 1 '
                        			||v_content_source_filter_query||
						')row
					where slno between '||v_from_row_number||' and '||v_to_row_number
			into p_sitemap_category_data_json;
			
			
		else
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select al.asset_title as title, al.title_alias, al.updated_date,
								lower(replace(pem.entity_name,'' '',''-'')) primary_entity_name,
								lower(replace(sem.entity_name,'' '',''-'')) secondary_entity_name,
								al.image_path||al.image_file_name as thumbnail_image, i.image_caption,
								 cp.content_provider_name as publisher,
								(select string_agg(em2.entity_name,'','') from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem1
								left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm2 on aem1.entity_role_map_id = erm2.entity_role_map_id
								left join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em2 on erm2.entity_master_id = em2.entity_master_id 
								where asset_id = al.asset_id and asset_type_id = al.asset_type_id) entities
							from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_list al
							join '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
							on aem.asset_id = al.asset_id
							and aem.asset_type_id = al.asset_type_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map perm
							on perm.entity_role_map_id = al.primary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master pem
							on pem.entity_master_id = perm.entity_master_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map serm
							on serm.entity_role_map_id = al.secondary_entity_role_map_id
							join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master sem
							on sem.entity_master_id = serm.entity_master_id
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_album_asset_map aam
							on aam.album_id = al.asset_id
							and al.asset_type_id = 2
							and aam.is_cover = 1
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_image i
							on i.image_id = aam.asset_id
							and aam.asset_type_id = 3
							left join '||p_schema_prefix||'.'||p_schema_prefix||'_content_provider cp
							on (al.web_detail_jsn->''data''->>''content_source_id'')::numeric = cp.content_provider_id
							
							where al.asset_type_id in(select asset_type_id::numeric
													from unnest(string_to_array('''||v_asset_type_id||''','','')) u(asset_type_id))
							and aem.entity_role_map_id = '||v_language_entity_role_map_id||
							' and al.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
          					and al.published_date <= '''||v_current_timestamp||'''
          					and al.is_published = 1 '
                        			||v_content_source_filter_query||
							'  order by al.published_date desc limit 10)row'
			into p_sitemap_category_data_json;
			
			-- raise notice '%',p_sitemap_category_data_json;
			
		end if;
		
	else
		
		if p_sitemap_category_id = 1 then
			
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select p.alias as title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.is_amp = 0
							and p.scheduled_publish <= '''||v_current_timestamp||''''
							||v_page_language_filter_query
							||') row'
			into p_sitemap_category_data_json;
			
			if p_sitemap_category_data_json is null then
				
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select p.alias as title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.is_amp = 0
							and p.language_entity_role_map_id = '||v_language_entity_role_map_id||'
							and p.scheduled_publish <= '''||v_current_timestamp||''') row'
				into p_sitemap_category_data_json;
				
			end if;
			
		
		
		
		
	end if;
	
	end if;
	
	
	
-- exception
--	when others then
--		p_sitemap_category_data_json := '{"data":[]}'::jsonb;

end;
$$;


--
