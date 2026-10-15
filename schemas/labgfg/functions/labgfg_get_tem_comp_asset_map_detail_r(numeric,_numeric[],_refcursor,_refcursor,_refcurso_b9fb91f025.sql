-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_get_tem_comp_asset_map_detail_r(numeric, numeric[], refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labgfg_get_tem_comp_asset_map_detail_r(numeric, numeric[], refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labgfg; Owner: -
--

CREATE FUNCTION labgfg.labgfg_get_tem_comp_asset_map_detail_r(p_asset_id numeric, p_entityrole_mapid numeric[], p_showcase_cur refcursor, p_showcase_ent_cur refcursor, p_showcase_asset_author_cur refcursor, p_template_comp_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
     v_asset_type_id numeric :=8;
     v_versionnumber numeric;
     v_image_path varchar(4000);
     v_ent_count numeric;
    
     v_sysdate              timestamp;
       v_language_id numeric;
     v_asset_count numeric:=0;
     v_req_asset_count numeric:=6;
     v_max_asset_order numeric:=0;
     
     v_arr_asset_list_id numeric[];
     v_arr_asset_list_id_cnt numeric;
     
     v_str_arr_asset_list_id varchar(1000000);
     v_str_entityrole_mapid varchar(1000000);
     
begin
	v_sysdate:=  current_timestamp at time zone 'utc'; 
     
     select count(1)
     into   v_ent_count
     from   unnest(p_entityrole_mapid)entity_id;
     
     v_str_entityrole_mapid:= '{'||array_to_string(p_entityrole_mapid,',')||'}';
     
     select labgfg.labgfg_get_entity_language_from_entities(p_entityrole_mapid)
    into v_language_id;
     
     select array(
                select ae.asset_list_id 
                from labgfg.labgfg_template_component_asset_map sl
                join labgfg.swa_asset_list ae
                on   ae.asset_id= sl.asset_id
                and  ae.asset_type_id = sl.asset_type_id 
                where   ae.is_published=1
                and     ae.is_trashed=0
                and ae.published_date<=v_sysdate
                and template_component_map_id=p_asset_id
                and exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                            where eam.asset_id= sl.asset_id
                            and eam.asset_type_id = sl.asset_type_id 
                            and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[] )
                            group by eam.asset_id,eam.asset_type_id
                            having count(1)=v_ent_count         
                            )
                  ) 
      into v_arr_asset_list_id;
     
     select count(1)
     into   v_arr_asset_list_id_cnt
     from   unnest(v_arr_asset_list_id)entity_id;
     
     v_str_arr_asset_list_id:=  '{'||array_to_string(v_arr_asset_list_id,',')||'}';
     
     select count(1) 
     into v_asset_count 
     from (        
           select s1.template_component_asset_map_id,s1.asset_order
           from labgfg.labgfg_template_component_asset_map  s1 
           where  template_component_map_id=p_asset_id
           and asset_type_id=12
           and  published_date<=v_sysdate
           and  exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                        where eam.asset_id= s1.asset_id
                        and eam.asset_type_id = s1.asset_type_id 
                        and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)=v_ent_count         
         
                       )
          )tab;
     
     select  max(asset_order)
     into  v_max_asset_order
     from (        
           select s1.template_component_asset_map_id,s1.asset_order
           from labgfg.labgfg_template_component_asset_map  s1 
           where  template_component_map_id=p_asset_id 
           and  published_date<=v_sysdate
           and  exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                        where eam.asset_id= s1.asset_id
                        and eam.asset_type_id = s1.asset_type_id 
                        and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                        group by eam.asset_id,eam.asset_type_id
                        having count(1)=v_ent_count         
         
                       )
          )tab;
          
     v_asset_count:=coalesce(v_asset_count,0)+coalesce(v_arr_asset_list_id_cnt,0);
     v_max_asset_order:=coalesce(v_max_asset_order,0);
     v_req_asset_count:=greatest((v_req_asset_count-v_asset_count),0);
     
     if v_req_asset_count = 0 then 
         open p_template_comp_cur for
         select * from labgfg.labgfg_template_component_asset_map
         where template_component_map_id=p_asset_id;
         
         open p_showcase_cur for
        select * from (select  sl.template_component_asset_map_id, sl.template_component_map_id, sl.asset_order, sl.asset_id,
                   sl.asset_type_id, sl.asset_meta,
          sl.show_in_web, sl.show_in_mobile, sl.show_in_app, ae.published_version_number, ae.is_trashed, 
          ae.created_date, ae.updated_date, ae.created_by, 
          ae.updated_by, ae.is_active, ae.is_deleted, ae.is_published, ae.published_date, sl.asset_guid,
          ae.title_alias,ae.asset_title   ,
        ae.short_desc as desc ,ae.total_assets,ae.image_path,ae.image_file_name
         from labgfg.labgfg_template_component_asset_map sl
         join labgfg.swa_asset_list ae
         on   ae.asset_id= sl.asset_id
        and  ae.asset_type_id = sl.asset_type_id 
         where   ae.is_published=1
          and     ae.is_trashed=0
         and ae.published_date<=v_sysdate
          and
         template_component_map_id=p_asset_id
         and exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                      where eam.asset_id= sl.asset_id
                      and eam.asset_type_id = sl.asset_type_id 
                        and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                         group by eam.asset_id,eam.asset_type_id
                                    having count(1)=v_ent_count         
                                    )
       union                 
         select s1.*,asset_meta->>'title_alias' as title_alias , asset_meta->>'title' as asset_title   ,
         ' ' as desc ,null total_assets,' ' image_path,' ' image_file_name
         from labgfg.labgfg_template_component_asset_map  s1
        
         where 
         template_component_map_id=p_asset_id
         and asset_type_id=12
        and  published_date<=v_sysdate
         and  exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                      where eam.asset_id= s1.asset_id
                      and eam.asset_type_id = s1.asset_type_id 
                        and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                         group by eam.asset_id,eam.asset_type_id
                                    having count(1)=v_ent_count         
       
           )
           )tab
           order by asset_order;
                                  
         open p_showcase_ent_cur for
         
         select *,labgfg.labgfg_get_entity_name (entity_role_map_id) entity_name ,
                 labgfg.labgfg_get_entity_display_name_by_language(v_language_id, entity_role_map_id) ent_disp_name
         from labgfg.labgfg_asset_entity_map ae
         where (asset_id,asset_type_id ) in 
         
                                         (select sl.asset_id,sl.asset_type_id 
                                           from labgfg.labgfg_template_component_asset_map sl
                                           where exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                                                          where eam.asset_id= sl.asset_id
                                                          and eam.asset_type_id = sl.asset_type_id 
                                                          and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                                          group by eam.asset_id,eam.asset_type_id
                                                          having count(1)=v_ent_count           
                                                       )
                                         and template_component_map_id=p_asset_id
                                         )
                                         order by asset_id,asset_type_id
                                  ;
         
         
          open p_showcase_asset_author_cur for
             select sl.asset_id,sl.asset_type_id ,
             al.author_id,labgfg.labgfg_get_user_disp_name(al.author_id) author_name
               from labgfg.labgfg_template_component_asset_map sl
               join swa.swa_author_action al
               on   sl.asset_id =  al.asset_id
               and  sl.asset_type_id =  al.asset_type_id
               and  al.action_id=4 
               where exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                              where eam.asset_id= sl.asset_id
                              and eam.asset_type_id = sl.asset_type_id 
                              and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[] )
                              group by eam.asset_id,eam.asset_type_id
                              having count(1)=v_ent_count           
                           )
             and template_component_map_id=p_asset_id  ; 
     else
            open p_template_comp_cur for
               select * from labgfg.labgfg_template_component_asset_map
               where template_component_map_id=p_asset_id
               union
               select  template_component_asset_map_id, p_asset_id template_component_map_id, 
               (v_max_asset_order+ rno) asset_order, asset_id, 
               asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
               is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
               is_published, published_date, asset_guid
               
               from (
               select asset_list_id template_component_asset_map_id, p_asset_id template_component_map_id, 
                row_number() over(order by al.published_date desc) rno, asset_id, 
               asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
               is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
               is_published, published_date, asset_guid
                from labgfg.labgfg_asset_list al
                where  al.is_active=1
                and    al.is_deleted=0
                and    al.is_published=1
                and    al.published_date<=v_sysdate
                and    al.asset_type_id in (1,2,4,5) 
                and    al.asset_list_id not in (select assetlid
                                                        from unnest(v_arr_asset_list_id) u(assetlid))
                and    exists (select 1
                       from   labgfg.labgfg_asset_entity_map eam
                       where  eam.asset_id= al.asset_id
                       and    eam.asset_type_id = al.asset_type_id 
                       and    eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                            group by eam.asset_id,eam.asset_type_id
                            having count(1)=v_ent_count)
                      ) tab
                where rno<=v_req_asset_count
                order by asset_order;
         
            open p_showcase_cur for
                select * from (select sl.template_component_asset_map_id, sl.template_component_map_id,
                      sl.asset_order, sl.asset_id, sl.asset_type_id, sl.asset_meta,
                  sl.show_in_web, sl.show_in_mobile, sl.show_in_app, ae.published_version_number, ae.is_trashed, 
                  ae.created_date, ae.updated_date, ae.created_by, 
                  ae.updated_by, ae.is_active, ae.is_deleted, ae.is_published, ae.published_date, sl.asset_guid,
                  ae.title_alias,ae.asset_title   ,
                ae.short_desc as desc ,ae.total_assets,ae.image_path,ae.image_file_name
                 from labgfg.labgfg_template_component_asset_map sl
                 join labgfg.swa_asset_list ae
                 on   ae.asset_id= sl.asset_id
                and  ae.asset_type_id = sl.asset_type_id 
                 where   ae.is_published=1
                  and     ae.is_trashed=0
                 and ae.published_date<=v_sysdate
                  and
                 template_component_map_id=p_asset_id
                 and exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                              where eam.asset_id= sl.asset_id
                              and eam.asset_type_id = sl.asset_type_id 
                                and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                 group by eam.asset_id,eam.asset_type_id
                                            having count(1)=v_ent_count         
                                            )
               union                 
                 select s1.*,asset_meta->>'title_alias' as title_alias , asset_meta->>'title' as asset_title   ,
                 ' ' as desc ,null::numeric total_assets,' ' image_path,' ' image_file_name
                 from labgfg.labgfg_template_component_asset_map  s1
                
                 where 
                 template_component_map_id=p_asset_id
                 and asset_type_id=12
                and  published_date<=v_sysdate
                 and  exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                              where eam.asset_id= s1.asset_id
                              and eam.asset_type_id = s1.asset_type_id 
                                and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                 group by eam.asset_id,eam.asset_type_id
                                            having count(1)=v_ent_count         
               
                   )
                union
                     select  template_component_asset_map_id, p_asset_id template_component_map_id, 
                     (v_max_asset_order+ rno) asset_order, asset_id, 
                     asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
                     is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
                     is_published, published_date, asset_guid,
                     title_alias,asset_title,short_desc as desc , total_assets,image_path image_path,
                     image_file_name image_file_name
                     from (
                     select asset_list_id template_component_asset_map_id, p_asset_id template_component_map_id, 
                      row_number() over(order by al.published_date desc) rno, asset_id, 
                     asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
                     is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
                     is_published, published_date, asset_guid,
                     al.title_alias,al.asset_title,al.short_desc ,null::numeric total_assets
                     ,al.image_path,al.image_file_name
                      from labgfg.labgfg_asset_list al
                      
                      where  al.is_active=1
                      and    al.is_deleted=0
                      and    al.is_published=1
                      and    al.published_date<=v_sysdate
                      and    al.asset_type_id in (1,2,4,5) 
                      and    al.asset_list_id not in (select assetlid
                                                        from unnest(v_arr_asset_list_id) u(assetlid))
                      and    exists (select 1
                             from   labgfg.labgfg_asset_entity_map eam
                             where  eam.asset_id= al.asset_id
                             and    eam.asset_type_id = al.asset_type_id 
                             and    eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                  group by eam.asset_id,eam.asset_type_id
                                  having count(1)=v_ent_count)
                            ) tab
                      where rno<=v_req_asset_count
                   )tab
                   
                   
                   order by asset_order;
                                  
         open p_showcase_ent_cur for
         
         select *,labgfg.labgfg_get_entity_name (entity_role_map_id) entity_name ,
                 labgfg.labgfg_get_entity_display_name_by_language(v_language_id, entity_role_map_id) ent_disp_name
         from labgfg.labgfg_asset_entity_map ae
         where (asset_id,asset_type_id ) in 
         
                                         (select sl.asset_id,sl.asset_type_id 
                                           from labgfg.labgfg_template_component_asset_map sl
                                           where exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                                                          where eam.asset_id= sl.asset_id
                                                          and eam.asset_type_id = sl.asset_type_id 
                                                          and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[] )
                                                          group by eam.asset_id,eam.asset_type_id
                                                          having count(1)=v_ent_count           
                                                       )
                                         and template_component_map_id=p_asset_id
                                         union
                                         select  asset_id, asset_type_id
                                         from (
                                         select row_number() over(order by al.published_date desc) rno, asset_id,  asset_type_id
                                          from labgfg.labgfg_asset_list al
                                          
                                          where  al.is_active=1
                                          and    al.is_deleted=0
                                          and    al.is_published=1
                                          and    al.published_date<=v_sysdate
                                          and    al.asset_type_id in (1,2,4,5) 
                                          and    al.asset_list_id not in (select assetlid
                                                        from unnest(v_arr_asset_list_id) u(assetlid))
                                          and    exists (select 1
                                                 from   labgfg.labgfg_asset_entity_map eam
                                                 where  eam.asset_id= al.asset_id
                                                 and    eam.asset_type_id = al.asset_type_id 
                                                 and    eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                                      group by eam.asset_id,eam.asset_type_id
                                                      having count(1)=v_ent_count)
                                                ) tab
                                          where rno<=v_req_asset_count
                                         )
                                     order by asset_id,asset_type_id    
                                  ;
         
         
          open p_showcase_asset_author_cur for
             select sl.asset_id,sl.asset_type_id ,
             al.author_id,labgfg.labgfg_get_user_disp_name(al.author_id) author_name
               from labgfg.labgfg_template_component_asset_map sl
               join swa.swa_author_action al
               on   sl.asset_id =  al.asset_id
               and  sl.asset_type_id =  al.asset_type_id
               and  al.action_id=4 
               where exists (select 1 from   labgfg.labgfg_asset_entity_map eam
                              where eam.asset_id= sl.asset_id
                              and eam.asset_type_id = sl.asset_type_id 
                              and eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[] )
                              group by eam.asset_id,eam.asset_type_id
                              having count(1)=v_ent_count           
                           )
             and template_component_map_id=p_asset_id  
             union
             select tab.asset_id,tab.asset_type_id, 
             al.author_id,labgfg.labgfg_get_user_disp_name(al.author_id) author_name
                     from (
                     select asset_list_id template_component_asset_map_id, p_asset_id template_component_map_id, 
                      row_number() over(order by al.published_date desc) rno, asset_id, 
                     asset_type_id, null asset_meta, show_in_web, show_in_mobile, show_in_app, published_version_number,
                     is_trashed, created_date, updated_date, created_by, updated_by, is_active, is_deleted, 
                     is_published, published_date, asset_guid,
                     al.title_alias,al.asset_title,al.short_desc as desc ,null::numeric total_assets
                     ,al.image_path,al.image_file_name
                      from labgfg.labgfg_asset_list al
                      
                      where  al.is_active=1
                      and    al.is_deleted=0
                      and    al.is_published=1
                      and    al.published_date<=v_sysdate
                      and    al.asset_type_id in (1,2,4,5)
                      and    al.asset_list_id not in (select assetlid
                                                        from unnest(v_arr_asset_list_id) u(assetlid))
                      and    exists (select 1
                             from   labgfg.labgfg_asset_entity_map eam
                             where  eam.asset_id= al.asset_id
                             and    eam.asset_type_id = al.asset_type_id 
                             and    eam.entity_role_map_id =any (v_str_entityrole_mapid::numeric[])
                                  group by eam.asset_id,eam.asset_type_id
                                  having count(1)=v_ent_count)
                            ) tab
                    join  swa.swa_author_action al
                     on   tab.asset_id =  al.asset_id
                     and  tab.asset_type_id =  al.asset_type_id
                     and  al.action_id=4        
                      where rno<=v_req_asset_count
             ; 
     end if;
     
 
end;

 $$;


--
