-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_asset_listing_rtst(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying)
-- Type: FUNCTION

-- Name: yho_get_asset_listing_rtst(numeric, numeric, numeric, numeric[], numeric[], numeric[], character varying); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_asset_listing_rtst(p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, OUT p_assetcount numeric, OUT p_assetjson jsonb) RETURNS record
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
	
    execute 'select string_to_array(string_agg(assset_list_id::text,'',''),'',''), rowcount
				from (
				
				select assset_list_id,row_number() over(order by  published_date desc) rno, 
				    count(assset_list_id) over() rowcount
						from yho.yho_asset_list_detail	
					where entity_id @> $2
				
				) tab
				where rno between '||v_fromrownumber||' and '||v_torownumber||'
				group by rowcount'
	into v_assetlistidarr, p_assetcount
    using v_assettypeidarr, p_entityrole_mapid, p_any_entityrole_mapid;-- v_entityrolemapidarr;
    
	
    
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
    
    execute 'select ''{"items":[''||string_agg(web_listing_json::text,'','')||'']}''
	from (select asset_list_id,web_listing_json
    from   yho.yho_asset_list sl
    where  sl.is_active=1
    and    sl.is_deleted=0
    and    sl.is_published=1
    and    sl.published_date<='''||v_sysdate||'''
    and    sl.asset_type_id in (1,2,4,5)
	and  sl.asset_list_id in (select unnest($1))                        
	order by custom_priority, published_date desc)tab '
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
