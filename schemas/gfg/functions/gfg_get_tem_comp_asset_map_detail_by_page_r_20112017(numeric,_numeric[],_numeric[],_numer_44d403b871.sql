-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_get_tem_comp_asset_map_detail_by_page_r_20112017(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gfg_get_tem_comp_asset_map_detail_by_page_r_20112017(numeric, numeric[], numeric[], numeric, numeric, numeric, numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: gfg; Owner: -
--

CREATE FUNCTION gfg.gfg_get_tem_comp_asset_map_detail_by_page_r_20112017(p_asset_id numeric, p_entityrole_mapid numeric[], p_any_entityrole_mapid numeric[], p_pagenumber numeric, p_itemnumber numeric, p_page1_size numeric, p_use_fallback numeric, p_showcase_cur refcursor, p_showcase_ent_cur refcursor, p_showcase_asset_author_cur refcursor, p_template_comp_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$ 

-- ********************************preface block*******************************
--  name:   gfg.gfg_get_tem_comp_asset_map_detail_by_page_r

--  parameters:  p_asset_id numeric, p_entityrole_mapid, p_any_entityrole_mapid , 
--               p_pagenumber , p_itemnumber , p_page1_size , p_showcase_cur , 
--               p_showcase_ent_cur , p_showcase_asset_author_cur , p_template_comp_cur  

--  external output:  

--  written/modified:   date:           reason:
--  a.kini              15/04/2017      creation
--  a.kini              31/05/2017      changes to convert it to lsting sp
-- ********************************end preface block***************************
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
    v_js json;
    v_assets json;
    v_tot_asset_count numeric;
    v_entityrole_mapid numeric[] := p_entityrole_mapid;
    v_entityrole_mapid_all numeric[] := p_entityrole_mapid;
    v_ent_count_all numeric;
    
begin
	
    v_sysdate:=  current_timestamp at time zone 'utc'; 
    -- standard pagination logic
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
    
    select gfg.gfg_get_entity_language_from_entities(v_entityrole_mapid)
    into v_language_id;
    
    /*if v_any_ent_count > 0 then
    	
        v_anyentityrolemapidquery := ' and    exists (select 1
        							   from   gfg.gfg_asset_entity_map eam
                                       where  eam.asset_id= sl.asset_id
                                       and    eam.asset_type_id = sl.asset_type_id 
                                       and    eam.entity_role_map_id in(select any_entity_role_mapid
                                       									from unnest($3) u(any_entity_role_mapid))) ';
		
	end if;*/
    
    execute 'select array(
    			select ae.asset_list_id
                -- from gfg.gfg_template_component_asset_map sl
                -- join gfg.swa_asset_list ae
                from gfg.swa_asset_list ae
                left join gfg.gfg_template_component_asset_map sl
                on ae.asset_id = sl.asset_id
                and ae.asset_type_id = sl.asset_type_id
                where ae.is_published = 1
                and ae.is_trashed = 0
                and ae.published_date <= '''||v_sysdate||'''
                and template_component_map_id = $1
                and exists (select 1 from gfg.gfg_asset_entity_map eam
                            where eam.asset_id = sl.asset_id
                            and eam.asset_type_id = sl.asset_type_id 
                            and eam.entity_role_map_id = any ($2::numeric[])
                            and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any ($3::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = '||v_ent_count_all||'
            )
                            group by eam.asset_id, eam.asset_type_id
                            having count(1) = '||v_ent_count ||')'
                -- ||v_anyentityrolemapidquery
                ||') '
	into v_arr_asset_list_id
	using p_asset_id, v_str_entityrole_mapid, v_str_entityrole_mapid_all;-- ,p_any_entityrole_mapid;
    
    
    
    
    
	select count(1)
    into   v_arr_asset_list_id_cnt
    from   unnest(v_arr_asset_list_id)entity_id;
    
    v_str_arr_asset_list_id := '{'||array_to_string(v_arr_asset_list_id,',')||'}';
    
    execute 'select count(1)
    		 from(
             		select sl.template_component_asset_map_id,sl.asset_order
                    from gfg.gfg_template_component_asset_map  sl 
                    where  template_component_map_id = $1
                    and asset_type_id = 12
                    and  published_date <= '''||v_sysdate||'''
                    and  exists (select 1 from gfg.gfg_asset_entity_map eam
                    				where eam.asset_id = sl.asset_id
                                    and eam.asset_type_id = sl.asset_type_id 
                                    and eam.entity_role_map_id =any ($2::numeric[])
                                   and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any ($3::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = '||v_ent_count_all||'
            )
                                    group by eam.asset_id,eam.asset_type_id
                                    having count(1) = '||v_ent_count||')'
                	-- ||v_anyentityrolemapidquery
                    ||')tab '
	into v_asset_count 
    using p_asset_id,v_str_entityrole_mapid, v_str_entityrole_mapid_all;-- ,p_any_entityrole_mapid;
	
    v_asset_count := coalesce(v_asset_count,0) + coalesce(v_arr_asset_list_id_cnt,0);
    v_req_asset_count := greatest((v_req_asset_count - v_asset_count),0);
    
	select array_to_json(array_agg(row_to_json(t)))
    into v_assets
    from (
        select asset_id,asset_type_id
        from (
            select *
            from (
                select tab.*,row_number() over(order by is_fallback,asset_order) rnk
                from (
                    select sl.template_component_asset_map_id, sl.template_component_map_id, sl.asset_order, sl.asset_id, sl.asset_type_id,
                    	   sl.asset_meta, sl.show_in_web, sl.show_in_mobile, sl.show_in_app, ae.published_version_number, ae.is_trashed,
                    	   ae.created_date, ae.updated_date, ae.created_by, ae.updated_by, ae.is_active, ae.is_deleted, ae.is_published,
                    	   ae.published_date, sl.asset_guid, ae.title_alias,ae.asset_title, ae.short_desc as desc, ae.total_assets, ae.image_path,
                    	   ae.image_file_name, 0 as is_fallback
                    from gfg.gfg_template_component_asset_map sl
                    join gfg.swa_asset_list ae
                    on ae.asset_id = sl.asset_id
                    and ae.asset_type_id = sl.asset_type_id
                    where ae.is_published = 1
                    and ae.is_trashed = 0
                    and ae.published_date <= v_sysdate
                    and template_component_map_id = p_asset_id
                    and ae.asset_list_id =any (v_str_arr_asset_list_id::numeric[])
				union
				select sl.*, asset_meta->>'title_alias' as title_alias, asset_meta->>'title' as asset_title, ' ' as desc, null::numeric total_assets,
                       ' ' image_path, ' ' image_file_name, 0 as is_fallback
				from gfg.gfg_template_component_asset_map sl
				where template_component_map_id = p_asset_id
				and asset_type_id = 12
				and published_date <= v_sysdate
             	and exists (select 1 from gfg.gfg_asset_entity_map eam
                            where eam.asset_id = sl.asset_id
                            and eam.asset_type_id = sl.asset_type_id
                            and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                            and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count_all
            )
                            group by eam.asset_id, eam.asset_type_id
                            having count(1) = v_ent_count)
          		union
				select  template_component_asset_map_id, p_asset_id template_component_map_id, rno asset_order, asset_id, asset_type_id,
                    	null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, updated_date,
                    	created_by, updated_by, is_active, is_deleted, is_published, published_date, asset_guid, title_alias, asset_title,
                    	short_desc as desc, total_assets, image_path image_path, image_file_name image_file_name, 1 as is_fallback
               	from (
                    select asset_list_id template_component_asset_map_id, p_asset_id template_component_map_id,
                    	   row_number() over(order by al.published_date desc) rno, asset_id, asset_type_id, null asset_meta, show_in_web,
                    	   show_in_mobile, show_in_app, published_version_number, is_trashed, created_date, updated_date, created_by, updated_by,
                    	   is_active, is_deleted, is_published, published_date, asset_guid, al.title_alias, al.asset_title, al.short_desc,
                    	   al.total_assets, al.image_path, al.image_file_name
					from gfg.gfg_asset_list al
                    where al.is_active = 1
                    and al.is_deleted = 0
                    and al.is_published = 1
                    and al.published_date <= v_sysdate
                    and al.asset_type_id in (1,2,4,5)
                    and al.asset_list_id not in (select assetlid from unnest(v_arr_asset_list_id) u(assetlid))
					and exists (select 1
                                from   gfg.gfg_asset_entity_map eam
                                where  eam.asset_id = al.asset_id
                                and    eam.asset_type_id = al.asset_type_id 
                                and    eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count_all
            )
                                group by eam.asset_id, eam.asset_type_id
                                having count(1) = v_ent_count)
					-- and p_use_fallback = 1
                	  ) tab
                )tab
            ) all_data where rnk between v_fromrownumber and v_torownumber
            order by rnk
        ) a
    ) t;
    
    select count(1) v_asset_count
    into v_tot_asset_count
    from (
        select tab.*,row_number() over(order by is_fallback,asset_order) rnk
          from 
            (select sl.template_component_asset_map_id, sl.template_component_map_id,sl.asset_order, 
                    sl.asset_id, sl.asset_type_id, sl.asset_meta, sl.show_in_web, sl.show_in_mobile,
                    sl.show_in_app,  ae.published_version_number, ae.is_trashed,  ae.created_date,
                    ae.updated_date, ae.created_by,  ae.updated_by, ae.is_active, ae.is_deleted,
                    ae.is_published, ae.published_date, sl.asset_guid, ae.title_alias,ae.asset_title,
                    ae.short_desc as desc ,ae.total_assets,ae.image_path,ae.image_file_name,
                    0 as is_fallback
             from gfg.gfg_template_component_asset_map sl
             join gfg.swa_asset_list ae
             on   ae.asset_id= sl.asset_id
             and  ae.asset_type_id = sl.asset_type_id 
             where  ae.is_published=1
             and    ae.is_trashed=0
             and    ae.published_date<=v_sysdate
             and    template_component_map_id=p_asset_id
             and    ae.asset_list_id =any (v_str_arr_asset_list_id::numeric[]) 
         union                 
             select sl.*,asset_meta->>'title_alias' as title_alias , asset_meta->>'title' as asset_title ,
             ' ' as desc ,null::numeric total_assets,' ' image_path,' ' image_file_name,0 as is_fallback
             from gfg.gfg_template_component_asset_map  sl 
             where 
             template_component_map_id=p_asset_id
             and asset_type_id=12
             and  published_date<=v_sysdate
             and  exists (select 1 from   gfg.gfg_asset_entity_map eam
                        where eam.asset_id= sl.asset_id
                        and eam.asset_type_id = sl.asset_type_id 
                          and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                          and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count_all
            )
                           group by eam.asset_id,eam.asset_type_id
                                      having count(1)=v_ent_count         
         
                          )
          union
               select  template_component_asset_map_id, p_asset_id template_component_map_id, 
                rno asset_order, asset_id, 
               asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
               is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
               is_published, published_date, asset_guid,
               title_alias,asset_title,short_desc as desc , total_assets,image_path image_path,
               image_file_name image_file_name,1 as is_fallback
               from (
                     select asset_list_id template_component_asset_map_id, 
                     p_asset_id template_component_map_id, 
                      row_number() over(order by al.published_date desc) rno, asset_id, 
                     asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, 
                     published_version_number, is_trashed, created_date, updated_date, created_by, 
                     updated_by, is_active, is_deleted, is_published, published_date, asset_guid,
                     al.title_alias,al.asset_title,al.short_desc ,al.total_assets
                     ,al.image_path,al.image_file_name
                      from gfg.gfg_asset_list al 
                      where  al.is_active=1
                      and    al.is_deleted=0
                      and    al.is_published=1
                      and    al.published_date<=v_sysdate
                      and    al.asset_type_id in (1,2,4,5) 
                      and    al.asset_list_id not in (select assetlid
                                                        from unnest(v_arr_asset_list_id) u(assetlid))
                      and    exists (select 1
                             from   gfg.gfg_asset_entity_map eam
                             where  eam.asset_id= al.asset_id
                             and    eam.asset_type_id = al.asset_type_id 
                             and    eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                     and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count_all
            )
                                  group by eam.asset_id,eam.asset_type_id
                                  having count(1)=v_ent_count)
                      -- and    p_use_fallback=1            
                            ) tab
                --where rno<=v_req_asset_count
             )tab 
             )b ;
    --  =================== get cursors
    
        open p_showcase_cur for     
        select *
        from ( 
          select tab.*,row_number() over(order by is_fallback,asset_order) rnk
          from 
            (select sl.template_component_asset_map_id, sl.template_component_map_id,sl.asset_order, 
                    sl.asset_id, sl.asset_type_id, sl.asset_meta, sl.show_in_web, sl.show_in_mobile,
                    sl.show_in_app,  ae.published_version_number, ae.is_trashed,  ae.created_date,
                    ae.updated_date, ae.created_by,  ae.updated_by, ae.is_active, ae.is_deleted,
                    ae.is_published, ae.published_date, sl.asset_guid, ae.title_alias,ae.asset_title,
                    ae.short_desc as desc ,ae.total_assets,ae.image_path,ae.image_file_name,
                    0 as is_fallback, ae.short_title, a.full_text
             from gfg.gfg_template_component_asset_map sl
             join gfg.swa_asset_list ae
             on   ae.asset_id= sl.asset_id
             and  ae.asset_type_id = sl.asset_type_id 
              -- --------------------------------------------
                   	  -- changes to show fulltext in case of articles.
                   	  left join  gfg.gfg_article a
                      on a.article_id = ae.asset_id
                      and ae.asset_type_id = 1
                      -- --------------------------------------------
             where  ae.is_published=1
             and    ae.is_trashed=0
             and    ae.published_date<=v_sysdate
             and    template_component_map_id=p_asset_id
             and    ae.asset_list_id =any (v_str_arr_asset_list_id::numeric[])
             and    (sl.asset_id,sl.asset_type_id ) in 
         
                                         ( select a.asset_id,a.asset_type_id from json_populate_recordset(null::type_asset, v_assets) a
                                         )
         union                 
             select sl.*,asset_meta->>'title_alias' as title_alias , asset_meta->>'title' as asset_title ,
             ' ' as desc ,null::numeric total_assets,' ' image_path,' ' image_file_name,0 as is_fallback, null short_title, 'b' full_text
             from gfg.gfg_template_component_asset_map  sl 
             where 
             template_component_map_id=p_asset_id
             and asset_type_id=12
             and  published_date<=v_sysdate
             and  exists (select 1 from   gfg.gfg_asset_entity_map eam
                        where eam.asset_id= sl.asset_id
                        and eam.asset_type_id = sl.asset_type_id 
                          and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                          and exists (select 1
                            			from   gfg.gfg_asset_entity_map aem
                                        where  aem.asset_id = eam.asset_id
                                        and    aem.asset_type_id = eam.asset_type_id
                                        and    aem.entity_role_map_id =any (v_str_entityrole_mapid_all::numeric[])
                                        group by aem.asset_id, aem.asset_type_id
                                        having count(1) = v_ent_count_all
            )
                           group by eam.asset_id,eam.asset_type_id
                                      having count(1)=v_ent_count         
         
                          )
              and    (sl.asset_id,sl.asset_type_id ) in 
         
                                         ( select a.asset_id,a.asset_type_id from json_populate_recordset(null::type_asset, v_assets) a
                                         )              
          union
               select  template_component_asset_map_id, p_asset_id template_component_map_id, 
                rno asset_order, asset_id, 
               asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
               is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
               is_published, published_date, asset_guid,
               title_alias,asset_title,short_desc as desc , total_assets,image_path image_path,
               image_file_name image_file_name,1 as is_fallback,short_title, full_text -- coalesce(full_text,short_desc) as full_text
               from (
                     select al.asset_list_id template_component_asset_map_id, 
                     p_asset_id template_component_map_id, 
                      row_number() over(order by al.published_date desc) rno, al.asset_id, 
                     al.asset_type_id, null asset_meta, al.show_in_web, al.show_in_mobile, al.show_in_app, 
                     al.published_version_number, al.is_trashed, al.created_date, al.updated_date, al.created_by, 
                     al.updated_by, al.is_active, al.is_deleted, al.is_published, al.published_date, al.asset_guid,
                     al.title_alias,al.asset_title,al.short_desc ,al.total_assets
                     ,al.image_path,al.image_file_name, al.short_title,
                     a.full_text
                      from gfg.gfg_asset_list al
                   	  -- --------------------------------------------
                   	  -- changes to show fulltext in case of articles.
                   	  left join  gfg.gfg_article a
                      on a.article_id = al.asset_id
                      and al.asset_type_id = 1
                      -- --------------------------------------------
                      where  al.is_active=1
                      and    al.is_deleted=0
                      and    al.is_published=1
                      and    al.published_date<=v_sysdate
                      and    al.asset_type_id in (1,2,4,5) 
                      and    al.asset_list_id not in (select assetlid
                                                        from unnest(v_arr_asset_list_id) u(assetlid))
                      and    (al.asset_id,al.asset_type_id ) in 
         
                                         ( select a.asset_id,a.asset_type_id from json_populate_recordset(null::type_asset, v_assets) a
                                         )   
                      -- and    p_use_fallback=1                   
                            ) tab
             )tab 
             ) all_data --where rnk between v_fromrownumber and v_torownumber
             order by rnk;
             
           open p_showcase_ent_cur for
         
         select *,gfg.gfg_get_entity_name (entity_role_map_id) entity_name ,
                 gfg.gfg_get_entity_display_name_by_language(v_language_id, entity_role_map_id) ent_disp_name
         from gfg.gfg_asset_entity_map ae
         where (asset_id,asset_type_id ) in 
         
                                         ( select asset_id,asset_type_id from json_populate_recordset(null::type_asset, v_assets) a
                                         )
                                     order by asset_id,asset_type_id    
                                  ;
            open p_showcase_asset_author_cur for
             select tab.asset_id,tab.asset_type_id, 
             al.author_id,gfg.gfg_get_user_disp_name(al.author_id) author_name,
             (select full_name from gfg.gfg_user where user_id=al.author_id) full_name,
             (select user_name from gfg.gfg_user where user_id=al.author_id) user_name
                     from ( select asset_id,asset_type_id 
                            from json_populate_recordset(null::type_asset, v_assets) a
                          ) tab
                    join  swa.swa_author_action al
                     on   tab.asset_id =  al.asset_id
                     and  tab.asset_type_id =  al.asset_type_id
                     and  al.action_id=4       
                     order by tab.asset_id,tab.asset_type_id,  al.author_id; 
             
            open p_template_comp_cur for
               
               select template_component_map_id,is_published,0 is_trashed,updated_by,updated_date as published_date
               , 1 as published_version_number,v_tot_asset_count v_asset_count 
               from gfg.gfg_template_component_map
               where template_component_map_id=p_asset_id;
 
end;

 $_$;


--
