-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_asset_listing_rold1106(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: yho_get_asset_listing_rold1106(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_asset_listing_rold1106(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from yho.yho_get_asset_listing_r_test(
	1,-- <p_pagenumber numeric>, 
	25,-- <p_itemnumber numeric>, 
	25,-- <p_page1_size numeric>, 
	array[35368,35369],-- <p_entityrole_mapid numeric[]>, 
	array[35521],-- <p_any_entityrole_mapid numeric[]>, 
	null,-- <p_asset_type_id numeric[]>, 
	null-- <p_searchkeyword character varying>, 
);
*/

declare
	
    v_sysdate timestamp := current_timestamp at time zone 'utc';
	v_entitycount numeric;
	v_entitycountall numeric;
	v_anyentitycount numeric;
    v_anyentityrolemapidquery text := ' ';
	v_entityrolemapidarr numeric[] := p_entityrole_mapid;
	v_fromrownumber numeric;
	v_torownumber numeric;
	v_searchkeyword text := lower(p_searchkeyword);
	v_entitysearchquery text := ' ';
	v_assettypeidcount numeric;
    v_assettypeidarr numeric[];
	v_assettypeidquery text;
	v_assetlistidarr numeric[];
    v_languageermid numeric;
    v_languagecanonicalurl text;
    v_itemnumber numeric;
    /*v_twomonths timestamp  = (v_sysdate - '600 hours'::interval);*/
    
begin
	
	select count(distinct entityid) into v_entitycount from unnest(p_entityrole_mapid) entityid;
	select count(distinct entityid) into v_anyentitycount from unnest(p_any_entityrole_mapid) entityid;
    
   	if v_anyentitycount <> 0 then
		v_anyentityrolemapidquery := ' and exists (select 1
        								from yho.yho_asset_entity_map eam
                                        where eam.asset_id = sl.asset_id
                                        and eam.asset_type_id = sl.asset_type_id 
                                        and eam.entity_role_map_id in (select unnest($3))) ';
    end if;
	
    if p_page1_size is null then
		v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		v_torownumber := (p_pagenumber * p_itemnumber);
	else
		if p_pagenumber = 1 then
			v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else
        	v_fromrownumber := p_page1_size + (((p_pagenumber - 1) * p_itemnumber) - (p_itemnumber - 1));
		end if;
        v_torownumber := p_page1_size + ((p_pagenumber - 1) * p_itemnumber);
	end if;
    
    if v_searchkeyword is not null then
		v_searchkeyword := '*'||replace(''||v_searchkeyword||'',' ',':* & *')||':*';
		v_entitysearchquery := ' and (to_tsvector(sl.asset_title) @@@ to_tsquery('''||v_searchkeyword||''') 
										or to_tsvector(sl.short_desc) @@@ to_tsquery('''||v_searchkeyword||'''))';
	end if;
    
	select count(1) into v_assettypeidcount from unnest(p_asset_type_id);
	
	if v_assettypeidcount = 0 then
    	v_assettypeidarr := '{{1},{2},{4},{5}}'::numeric[];
	else
		v_assettypeidarr := p_asset_type_id;
	end if;
	
    v_assettypeidquery := ' and asset_type_id in (select unnest($1)) ';
	
    execute 'select string_to_array(string_agg(asset_list_id::text,'',''),'',''), rowcount
				from (select asset_list_id,row_number() over(order by custom_priority, published_date desc) rno, count(asset_list_id) over() rowcount
						from yho.yho_asset_list sl
						where published_date <= '''||v_sysdate||'''
						and is_published = 1
						and is_trashed = 0
						and is_active = 1
						and is_deleted = 0
						
						'
						||v_assettypeidquery||
						' and exists (select 1
									from yho.yho_asset_entity_map eam
									where eam.asset_id = sl.asset_id
									and eam.asset_type_id = sl.asset_type_id 
									and eam.entity_role_map_id in (select unnest($2))
									group by eam.asset_id, eam.asset_type_id
									having count(1) = '||v_entitycount||')'
						||v_anyentityrolemapidquery
                        ||v_entitysearchquery||') tab
				where rno between '||v_fromrownumber||' and '||v_torownumber||'
				group by rowcount'
	into v_assetlistidarr, p_assetcount
    using v_assettypeidarr, p_entityrole_mapid, p_any_entityrole_mapid;-- v_entityrolemapidarr;
    
    /*select coalesce(em.canonical_url,'null') into v_languagecanonicalurl
    from yho.yho_entity_category ec
    join yho.yho_entity_role_map erm
    on erm.entity_role_id = ec.entity_role_id
    join yho.yho_entity_master em
    on em.entity_master_id = erm.entity_master_id
    where ec.category_name = 'Language'
    and erm.entity_role_map_id in(select unnest(p_entityrole_mapid));*/
    
    select erm.entity_role_map_id into v_languageermid
    from yho.yho_entity_category ec
    join yho.yho_entity_role_map erm
    on erm.entity_role_id = ec.entity_role_id
    where ec.category_name = 'Language'
    and erm.entity_role_map_id in(select unnest(p_entityrole_mapid));
    
    if v_languageermid is null then
    	v_languageermid := 35369;
    end if;
    
    select coalesce(em.canonical_url,'null') into v_languagecanonicalurl
    from yho.yho_entity_master em
    join yho.yho_entity_role_map erm
    on erm.entity_master_id = em.entity_master_id
    where erm.entity_role_map_id = v_languageermid;
    
    execute 'select (''{"items":[''||string_agg((row_to_json(row))::text,'','')||'']}'')::json
				from (select sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, sl.author_id, sl.short_desc, sl.tags,
								sl.primary_entity_role_map_id, sl.secondary_entity_role_map_id, sl.total_assets, image_file_name, image_path,
								sl.duration, sl.show_in_web, sl.show_in_mobile, sl.show_in_app, sl.published_version_number, sl.is_trashed,
								sl.created_date, sl.updated_date, sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published,
								sl.published_date, sl.asset_guid, sl.show_copyright, order_number, image_file_name, image_path, u.full_name user_name,
								emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name, emp.entity_display_name pri_ent_disp_name,
								ems.entity_display_name sec_ent_disp_name, sl.short_title,
                                '||case v_languagecanonicalurl when 'null' then v_languagecanonicalurl else '"'||v_languagecanonicalurl||'"' end||' as lang_curl,
								cp.content_provider_id content_source_id, cp.content_provider_name, custom_priority
						from yho.yho_asset_list sl
                        join yho.yho_author_action aa
						on aa.asset_id = sl.asset_id
						and aa.asset_type_id = sl.asset_type_id
						and aa.action_id = 4
						join yho.yho_user u
						on u.user_id = aa.author_id
						join yho.yho_entity_role_map ermp
						on ermp.entity_role_map_id = sl.primary_entity_role_map_id
						join yho.yho_entity_master emp
						on emp.entity_master_id = ermp.entity_master_id
						join yho.yho_entity_role_map erms
						on erms.entity_role_map_id = sl.secondary_entity_role_map_id
						join yho.yho_entity_master ems
						on ems.entity_master_id = erms.entity_master_id
						left join yho.yho_provider_author_map pam
						on pam.author_id = sl.author_id
						left join yho.yho_content_provider cp
						on cp.content_provider_id = pam.content_provider_id
                        where sl.asset_list_id in (select unnest($1))                        
						order by custom_priority, published_date desc) row'
	into p_assetjson
    using v_assetlistidarr;
    
    if p_assetcount is null then
    	p_assetcount := 0;
        p_assetjson := '{"items":[]}';
    end if;
	
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
