-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_get_asset_listing_rtest(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[])
-- Type: FUNCTION

-- Name: labpkl_get_asset_listing_rtest(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric[]); Type: FUNCTION; Schema: labpkl; Owner: -
--

CREATE FUNCTION labpkl.labpkl_get_asset_listing_rtest(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_exclude_ent_id numeric[], OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

 
declare
	
	v_fromrownumber numeric;
    	v_torownumber numeric;
	v_entityrole_mapid numeric[] := p_entityrole_mapid;
	v_entity_count numeric;
	v_any_entity_count numeric;
	v_language_erm_id numeric;
	v_language_em_id numeric;
	v_random_erm_id numeric;
	v_random_query text := ' ';
	v_entity_role_map_id_str text;
	v_search_keyword text := p_searchkeyword;
	v_entity_search_query text := ' ';
	v_any_entity_role_map_id_query text := ' ';
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_arr_asset_list_id numeric[];
	v_asset_count numeric;
	v_asset_list_id_str text;
	v_assetcount numeric;
	
begin
	
	set enable_seqscan = off;
     
	if p_pagenumber is not null and p_itemnumber is not null then
		if p_page1_size is null then
			v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
			v_torownumber := (p_pagenumber * p_itemnumber);
		else
			if p_pagenumber = 1 then
				v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
          	else
          		v_fromrownumber := p_page1_size + ((((p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
          	end if;
   			v_torownumber := p_page1_size + ((p_pagenumber-1) * p_itemnumber);
		end if;
	end if;
	
	raise notice 'v_fromrownumber : %',v_fromrownumber;
	raise notice 'v_torownumber : %',v_torownumber;
	
	select count(distinct entity_id) into v_entity_count from unnest(v_entityrole_mapid) u(entity_id);
	
	raise notice 'v_entity_count : %',v_entity_count;
	
	if v_entity_count <> 0 then
		
		select erm.entity_role_map_id, erm.entity_master_id
		into v_language_erm_id, v_language_em_id
		from labpkl.labpkl_entity_category ec
		join labpkl.labpkl_entity_role_map erm
		on ec.entity_role_id = erm.entity_role_id
		where category_name = 'Language'
		and erm.entity_role_map_id in(select entity_role_map_id from unnest(v_entityrole_mapid) u(entity_role_map_id));	
    		
		select erm.entity_role_map_id
		into v_random_erm_id
		from labpkl.labpkl_entity_master em
		join labpkl.labpkl_entity_role_map erm
		on erm.entity_master_id = em.entity_master_id
		where em.entity_name = 'Random'
		and erm.entity_role_map_id in(select entity_role_map_id from unnest(v_entityrole_mapid) u(entity_role_map_id));
		
		if v_random_erm_id is not null then
			select array(select entity_role_map_id
					   from unnest(v_entityrole_mapid) u(entity_role_map_id)
					   where entity_role_map_id <> v_random_erm_id)
			into v_entityrole_mapid;
			v_entity_count := v_entity_count - 1;
			v_random_query := ' order by random() ';
		end if;
		
		v_entity_role_map_id_str := '{'||array_to_string(v_entityrole_mapid,',')||'}';
		
		raise notice 'v_entity_role_map_id_str : %',v_entity_role_map_id_str;
		
	end if;
	
    	if v_search_keyword is not null then
     	
		v_search_keyword := '*'||replace(''||v_search_keyword||'',' ',':* & *')||':*';
		v_entity_search_query := ' and (to_tsvector(sl.asset_title) @@@ to_tsquery('''||v_search_keyword||''')
									or to_tsvector(sl.short_desc) @@@ to_tsquery('''||v_search_keyword||'''))';
		
     end if;
	
     select count(distinct entity_id) into v_any_entity_count from unnest(p_any_entityrole_mapid) u(entity_id);
	
    	if v_any_entity_count > 0 then
    		v_any_entity_role_map_id_query := 'and sl.tagged_entity && $3';
    	end if;
		
		execute 'select count(1)
								from labpkl.labpkl_asset_list sl
								where sl.is_active = 1
								and sl.is_deleted = 0
								and sl.is_published = 1
								and sl.published_date <= '''||v_current_timestamp||'''
								and sl.asset_type_id in (1,2,4,5)
								and sl.asset_type_id in (case
														when $1 is not null then(select asset_type_id from unnest($1) u(asset_type_id))
														else sl.asset_type_id
                    									end)
								and sl.tagged_entity @> $2'
     							||v_any_entity_role_map_id_query
								||v_entity_search_query
								
	into v_assetcount
	using p_asset_type_id, v_entityrole_mapid::int[],	p_any_entityrole_mapid::int[], coalesce(v_random_erm_id,0);
	
    	execute 'select array(select asset_list_id
						from (select sl.asset_list_id,
									case $4
										when 0 then row_number() over (order by sl.published_date desc)
										else row_number() over (order by random())
									end as rno
								from labpkl.labpkl_asset_list sl
								where sl.is_active = 1
								and sl.is_deleted = 0
								and sl.is_published = 1
								and sl.published_date <= '''||v_current_timestamp||'''
								and sl.asset_type_id in (1,2,4,5)
								and sl.asset_type_id in (case
														when $1 is not null then(select asset_type_id from unnest($1) u(asset_type_id))
														else sl.asset_type_id
                    									end)
								and sl.tagged_entity @> $2'
     							||v_any_entity_role_map_id_query
								||v_entity_search_query
								||') as tab
						where rno between '||v_fromrownumber||' and '||v_torownumber||'
					)'
	into v_arr_asset_list_id
	using p_asset_type_id, v_entityrole_mapid::int[],	p_any_entityrole_mapid::int[], coalesce(v_random_erm_id,0);
    	
		raise notice 'v_arr_asset_list_id : %',v_arr_asset_list_id;
		
    	v_asset_count := array_length(v_arr_asset_list_id, 1);
    	v_asset_list_id_str := '{'||array_to_string(v_arr_asset_list_id,',')||'}';
		
		raise notice 'v_asset_count : %',v_asset_count;
		raise notice 'v_asset_list_id_str : %',v_asset_list_id_str;
    	
	execute 'select (''{"items":''||json_agg(row)::text||''}'')::jsonb
			from (select *
					from (select sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias,
								sl.author_id, sl.short_desc, sl.tags, sl.primary_entity_role_map_id,
								sl.secondary_entity_role_map_id, sl.total_assets, sl.image_file_name,
								sl.image_path, sl.duration, sl.show_in_web, sl.show_in_mobile, sl.show_in_app,
								sl.published_version_number, sl.is_trashed, sl.created_date, sl.updated_date,
								sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published,
								sl.published_date, sl.asset_guid, sl.show_copyright, sl.order_number,
								sl.image_file_name, sl.image_path,
								(row_number() over (order by sl.published_date desc) + '||(v_fromrownumber-1)||') as rno,
								u.display_name, u.user_name, u.full_name,
								emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name,
								coalesce(pel.entity_display_name, emp.entity_display_name) pri_ent_disp_name,
								coalesce(sel.entity_display_name, ems.entity_display_name) sec_ent_disp_name,
								sl.short_title
							from labpkl.labpkl_asset_list sl
							left join labpkl.labpkl_user u
							on u.user_id = sl.author_id
							join labpkl.labpkl_entity_role_map ermp
							on ermp.entity_role_map_id = sl.primary_entity_role_map_id
							join labpkl.labpkl_entity_role_map erms
							on erms.entity_role_map_id = sl.secondary_entity_role_map_id
							join labpkl.labpkl_entity_master emp
							on emp.entity_master_id = ermp.entity_master_id
							left join labpkl.labpkl_entity_language_map pel
							on emp.entity_master_id = pel.entity_master_id
							and pel.language_master_id = '||v_language_em_id||'
							join labpkl.labpkl_entity_master ems
							on ems.entity_master_id = erms.entity_master_id
							left join labpkl.labpkl_entity_language_map sel
							on ems.entity_master_id=sel.entity_master_id
							and sel.language_master_id ='||v_language_em_id||'
							where sl.asset_list_id =any ($1::numeric[])
						)  as tab1
					-- where rno between '||v_fromrownumber||' and '||v_torownumber||'
				) row'
	into p_assetjson
	using v_asset_list_id_str;
     
	 raise notice 'p_assetjson : %',p_assetjson;
	 
	if p_assetjson is not null then
		-- select count(1) from (select json_array_elements((p_assetjson->'items')::json)) as tab into p_assetcount;
		
		p_assetcount := v_assetcount;
	else
		p_assetcount := 0;
          p_assetjson := '{"items":[]}';
	end if;
  -- select 1/0;  
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
