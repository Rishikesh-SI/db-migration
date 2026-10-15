-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_trending_assets(numeric, numeric, numeric[])
-- Type: FUNCTION

-- Name: stn_get_trending_assets(numeric, numeric, numeric[]); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_trending_assets(p_hours numeric, p_itemnumber numeric, p_entityarr numeric[], OUT p_trendingassetsjson jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
	v_hours text := ''''||p_hours||'hours''';
	v_xhoursagodate timestamp;
    v_entityrolemapid_string text;
    v_entitycount numeric;
    v_trendingassetsjson json;
    
begin
    
    select date_trunc('day',(current_timestamp at time zone 'utc' - (v_hours)::interval)) into v_xhoursagodate;
    
    select count(1) into v_entitycount from unnest(p_entityarr)entity_id;
    
    v_entityrolemapid_string := '{'||array_to_string(p_entityarr,',')||'}';
    
    select ('{"trending_assets":['||string_agg((row_to_json(row))::text,',')||']}')::json
    from(select av.asset_id, av.asset_type_id, count(1) view_count
         from stn.stn_assets_view av
         where view_date >= v_xhoursagodate
         and exists(select 1
                    from stn.stn_asset_entity_map aem1
                    where aem1.asset_id = av.asset_id
                    and aem1.asset_type_id = av.asset_type_id
                    and aem1.entity_role_map_id =any(v_entityrolemapid_string::numeric[])
                    group by aem1.asset_id,aem1.asset_type_id
                    having count(1) = v_entitycount)
         group by asset_id, asset_type_id
         order by view_count desc
         limit p_itemnumber) row
	into v_trendingassetsjson;
    
    select ('{"items":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from(select distinct al.asset_list_id, al.asset_id, al.asset_type_id, al.asset_title, al.title_alias, aa.author_id, al.short_desc, al.tags, 
         		al.primary_entity_role_map_id, al.secondary_entity_role_map_id, al.total_assets, al.image_file_name, al.image_path, al.duration, 
         		al.show_in_web, al.show_in_mobile, al.show_in_app, al.published_version_number, al.is_trashed, al.created_date, al.updated_date, 
         		al.created_by, al.updated_by, al.is_active, al.is_deleted, al.is_published, al.published_date, al.asset_guid, al.show_copyright, 
         		al.order_number, al.image_file_name, al.image_path, u.display_name user_name, pem.entity_name primary_entity_name, 
         		sem.entity_name secondary_entity_name, coalesce(pelm.entity_display_name, pem.entity_display_name) pri_ent_disp_name, 
            	coalesce(selm.entity_display_name, sem.entity_display_name) sec_ent_disp_name, al.short_title, c.view_count
         from stn.stn_asset_list al
         join (select (json_array_elements(a->'trending_assets')->>'asset_id')::numeric asset_id, 
               			(json_array_elements(a->'trending_assets')->>'asset_type_id')::numeric asset_type_id, 
               			(json_array_elements(a->'trending_assets')->>'view_count')::numeric view_count
               from (select v_trendingassetsjson as a) b) c
         on c.asset_id = al.asset_id
         and c.asset_type_id = al.asset_type_id
         left join stn.stn_author_action aa
         on aa.asset_id = al.asset_id
         and aa.asset_type_id = al.asset_type_id
         and aa.action_id = 4
         left join stn.stn_user u
         on u.user_id = aa.author_id
         left join stn.stn_entity_role_map perm
         on perm.entity_role_map_id = al.primary_entity_role_map_id
         left join stn.stn_entity_master pem
         on pem.entity_master_id = perm.entity_master_id
         left join stn.stn_entity_role_map serm
         on serm.entity_role_map_id = al.primary_entity_role_map_id
         left join stn.stn_entity_master sem
         on sem.entity_master_id = serm.entity_master_id
         left join stn.stn_asset_entity_map aem
         on aem.asset_id = al.asset_id
         and aem.asset_type_id = al.asset_type_id
         and aem.entity_role_map_id in (select entity_role_map_id 
                                        from stn.stn_entity_role_map 
                                        where entity_role_id in(select entity_role_id 
                                                                from stn.stn_entity_category))
         left join stn.stn_entity_role_map lerm
         on lerm.entity_role_map_id = aem.entity_role_map_id
         left join stn.stn_entity_master lem
         on lem.entity_master_id = lerm.entity_master_id
         left join stn.stn_entity_language_map pelm
         on pelm.entity_master_id = pem.entity_master_id
         and pelm.language_master_id = lem.entity_master_id
         left join stn.stn_entity_language_map selm
         on selm.entity_master_id = sem.entity_master_id
         and selm.language_master_id = lem.entity_master_id
         order by c.view_count desc
        )row
	into p_trendingassetsjson;
    
    if p_trendingassetsjson is not null then
    	p_result := 1;
	else
    	p_result := 0;
	end if;
    
exception
	when others then
    	p_result := -1;
        p_trendingassetsjson := '{"items":[]}'::jsonb;

end;

$$;


--
