-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: _get_sitemap_category_data(character varying, character varying, numeric, numeric, character varying, numeric, numeric)
-- Type: FUNCTION

-- Name: _get_sitemap_category_data(character varying, character varying, numeric, numeric, character varying, numeric, numeric); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf._get_sitemap_category_data(p_schema_prefix character varying, p_language_url character varying, p_sitemap_category_id numeric, p_time numeric, p_asset_type_id character varying, p_page_number numeric, p_item_number numeric, OUT p_sitemap_category_data_json jsonb) RETURNS jsonb
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
     -- v_str text;
	
begin
	
	-- raise notice '%',v_language_url;
	
	execute 'select erm.entity_role_map_id
			from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
			join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
			on erm.entity_master_id = em.entity_master_id
			join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_category ec
			on ec.entity_role_id = erm.entity_role_id
			where coalesce(em.canonical_url,'''||' '||''') = '''||replace(v_language_url,'/','')||'''
			and ec.category_name = '''||'Language'||''''
	into v_language_entity_role_map_id;
	
	-- where coalesce(em.canonical_url,'''||' '||''') = '''||case v_language_url when ' ' then v_language_url else '/'||v_language_url end||'''
	
	
		-- raise notice '%',v_language_entity_role_map_id;
		
	if v_language_entity_role_map_id is not null then
		v_page_language_filter_query := ' and exists(select 1 from '||p_schema_prefix||'.'||p_schema_prefix||'_asset_entity_map aem
											where aem.asset_id = p.page_id
											and aem.asset_type_id = 11
											and aem.entity_role_map_id = '||v_language_entity_role_map_id||')';
	end if;
	 
	 
     
	select sc.is_content_asset, coalesce(p_asset_type_id,sc.asset_type_id), cscm.entity_role_id
	into v_is_content_asset, v_asset_type_id, v_entity_role_id 
	from siwaf.siwaf_sitemap_category sc
	join siwaf.siwaf_client_sitemap_category_map cscm
	on cscm.sitemap_category_id = sc.category_id
	where cscm.client_code = p_schema_prefix
	and category_id = p_sitemap_category_id;
	
	--raise notice '%',v_is_content_asset;
	--raise notice '%',v_asset_type_id;
	--raise notice '%',v_entity_role_id;
	
	if v_is_content_asset = 1 then
     	/*v_str := 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
				from (select al.asset_title as title, al.title_alias, al.updated_date,
							lower(replace(pem.entity_name,'' '',''-'')) primary_entity_name,
							lower(replace(sem.entity_name,'' '',''-'')) secondary_entity_name
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
						where al.asset_type_id in(select asset_type_id::numeric
												from unnest(string_to_array('''||v_asset_type_id||''','','')) u(asset_type_id))
						and aem.entity_role_map_id = '||v_language_entity_role_map_id||
						' and al.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
          				and al.published_date <= '''||v_current_timestamp||'''
          				and al.is_published = 1
						order by al.published_date desc)row';
		raise notice 'v_str : %',v_str;
          select 1/0;*/
		execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
				from (select al.asset_title as title, al.title_alias, al.updated_date,
							lower(replace(pem.entity_name,'' '',''-'')) primary_entity_name,
							lower(replace(sem.entity_name,'' '',''-'')) secondary_entity_name
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
						where al.asset_type_id in(select asset_type_id::numeric
												from unnest(string_to_array('''||v_asset_type_id||''','','')) u(asset_type_id))
						and aem.entity_role_map_id = '||v_language_entity_role_map_id||' 
						-- and al.published_date >= timestamp '''||v_current_timestamp||''' - ('''||v_time||' hours'||''')::interval
          				-- and al.published_date <= '''||v_current_timestamp||'''
          				and al.is_published = 1
						order by al.published_date desc)row'
		into p_sitemap_category_data_json;
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
							and p.scheduled_publish <= '''||v_current_timestamp||''''
							||v_page_language_filter_query
							||') row'
			into p_sitemap_category_data_json;
			if p_sitemap_category_data_json is null then
				execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select p.alias as title_alias
							from '||p_schema_prefix||'.'||p_schema_prefix||'_page p
							where p.upfront = 1
							-- and p.show_in_sitemap = 1
							and p.is_published = 1
							and p.is_active = 1
							and p.is_deleted = 0
							and p.language_entity_role_map_id = '||v_language_entity_role_map_id||'
							and p.scheduled_publish <= '''||v_current_timestamp||''') row'
				into p_sitemap_category_data_json;
			end if;
		elsif p_sitemap_category_id in(4,5) then
			v_from_row_number := p_page_number * (p_item_number - (p_item_number - 1));
     		v_to_row_number := p_page_number * p_item_number;
			execute 'select ('''||'{"data":['||'''||string_agg(row_to_json(row)::text,'','')||'''||']}'||''')::jsonb
					from (select canonical_url as title_alias, updated_date
							from (select em.canonical_url, em.updated_date, row_number() over(order by em.updated_date desc) slno
									from '||p_schema_prefix||'.'||p_schema_prefix||'_entity_role_map erm
									join '||p_schema_prefix||'.'||p_schema_prefix||'_entity_master em
									on em.entity_master_id = erm.entity_master_id
									where entity_role_id = '||v_entity_role_id||'
								)tab
							where slno between '||v_from_row_number||' and '||v_to_row_number||
						')row'
			into p_sitemap_category_data_json;
		end if;
	end if;
	
/*exception
	when others then
		p_sitemap_category_data_json := '{"data":[]}'::jsonb;*/

end;

 

$$;


--
