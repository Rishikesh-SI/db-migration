-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_get_tem_comp_asset_map_detail_by_page_r_old(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: stn_get_tem_comp_asset_map_detail_by_page_r_old(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: stn; Owner: -
--

CREATE FUNCTION stn.stn_get_tem_comp_asset_map_detail_by_page_r_old(p_asset_id numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_use_fallback numeric, p_showcase_cur refcursor, p_showcase_ent_cur refcursor, p_showcase_asset_author_cur refcursor, p_template_comp_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_asset_type_id numeric := 8;
    v_versionnumber numeric;
    v_image_path varchar(4000);
    v_ent_count numeric;    
    v_sysdate timestamp;
    v_language_id numeric;
    v_asset_count numeric := 0;
    v_req_asset_count numeric := 6;
    v_arr_asset_list_id numeric[];
    v_arr_asset_list_id_cnt numeric;
    v_str_arr_asset_list_id varchar(1000000);
    v_str_entityrole_mapid varchar(1000000);
    v_str_entityrole_mapid_all varchar(1000000);
    v_anyentityrolemapidquery varchar(4000) := ' ';
    v_any_ent_count numeric;
    v_fromrownumber numeric;
    v_torownumber numeric;
    v_arr_asset_id numeric[];
    v_arr_asset_type_id numeric[];
    v_json json;
    V_JS JSON;
    V_assets json;
    v_tot_asset_count numeric;
    v_entityrole_mapid numeric[] := p_entityrole_mapid;
    v_entityrole_mapid_all numeric[] := p_entityrole_mapid;
    v_ent_count_all numeric;
    
begin
	
    v_sysdate:=  current_timestamp at time zone 'utc'; 
    -- Standard Pagination logic
    if p_page1_size is null
    then
    	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
        v_torownumber   := (p_pagenumber * p_itemnumber);
	else
    	if p_pagenumber = 1 then
        	v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
		else
        	v_fromrownumber := p_page1_size + ((((p_pagenumber - 1) * p_itemnumber) - (p_itemnumber - 1)));
		end if;
        v_torownumber := p_page1_size + ((p_pagenumber-1) * p_itemnumber);
    end if;
    
    select count(1)
    into   v_ent_count
    from   unnest(p_entityrole_mapid)entity_id;
    
    v_ent_count_all := v_ent_count;
    
	select count(1)
	into   v_any_ent_count
	from   unnest(p_any_entityrole_mapid)entity_id;
    

  	if v_any_ent_count <> 0 then
    	select array_cat(v_entityrole_mapid, p_any_entityrole_mapid)
        into   v_entityrole_mapid;
        
        v_ent_count := v_ent_count + 1;
    end if;
  
	v_str_entityrole_mapid := '{'||array_to_string(v_entityrole_mapid,',')||'}';
    v_str_entityrole_mapid_all := '{'||array_to_string(v_entityrole_mapid_all,',')||'}';
    
    SELECT stn.stn_get_entity_language_from_entities(v_entityrole_mapid)
    INTO v_language_id;
    
    execute 'SELECT ARRAY(
    			select ae.asset_list_id
                from stn.stn_asset_list ae
                left join stn.stn_template_component_asset_map sl
                on ae.asset_id = (sl.asset_meta->>''asset_id'')::numeric
                 and ae.asset_type_id = coalesce((sl.asset_meta->>''content_type'')::numeric,1)
                WHERE ae.is_published = 1
                and ae.is_trashed = 0
                and ae.published_date <= '''||v_sysdate||'''
                AND TEMPLATE_COMPONENT_MAP_ID = $1
                and exists (select 1 from stn.stn_asset_entity_map eam
                            where eam.asset_id = (sl.asset_meta->>''asset_id'')::numeric
                            and eam.asset_type_id = coalesce((sl.asset_meta->>''content_type'')::numeric,1)
                            and eam.entity_role_map_id = ANY ($2::numeric[])
                            and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any ($3::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = '||v_ent_count_all||'
            )
                            GROUP BY eam.asset_id, eam.asset_type_id
                            HAVING COUNT(1) = '||v_ent_count ||')'
                ||') '
	into v_arr_asset_list_id
	using p_asset_id, v_str_entityrole_mapid, v_str_entityrole_mapid_all;
    
	select count(1)
    into   v_arr_asset_list_id_cnt
    from   unnest(v_arr_asset_list_id)entity_id;
    
    v_str_arr_asset_list_id := '{'||array_to_string(v_arr_asset_list_id,',')||'}';
    
    execute 'select COUNT(1)
    		 from(
             		select sl.template_component_asset_map_ID,sl.asset_order
                    from stn.stn_template_component_asset_map  sl 
                    WHERE  TEMPLATE_COMPONENT_MAP_ID = $1
                    and asset_type_id = 12
                    and  published_date <= '''||v_sysdate||'''
                    and  exists (select 1 from stn.stn_asset_entity_map eam
                    				where eam.asset_id = (sl.asset_meta->>''asset_id'')::numeric 
                                    and eam.asset_type_id = (sl.asset_meta->>''content_type'')::numeric 
                                    and eam.entity_role_map_id =ANY ($2::numeric[])
                                   and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any ($3::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = '||v_ent_count_all||'
            )
                                    GROUP BY eam.asset_id,eam.asset_type_id
                                    HAVING COUNT(1) = '||v_ent_count||')'
                    ||')tab '
	INTO v_asset_count 
    USING p_asset_id,v_str_entityrole_mapid, v_str_entityrole_mapid_all;
	
    v_asset_count := COALESCE(v_asset_count,0) + COALESCE(v_arr_asset_list_id_cnt,0);
    v_req_asset_count := GREATEST((v_req_asset_count - v_asset_count),0);
    
	select array_to_json(array_agg(row_to_json(t)))
    into V_assets
    from (
        select asset_id,asset_type_id
        from (
            select *
            from (
                select tab.*,row_number() over(order by is_fallback,asset_order) rnk
                from (
                    select sl.asset_order, ae.asset_id, ae.asset_type_id,0 as is_fallback
                    from stn.stn_template_component_asset_map sl
                    join stn.stn_asset_list ae
                    on ae.asset_id = (sl.asset_meta->>'asset_id')::numeric
                    and ae.asset_type_id = coalesce((sl.asset_meta->>'content_type')::numeric,1)
                    WHERE ae.is_published = 1
                    and ae.is_trashed = 0
                    and ae.published_date <= v_sysdate
                    AND TEMPLATE_COMPONENT_MAP_ID = p_asset_id
                    and ae.asset_list_id =ANY (v_str_arr_asset_list_id::NUMERIC[])
				union
				select sl.asset_order, sl.asset_id, sl.asset_type_id, 0 as is_fallback
				from stn.stn_template_component_asset_map sl
				WHERE TEMPLATE_COMPONENT_MAP_ID = p_asset_id
				and asset_type_id = 12
				and published_date <= v_sysdate
                    and coalesce((sl.asset_meta->>'asset_id')::numeric,0) = 0 and coalesce((sl.asset_meta->>'content_type')::numeric,0) = 0
             	and exists (select 1 from stn.stn_asset_entity_map eam
                            where eam.asset_id = sl.asset_id
                            and eam.asset_type_id = sl.asset_type_id
                            and eam.entity_role_map_id =ANY (v_str_entityrole_mapid::NUMERIC[])
                            and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = v_ent_count_all
            )
                            GROUP BY eam.asset_id, eam.asset_type_id
                            HAVING COUNT(1) = v_ent_count)
          		UNION
				SELECT  rno asset_order, asset_id, asset_type_id, 1 as is_fallback
               	FROM (
                    SELECT row_number() over(order by al.published_date desc) rno, asset_id, asset_type_id
					FROM stn.stn_asset_list al
                    WHERE al.is_active = 1
                    and al.is_deleted = 0
                    and al.is_published = 1
                    and al.published_date <= v_sysdate
                    and al.asset_type_id in (1,2,4,5)
                    and al.asset_list_id not in (SELECT assetlid FROM UNNEST(v_arr_asset_list_id) U(assetlid))
					and EXISTS (select 1
                                from   stn.stn_asset_entity_map eam
                                where  eam.asset_id = al.asset_id
                                and    eam.asset_type_id = al.asset_type_id 
                                and    eam.entity_role_map_id =ANY (v_str_entityrole_mapid::NUMERIC[])
                                and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = v_ent_count_all
            )
                                GROUP BY eam.asset_id, eam.asset_type_id
                                HAVING COUNT(1) = v_ent_count)
                	  ) TAB
                )tab
            ) all_data where rnk between v_fromrownumber and v_torownumber
            order by rnk
        ) a
    ) t;
    
    select COUNT(1) v_asset_count
    into v_tot_asset_count
    from (
        select tab.*,row_number() over(order by is_fallback,asset_order) rnk
          from 
            (select sl.template_component_asset_map_id, sl.template_component_map_id,sl.asset_order, 
                    sl.asset_id, sl.asset_type_id, sl.asset_meta, sl.show_in_web, sl.show_in_mobile,
                    sl.show_in_app,  ae.published_version_number, ae.is_trashed,  ae.created_date,
                    ae.updated_date, ae.created_by,  ae.updated_by, ae.is_active, ae.is_deleted,
                    ae.is_published, ae.published_date, sl.asset_guid, ae.title_alias,AE.asset_title,
                    ae.short_desc as desc ,ae.total_assets,ae.image_path,ae.image_file_name,
                    0 as is_fallback
             from stn.stn_template_component_asset_map sl
             join stn.stn_asset_list ae
             on   ae.asset_id= sl.asset_id
             and  ae.asset_type_id = sl.asset_type_id 
             WHERE  ae.is_published=1
             and    ae.is_trashed=0
             and    ae.published_date<=v_sysdate
             AND    TEMPLATE_COMPONENT_MAP_ID=p_asset_id
             and    ae.asset_list_id =ANY (v_str_arr_asset_list_id::NUMERIC[]) 
        union                 
             select sl.*,asset_meta->>'title_alias' as title_alias , asset_meta->>'title' as asset_title ,
             ' ' as desc ,null::numeric total_assets,' ' image_path,' ' image_file_name,0 as is_fallback
             from stn.stn_template_component_asset_map  sl 
             WHERE 
             TEMPLATE_COMPONENT_MAP_ID=p_asset_id
             and asset_type_id=12
             and  published_date<=v_sysdate
             and coalesce((sl.asset_meta->>'asset_id')::numeric,0) = 0 and coalesce((sl.asset_meta->>'content_type')::numeric,0) = 0
             and  exists (select 1 from   stn.stn_asset_entity_map eam
                        where eam.asset_id= sl.asset_id
                        and eam.asset_type_id = sl.asset_type_id 
                          and eam.entity_role_map_id =ANY (v_str_entityrole_mapid::NUMERIC[])
                          and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = v_ent_count_all
            )
                           GROUP BY eam.asset_id,eam.asset_type_id
                                      HAVING COUNT(1)=v_ent_count         
         
                          )
          UNION
               SELECT  template_component_asset_map_id, p_asset_id template_component_map_id, 
                rno asset_order, asset_id, 
               asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
               is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
               is_published, published_date, asset_guid,
               title_alias,asset_title,short_desc as desc , total_assets,image_path image_path,
               image_file_name image_file_name,1 as is_fallback
               FROM (
                     SELECT asset_list_id template_component_asset_map_id, 
                     p_asset_id template_component_map_id, 
                      row_number() over(order by al.published_date desc) rno, asset_id, 
                     asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, 
                     published_version_number, is_trashed, created_date, updated_date, created_by, 
                     updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                     al.title_alias,al.asset_title,al.short_desc ,al.total_assets
                     ,al.image_path,al.image_file_name
                      FROM stn.stn_asset_list al 
                      WHERE  al.is_active=1
                      and    al.is_deleted=0
                      and    al.is_published=1
                      and    al.published_date<=v_sysdate
                      and    al.asset_type_id in (1,2,4,5) 
                      and    al.asset_list_id not in (SELECT assetlid
                                                        FROM UNNEST(v_arr_asset_list_id) U(assetlid))
                      and    EXISTS (select 1
                             from   stn.stn_asset_entity_map eam
                             where  eam.asset_id= al.asset_id
                             and    eam.asset_type_id = al.asset_type_id 
                             and    eam.entity_role_map_id =ANY (v_str_entityrole_mapid::NUMERIC[])
                                     and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = v_ent_count_all
            )
                                  GROUP BY eam.asset_id,eam.asset_type_id
                                  HAVING COUNT(1)=v_ent_count)
                      -- and    p_use_fallback=1            
                            ) TAB
                --WHERE rno<=v_req_asset_count
             )tab 
             )b ;
    --  =================== Get Cursors
    
        OPEN p_showcase_cur FOR     
        select *
        from ( 
          select tab.*,row_number() over(order by is_fallback,asset_order) rnk
          from 
            (select sl.template_component_asset_map_id, sl.template_component_map_id,sl.asset_order, ae.asset_id, ae.asset_type_id,
             sl.asset_meta, sl.show_in_web, sl.show_in_mobile,
                    sl.show_in_app,  ae.published_version_number, ae.is_trashed,  ae.created_date,
                    ae.updated_date, ae.created_by,  ae.updated_by, ae.is_active, ae.is_deleted,
                    ae.is_published, ae.published_date, sl.asset_guid, ae.title_alias,AE.asset_title,
                    ae.short_desc as desc ,ae.total_assets,ae.image_path,ae.image_file_name,
                    0 as is_fallback, ae.short_title, a.full_text
             from stn.stn_template_component_asset_map sl
             join stn.stn_asset_list ae
             on   ae.asset_id = (sl.asset_meta->>'asset_id')::numeric
             and  ae.asset_type_id = coalesce((sl.asset_meta->>'content_type')::numeric,1)
                   	  left join  stn.stn_article a
                      on a.article_id = ae.asset_id
                      and ae.asset_type_id = 1
             WHERE  ae.is_published=1
             and    ae.is_trashed=0
             and    ae.published_date<=v_sysdate
             AND    TEMPLATE_COMPONENT_MAP_ID=p_asset_id
             and    ae.asset_list_id =ANY (v_str_arr_asset_list_id::NUMERIC[])
             -- and    (sl.asset_id,sl.asset_type_id ) in 
             /*and    ((sl.asset_meta->>'asset_id')::numeric,(sl.asset_meta->>'content_type')::numeric ) in 
         
                                         ( select a.asset_id,a.asset_type_id from json_populate_recordset(null::TYPE_ASSET, V_assets) a
                                         )*/
         union                 
             select sl.template_component_asset_map_id, sl.template_component_map_id,sl.asset_order, sl.asset_id, sl.asset_type_id,
             sl.asset_meta, sl.show_in_web, sl.show_in_mobile, sl.show_in_app,  sl.published_version_number, sl.is_trashed,  sl.created_date, 
             sl.updated_date, sl.created_by,  sl.updated_by, sl.is_active, sl.is_deleted,sl.is_published, sl.published_date, sl.asset_guid, 
             asset_meta->>'title_alias' as title_alias , asset_meta->>'title' as asset_title , asset_meta->>'desc' as desc ,null::numeric total_assets,
             asset_meta->>'image_path' image_path,asset_meta->>'image_name' image_file_name,0 as is_fallback, null short_title, 
             asset_meta->>'desc' as full_text
             from stn.stn_template_component_asset_map  sl 
             WHERE 
             TEMPLATE_COMPONENT_MAP_ID=p_asset_id
             and asset_type_id=12
             and  published_date<=v_sysdate
             and coalesce((sl.asset_meta->>'asset_id')::numeric,0) = 0 and coalesce((sl.asset_meta->>'content_type')::numeric,0) = 0
             and  exists (select 1 from   stn.stn_asset_entity_map eam
                        where eam.asset_id= sl.asset_id
                        and eam.asset_type_id = sl.asset_type_id
                          and eam.entity_role_map_id =ANY (v_str_entityrole_mapid::NUMERIC[])
                          and exists (select 1
                            			from   stn.stn_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        GROUP BY aem.asset_id, aem.asset_type_id
                                        HAVING COUNT(1) = v_ent_count_all
            )
                           GROUP BY eam.asset_id,eam.asset_type_id
                                      HAVING COUNT(1)=v_ent_count         
         
                          )
              /*and    (sl.asset_id,sl.asset_type_id ) in 
         
                                         ( select a.asset_id,a.asset_type_id from json_populate_recordset(null::TYPE_ASSET, V_assets) a
                                         )     */         
          UNION
               SELECT  template_component_asset_map_id, p_asset_id template_component_map_id, 
                rno asset_order, asset_id, 
               asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
               is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
               is_published, published_date, asset_guid,
               title_alias,asset_title,short_desc as desc , total_assets,image_path image_path,
               image_file_name image_file_name,1 as is_fallback,short_title, full_text
               FROM (
                     SELECT al.asset_list_id template_component_asset_map_id, 
                     p_asset_id template_component_map_id, 
                      row_number() over(order by al.published_date desc) rno, al.asset_id, 
                     al.asset_type_id, null asset_meta, al.show_in_web, al.show_in_mobile, al.show_in_app, 
                     al.published_version_number, al.is_trashed, al.created_date, al.updated_date, al.created_by, 
                     al.updated_by, al.is_active, al.is_deleted, al.is_published, al.published_date, al.asset_guid,
                     al.title_alias,al.asset_title,al.short_desc ,al.total_assets
                     ,al.image_path,al.image_file_name, al.short_title,
                     a.full_text
                      FROM stn.stn_asset_list al
                   	  left join  stn.stn_article a
                      on a.article_id = al.asset_id
                      and al.asset_type_id = 1
                      WHERE  al.is_active=1
                      and    al.is_deleted=0
                      and    al.is_published=1
                      and    al.published_date<=v_sysdate
                      and    al.asset_type_id in (1,2,4,5) 
                      and    al.asset_list_id not in (SELECT assetlid
                                                        FROM UNNEST(v_arr_asset_list_id) U(assetlid))
                      and    (al.asset_id,al.asset_type_id ) in 
         
                                         ( select a.asset_id,a.asset_type_id from json_populate_recordset(null::TYPE_ASSET, V_assets) a
                                         )                   
                            ) TAB
             )tab 
             ) all_data 
             order by rnk;
             
           OPEN p_showcase_ent_cur FOR
         
         select *,stn.stn_get_entity_name (entity_role_map_id) entity_name ,
                 stn.stn_get_entity_display_name_by_language(v_language_id, entity_role_map_id) ent_disp_name
         from stn.stn_asset_entity_map ae
         WHERE (asset_id,asset_type_id ) in 
         
                                         ( select asset_id,asset_type_id from json_populate_recordset(null::TYPE_ASSET, V_assets) a
                                         )
                                     order by asset_id,asset_type_id    
                                  ;
            open p_showcase_asset_author_cur for
             SELECT tab.asset_id,tab.asset_type_id, 
             al.author_id,
             stn.stn_get_user_disp_name(al.author_id) author_name,
             (select full_name from stn.stn_user where user_id=al.author_id) full_name,
             (select user_name from stn.stn_user where user_id=al.author_id) user_name
                     FROM ( select asset_id,asset_type_id 
                            from json_populate_recordset(null::TYPE_ASSET, V_assets) a
                          ) TAB
                    JOIN  stn.stn_author_action al
                     on   TAB.asset_id =  al.asset_id
                     and  TAB.asset_type_id =  al.asset_type_id
                     and  al.action_id=4       
                     order by tab.asset_id,tab.asset_type_id,  al.author_id; 
             
            OPEN p_template_comp_cur for
               
               select template_component_map_id,is_published,0 is_trashed,updated_by,updated_date as published_date
               , 1 as published_version_number,v_tot_asset_count v_asset_count 
               from stn.stn_TEMPLATE_COMPONENT_MAP
               where TEMPLATE_COMPONENT_MAP_ID=p_asset_id;
 
end;

$_$;


--
