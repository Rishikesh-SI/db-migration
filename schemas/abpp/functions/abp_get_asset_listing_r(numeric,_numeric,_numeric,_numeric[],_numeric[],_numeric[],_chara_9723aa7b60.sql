-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric)
-- Type: FUNCTION

-- Name: abp_get_asset_listing_r(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying, numeric); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_asset_listing_r(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_author_id numeric, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

declare
	
	v_sysdate timestamp;
	v_fromrownumber numeric;
    v_torownumber numeric;
	v_ent_count numeric;
	v_language_id numeric;
    v_language_mast_id numeric;
	v_str_entityrole_mapid text;
	v_anyentityrolemapidquery text := ' ';
	v_assettypeidfilterquery text := ' ';
	v_searchkeyword text := p_searchkeyword;
    v_entitysearchquery text := ' ';
	v_author_filter_query text := ' ';
	v_assetsjson json;
	v_assetidjson json;
	
begin

-- changes track
-- last change by rakesh bhatkar 
-- As per mail changes:- published_date to updated_date desc date 28/03/2018
	
	v_sysdate:= current_timestamp at time zone 'utc';
	
	if p_page1_size is null then
		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		v_torownumber := (p_pagenumber * p_itemnumber);
	else
		if (p_pagenumber = 1) then
			v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else 
          	v_fromrownumber := p_page1_size + ((((p_pagenumber-1) * p_itemnumber) - (p_itemnumber - 1)));
		end if;
		v_torownumber := p_page1_size + ((p_pagenumber-1) * p_itemnumber);
	end if;
	
	select count(1) from unnest(p_entityrole_mapid) into v_ent_count;
	
	select entityid, entity_master_id
	from unnest(p_entityrole_mapid) u(entityid)
	join abp.abp_entity_role_map erm
	on erm.entity_role_map_id = u.entityid
	where entityid in (select erm.entity_role_map_id
						from abp.abp_entity_category ec
						join abp.abp_entity_role_map erm
						on erm.entity_role_id = ec.entity_role_id
						join abp.abp_entity_master em
						on em.entity_master_id = erm.entity_master_id
						where ec.category_name = 'Language')
	into v_language_id, v_language_mast_id;
	
	v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
	
	if (select count(1) from unnest(p_any_entityrole_mapid)) > 0 then
		v_anyentityrolemapidquery := ' and exists (select 1 from abp.abp_asset_entity_map eam
													where eam.asset_id = sl.asset_id
                                         			and eam.asset_type_id = sl.asset_type_id
                                         			and eam.entity_role_map_id in (select any_entity_role_mapid
																					from unnest($3) u(any_entity_role_mapid))) ';
	end if;
	
	if (select count(1) from unnest(p_asset_type_id)) > 0 then
		v_assettypeidfilterquery := ' and sl.asset_type_id in (select asset_type_id from unnest($1) U(asset_type_id)) ';
	end if;
	
	if v_searchkeyword is not null then
		v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
		v_entitysearchquery := ' and (to_tsvector(sl.asset_title) @@@ to_tsquery('''||v_searchkeyword||''')
										or to_tsvector(sl.short_desc) @@@ to_tsquery('''||v_searchkeyword||'''))';
	end if;
	
	if p_author_id is not null then
		
        v_author_filter_query := ' and exists (select 1 from abp.abp_author_action aa
												where aa.author_id = '||p_author_id||'
												and aa.action_id = 4
                   								and aa.asset_id = sl.asset_id
                   								and aa.asset_type_id = sl.asset_type_id) ';
        
    end if;
	
	execute 'select (''{"assets":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
				from (select sl.asset_list_id, row_number() over (order by sl.published_date desc) as slno
						from abp.abp_asset_list sl
						where (case when sl.asset_type_id=5 then 1 else sl.asset_type_id end ) in (1,2,4)
						and sl.published_date <= '''||v_sysdate||'''
						and sl.is_published = 1 '
						||v_assettypeidfilterquery
						||' and exists(select 1 from abp.abp_asset_entity_map eam
										where eam.asset_id = sl.asset_id
                   						and eam.asset_type_id = sl.asset_type_id
                   						and eam.entity_role_map_id =any ($2::numeric[])
                        				group by eam.asset_id, eam.asset_type_id
                        				having count(1) = '||v_ent_count||') '
						||v_anyentityrolemapidquery
     					||v_entitysearchquery
     					||v_author_filter_query
						||') row'
	into v_assetsjson
	using p_asset_type_id,v_str_entityrole_mapid,p_any_entityrole_mapid;
	
	select ('{"assets":['||string_agg((row_to_json(row))::text,',')||']}')::json
    from (select alid
          from(select (json_array_elements(a->'assets')->>'asset_list_id')::numeric alid,(json_array_elements(a->'assets')->>'slno')::numeric slno
               from (select v_assetsjson as a) b) c
          where slno between v_fromrownumber and v_torownumber)row
	into v_assetidjson;
	
	select coalesce(json_array_length((a->>'assets')::json),0)
    into p_assetcount
    from (select v_assetsjson as a) b;
	
    if p_assetcount > 0 then
   		execute 'select (''{"items":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::jsonb
        			from (select sl.asset_list_id,sl.asset_id,sl.asset_type_id,sl.asset_title,sl.title_alias,sl.author_id,short_desc,tags,
                    				primary_entity_role_map_id,secondary_entity_role_map_id,total_assets,image_file_name,image_path,duration,show_in_web,
									show_in_mobile,show_in_app,published_version_number,sl.is_trashed,sl.created_date,sl.updated_date,sl.created_by,
									sl.updated_by,sl.short_title,sl.is_active,sl.is_deleted,sl.is_published,published_date,asset_guid,show_copyright,
									order_number,image_file_name,image_path,u.display_name user_name,emp.entity_name primary_entity_name,
									ems.entity_name secondary_entity_name,coalesce(pel.entity_display_name,emp.entity_display_name) pri_ent_disp_name,
									coalesce(sel.entity_display_name,ems.entity_display_name) sec_ent_disp_name
							from abp.abp_asset_list sl
							join abp.abp_user u
							on u.user_id = sl.author_id
							join abp.abp_entity_role_map ermp
							on ermp.entity_role_map_id = sl.primary_entity_role_map_id
							join abp.abp_entity_role_map erms
							on erms.entity_role_map_id = sl.secondary_entity_role_map_id
							join abp.abp_entity_master emp
							on emp.entity_master_id = ermp.entity_master_id
							join abp.abp_entity_master ems
							on ems.entity_master_id = erms.entity_master_id
							left join abp.abp_entity_language_map pel
							on emp.entity_master_id=pel.entity_master_id
							and pel.language_master_id = '||v_language_mast_id||'
							left join abp.abp_entity_language_map sel
							on ems.entity_master_id=sel.entity_master_id
							and sel.language_master_id = '||v_language_mast_id||'
							where sl.asset_list_id in (select (json_array_elements(a->''assets'')->>''alid'')::numeric from (select $1 as a) b)
							order by sl.published_date desc'
							||') row'
		into p_assetjson
		using v_assetidjson,v_fromrownumber,v_torownumber;
    else
    	p_assetjson := '{"items":[]}'::jsonb;
    end if;
	
     if p_assetjson is null
    then 
    p_assetjson := '{"items":[]}'::jsonb;
    end if ;
exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';
     
end;

$_$;


--
