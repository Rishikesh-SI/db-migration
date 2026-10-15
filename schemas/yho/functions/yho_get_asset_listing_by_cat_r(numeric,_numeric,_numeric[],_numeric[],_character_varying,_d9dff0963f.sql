-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_get_asset_listing_by_cat_r(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: yho_get_asset_listing_by_cat_r(numeric, numeric, numeric[], numeric[], character varying, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_get_asset_listing_by_cat_r(p_pagenumber numeric, p_itemnumber numeric, p_entityrole_mapid numeric[], p_asset_type_id numeric[], p_searchkeyword character varying, p_asset_count refcursor, p_asset_cur refcursor, p_category_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

/*
SELECT * from yho.yho_get_asset_listing_by_cat_r_new(
	1,-- <p_pagenumber numeric>, 
	25,-- <p_itemnumber numeric>, 
	array[35369],-- <p_entityrole_mapid numeric[]>, 
	null,-- <p_asset_type_id numeric[]>, 
	null,-- <p_searchkeyword character varying>, 
	'a',-- <p_asset_count refcursor>, 
	'b',-- <p_asset_cur refcursor>, 
	'c'-- <p_category_cur refcursor>
);
fetch all in "b";
*/
declare
	
    v_sysdate timestamp := current_timestamp at time zone 'utc';
    v_ent_count numeric;
    v_language_id numeric;
	v_lang_master_id numeric;
    v_entityrolemapidquery varchar(4000) := ' ';
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_searchkeyword varchar(4000) := lower(p_searchkeyword);
    v_entitysearchquery varchar(4000) := ' ';
    v_assettypeidcount numeric;
    v_assettypequery varchar(4000) := ' ';
    v_asset_list_id_arr numeric[];
    v_asset_list_id_arr1 numeric[];
    v_qry_str text;
    v_languagecanonicalurl text;
    
begin
    
    select count(1) into v_ent_count from unnest(p_entityrole_mapid)entity_id;
    
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
  	v_torownumber   := (p_pagenumber * p_itemnumber);
    
    select count(asset_type_id) into v_assettypeidcount from unnest(p_asset_type_id) u(asset_type_id);
    
    if v_assettypeidcount > 0 then
        v_assettypequery := 'and sl.asset_type_id in(select asset_type_id from unnest($1) u(asset_type_id))';
	end if;
    
    if p_searchkeyword is not null then
    	
        execute 'select array(select sl.asset_list_id
        						from yho.yho_asset_list sl, plainto_tsquery($2) as q
                                where sl.is_active = 1
                                and sl.is_deleted = 0
                                and sl.is_published = 1
                                and sl.published_date <= '''||v_sysdate||'''
                                and sl.asset_type_id in (1,2,4)
                                and exists (select 1 from yho.yho_asset_entity_map eam
                                			where eam.asset_id = sl.asset_id
                                            and eam.asset_type_id = sl.asset_type_id
                                            and eam.entity_role_map_id in (select entity_role_mapid from unnest($3) u(entity_role_mapid))
                                            group by eam.asset_id, eam.asset_type_id
                                            having count(1) = $4)
								and (tvs @@ q)'
                                ||v_assettypequery||
                                ')'
		into v_asset_list_id_arr
    	using p_asset_type_id, v_searchkeyword, p_entityrole_mapid, v_ent_count;
		
    else
    	
        execute 'select array(select sl.asset_list_id
        						from yho.yho_asset_list sl
                                where sl.is_active = 1
                                and sl.is_deleted = 0
                                and sl.is_published = 1
                                and sl.published_date <= '''||v_sysdate||'''
                                and sl.asset_type_id in (1,2,4)
                                and exists (select 1 from yho.yho_asset_entity_map eam
                                			where eam.asset_id = sl.asset_id
                                            and eam.asset_type_id = sl.asset_type_id
                                            and eam.entity_role_map_id in (select entity_role_mapid from unnest($2) u(entity_role_mapid))
                                            group by eam.asset_id, eam.asset_type_id
                                            having count(1) = $3)'
                            	||v_assettypequery||
                                ')'
		into    v_asset_list_id_arr
    	using   p_asset_type_id, p_entityrole_mapid, v_ent_count;
        
    end if;
    
    open p_asset_count for 
    select distinct count(1) over(partition by secondary_entity_role_map_id) cnt, secondary_entity_role_map_id as sentid
    from yho.yho_asset_list
    where asset_list_id in(select asset_list_id from unnest(v_asset_list_id_arr) u(asset_list_id));
	
    select coalesce(em.canonical_url,'null') into v_languagecanonicalurl
    from yho.yho_entity_category ec
    join yho.yho_entity_role_map erm
    on erm.entity_role_id = ec.entity_role_id
    join yho.yho_entity_master em
    on em.entity_master_id = erm.entity_master_id
    where ec.category_name = 'Language'
    and erm.entity_role_map_id in(select unnest(p_entityrole_mapid));
    
    select array(select asset_list_id
    from (select asset_list_id,row_number() over (partition by secondary_entity_role_map_id order by published_date desc) slno
          from yho.yho_asset_list
          where asset_list_id in(select asset_list_id from unnest(v_asset_list_id_arr) u(asset_list_id))
         )a
	where slno between v_fromrownumber and v_torownumber)
    into v_asset_list_id_arr1;
    
    open p_asset_cur for
    -- select *
    -- from (
        select sl.asset_list_id, sl.asset_id, sl.asset_type_id, sl.asset_title, sl.title_alias, sl.author_id, sl.short_desc, sl.tags,
          			sl.primary_entity_role_map_id, sl.secondary_entity_role_map_id, sl.total_assets, image_file_name, image_path, sl.duration,
          			sl.show_in_web, sl.show_in_mobile, sl.show_in_app, sl.published_version_number, sl.is_trashed, sl.created_date, sl.updated_date,
          			sl.created_by, sl.updated_by, sl.is_active, sl.is_deleted, sl.is_published, sl.published_date, sl.asset_guid, sl.show_copyright,
          			order_number, rank() over (partition by sl.secondary_entity_role_map_id order by sl.published_date desc) as rno,
          			u.full_name user_name, emp.entity_name primary_entity_name, ems.entity_name secondary_entity_name, erms.priority sent_priority,
          			cp.content_provider_id content_source_id, cp.content_provider_name, null image_file_name1, null image_path1,
            		case v_languagecanonicalurl when 'null' then v_languagecanonicalurl else '"'||v_languagecanonicalurl||'"' end as lang_curl
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
    		where sl.asset_list_id in (select asset_list_id from unnest(v_asset_list_id_arr1) u(asset_list_id));
         -- )a
	-- where rno between v_fromrownumber and v_torownumber;
	
    open   p_category_cur for
    select em.entity_role_map_id entid, coalesce(elm.entity_display_name, e.entity_display_name) as entity_name, e.entity_display_name entity_eng_name
    from   yho.yho_entity_role_map em
    join   yho.yho_entity_master e
    on     e.entity_master_id = em.entity_master_id
    left join yho.yho_entity_language_map elm
    on     elm.entity_master_id = e.entity_master_id
    and    elm.language_master_id = v_lang_master_id
    where  entity_role_id in(select entity_role_id
                             from   yho.yho_entity_category
                             where  category_name = 'Category Type')
	and    e.is_active = 1 
    and    em.priority > 0;
	
/*exception
	when others then
     	p_assetcount := -1;
          p_assetjson := '{"items":[{"error":"no record"}]}';*/
     
end;

$_$;


--
