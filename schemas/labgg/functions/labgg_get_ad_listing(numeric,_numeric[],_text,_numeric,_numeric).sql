-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgg
-- Object: labgg_get_ad_listing(numeric, numeric[], text, numeric, numeric)
-- Type: FUNCTION

-- Name: labgg_get_ad_listing(numeric, numeric[], text, numeric, numeric); Type: FUNCTION; Schema: labgg; Owner: -
--

CREATE FUNCTION labgg.labgg_get_ad_listing(p_status numeric, p_entity_arr numeric[], p_search_keyword text, p_page_number numeric, p_item_number numeric, OUT p_ad_listing jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_ad_asset_type_id numeric := 16;
	v_search_query text;
	v_entity_count numeric;
	v_asset_id_arr numeric[];
	v_entity_filter_query text;
	v_position_entity numeric;
	v_from_row_number numeric;
	v_to_row_number numeric;
	v_assets_json json;
	v_position_entity_query text;

begin

	v_from_row_number := (p_page_number * p_item_number - (p_item_number - 1));
    v_to_row_number   := (p_page_number * p_item_number);

	if p_search_keyword is not null and p_search_keyword <> '' then

      p_search_keyword:=upper(p_search_keyword);
		if p_status = 0 then
			v_search_query := ' and asset_data->''data''->>''title'' like ''%''||'||'$2'||'||''%'' ';
		elsif p_status in(1,2) then
			v_search_query := ' and upper(ad_title) like ''%''||'||'$2'||'||''%'' ';
		else
			v_search_query := ' ';
		end if;

	else
		v_search_query := ' ';
	end if;

	select count(1) into v_entity_count from (select entity_id from unnest(p_entity_arr) u(entity_id)) a;

	if v_entity_count > 0 then

		select entityid from unnest(p_entity_arr) u(entityid)
		where entityid in(select erm.entity_role_map_id
							from labgg.labgg_entity_category ec
							join labgg.labgg_entity_role_map erm
							on erm.entity_role_id = ec.entity_role_id
							join labgg.labgg_entity_master em
							on em.entity_master_id = erm.entity_master_id
							where category_name = 'Ad Positions')
		into v_position_entity;

		if v_position_entity is not null then
			if p_status = 0 then
				v_position_entity_query := ' and (asset_data->''data''->>''ad_position'')::numeric = $6 ';
			elsif p_status in (1,2) then
				v_position_entity_query := ' a.ad_position = $5 ';
			else
				v_position_entity_query := ' ';
			end if;
		else
			v_position_entity_query := ' ';
		end if;

		if p_status = 0 then

			execute 'with entitydata(t_json)
					as (select (asset_data->''data''->>''entitydata'')::json, asset_draft_id
						from labgg.labgg_asset_draft ad
						where asset_type_id = $1
						and version_number = (select max(version_number) from labgg.labgg_asset_draft adi where adi.asset_id = ad.asset_id
												and adi.asset_type_id = ad.asset_type_id)
						and (asset_data->''data''->>''entitydata'') is not null
						order by ad.updated_date desc)
					select array(select asset_draft_id
									from(select obj->>''entity_role_map_id'', asset_draft_id
											from entitydata ci, json_array_elements(ci.t_json#>''{}'') obj
											where (obj->>''entity_role_map_id'')::numeric in (select entityid from unnest($2) u(entityid)))jd
									group by asset_draft_id
									having count(1) = $3)'
			into v_asset_id_arr
			using v_ad_asset_type_id, p_entity_arr, (v_entity_count - 1);

			v_entity_filter_query := ' and ad.asset_draft_id in(select asset_draft_id from unnest($3) u(asset_draft_id))';

		elsif p_status in(1,2) then

			v_entity_filter_query := ' and exists(select 1 from labgg.labgg_asset_entity_map eam
													where eam.asset_id = a.ad_id
													and eam.asset_type_id = $1
													and eam.entity_role_map_id in (select entityid from unnest($3) u(entityid))
													group by eam.asset_id
													having count(1) = $4)';

		else

			v_entity_filter_query := ' ';
			v_position_entity_query := ' ';

		end if;

	else

		v_entity_filter_query := ' ';
		v_position_entity_query := ' ';

	end if;

	if p_status = 0 then

		execute 'select (''{"ads":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
					from (select *
							from (select ad_id,title,version_number,guid,position_name,is_default,is_detail,entities,clients,
											row_number() over (order by modified_date desc) slno
									from (select ad.asset_data->''data''->>''ad_id'' ad_id, ad.asset_data->''data''->>''title'' title,
													ad.version_number, ad.asset_data->''data''->>''guid'' guid, em.entity_name position_name,
													ad.asset_data->''data''->>''is_default'' is_default,ad.asset_data->''data''->>''is_detail'' is_detail,
													ad.asset_data->''data''->>''modified_date'' modified_date,
													(select string_agg((c->>''name''),'','')::text
														from (select json_array_elements(a::json) c
																from (select (ad.asset_data->''data''->>''entitydata'')::jsonb a) b) d
														where (c->>''entity_role_map_id'')::numeric <> 4) entities,
													string_agg(ac.ad_client_name,'','') clients
											from labgg.labgg_asset_draft ad
											join labgg.labgg_entity_role_map erm
											on erm.entity_role_map_id = (ad.asset_data->''data''->>''ad_position'')::numeric
											join labgg.labgg_entity_master em
											on em.entity_master_id = erm.entity_master_id
											join labgg.labgg_asset_draft ad2
											on ad2.asset_draft_id = ad.asset_draft_id
											join labgg.labgg_ad_client ac
											on ac.ad_client_id =any(string_to_array(ad2.asset_data->''data''->>''ad_client'','','')::numeric[])
				 							where ad.asset_type_id = $1'
											||v_position_entity_query||
				 							'and ad.version_number = (select max(ad1.version_number)
																		from labgg.labgg_asset_draft as ad1
																		where ad1.asset_id = ad.asset_id and ad1.asset_type_id = ad.asset_type_id)
				 							and ((exists (select 1 from labgg.labgg_advertisement a
															where a.ad_id = ad.asset_id and a.is_published = 0 and a.is_trashed = 0))
					  							or (ad.version_number > (select max(a.published_version_number) from labgg.labgg_advertisement a
																			where a.ad_id = ad.asset_id)))'
				 							||v_search_query
				 							||v_entity_filter_query
				 							||'
											group by ad.asset_data->''data''->>''ad_id'',ad.asset_data->''data''->>''title'',ad.version_number,
														ad.asset_data->''data''->>''guid'',em.entity_name,ad.asset_data->''data''->>''is_default'',
														ad.asset_data->''data''->>''is_detail'',ad.asset_data->''data''->>''modified_date'',
														ad.asset_data) tab
									) tab1
							where slno between $4 and $5
						)row'
		into p_ad_listing
		using v_ad_asset_type_id, p_search_keyword, v_asset_id_arr, v_from_row_number, v_to_row_number, v_position_entity;

		select coalesce(json_array_length((a->>'ads')::json),0)
    	into p_result
    	from (select p_ad_listing as a) b;

	elsif p_status in(1,2) then

		execute 'select (''{"assets":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
					from (select ad_id,slno
							from(select ad_id,
										row_number() over(order by case '||p_status||' when 1 then a.published_date else a.updated_date end desc) slno
									from labgg.labgg_advertisement as a
									left join labgg.labgg_asset_entity_map aem
                    				on aem.asset_id = a.ad_id
                    				and aem.asset_type_id = $1
									where a.is_published = case '||p_status||' when 1 then 1 else 0 end
									and a.is_trashed = case '||p_status||' when 1 then 0 else 1 end
									and a.is_deleted = 0'
									||v_position_entity_query
									||v_search_query
									||v_entity_filter_query
									||') a) row'
		into v_assets_json
		using v_ad_asset_type_id, p_search_keyword, p_entity_arr, v_entity_count, v_position_entity;

		execute 'select (''{"ads":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
					from (select ad_id,title,version_number,guid,position_name,is_default,entities,clients,is_detail,
									row_number() over(order by case '||p_status||' when 1 then published_date else updated_date end desc) slno
							from (select a.ad_id,a.ad_title title,a.published_version_number version_number,a.ad_guid guid,em.entity_name as "position_name",
											a.published_date,a.updated_date,a.is_default,string_agg(distinct em1.entity_name,'','') entities,
											string_agg(distinct ac.ad_client_name,'','') clients, a.is_detail
									from labgg.labgg_advertisement as a
									join labgg.labgg_entity_role_map erm
									on erm.entity_role_map_id = a.ad_position
									join labgg.labgg_entity_master em
									on em.entity_master_id = erm.entity_master_id
									join labgg.labgg_advertisement a1
									on a1.ad_id = a.ad_id
									join labgg.labgg_ad_client ac
									on ac.ad_client_id =any(a1.ad_client)
									left join labgg.labgg_asset_entity_map aem
									on aem.asset_id = a.ad_id
									and aem.asset_type_id = $4
									and aem.entity_role_map_id <> 4
									left join labgg.labgg_entity_role_map erm1
									on erm1.entity_role_map_id = aem.entity_role_map_id
									left join labgg.labgg_entity_master em1
									on em1.entity_master_id = erm1.entity_master_id
									where a.ad_id in(select ad_id
														from (select (json_array_elements(a->''assets'')->>''ad_id'')::numeric ad_id,
																		(json_array_elements(a->''assets'')->>''slno'')::numeric slno
																from (select $1 as a) b) c
																where slno between $2 and $3)
									group by a.ad_id,a.ad_title,a.published_version_number,a.ad_guid,em.entity_name,a.published_date,a.updated_date)d
						) row'
		into p_ad_listing
		using v_assets_json, v_from_row_number, v_to_row_number, v_ad_asset_type_id;

		select coalesce(json_array_length((a->>'ads')::json),0)
    	into p_result
    	from (select p_ad_listing as a) b;

	else

		p_result := -1;

	end if;

/*exception
	when others then
		p_result := -1;*/

end;

$_$;


--
