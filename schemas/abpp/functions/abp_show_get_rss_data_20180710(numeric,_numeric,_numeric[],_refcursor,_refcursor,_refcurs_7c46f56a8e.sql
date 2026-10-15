-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_show_get_rss_data_20180710(numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: abp_show_get_rss_data_20180710(numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_show_get_rss_data_20180710(p_time numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_rss_cur refcursor, p_image_cur refcursor, p_article_img_cur refcursor, p_article_video_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
     v_sysdate timestamp;
     v_ent_count numeric ;
     v_video_type_id numeric := 4;
     v_article_type_id numeric := 1;
     v_album_type_id numeric := 2;
     v_array numeric[];
     v_instent_entity_role_map_id numeric;
     
     
begin
	
     v_sysdate := current_timestamp at time zone 'utc';
     
     select array(SELECT ERM.ENTITY_ROLE_MAP_ID
                  FROM   abp.abp_ENTITY_ROLE_MAP ERM
                  JOIN   abp.abp_ENTITY_MASTER EM
                  on     EM.entity_master_id = erm.entity_master_id
                  join   abp.abp_ENTITY_CATEGORY ec
                  on     ec.entity_role_id = ERM.ENTITY_ROLE_ID
                  where  ERM.ENTITY_ROLE_ID in (SELECT ENTITY_ROLE_ID
                                                FROM   abp.abp_ENTITY_CATEGORY c1
                                                JOIN   UNNEST(Array['Language']) M(CATEGORY_NAME)
                                                ON     M.CATEGORY_NAME = C1.CATEGORY_NAME
                                                WHERE  C1.IS_active = 1
                                                and    c1.is_deleted = 0
                                                and    c1.is_published = 1
                                               )
                  and ERM.IS_active = 1
                 )
	into v_array;
     
    select count(1)
    into   v_ent_count
    from   (select entityid from unnest(p_entityrole_mapid) U(entityid)) a;
    
    select r.entity_role_map_id 
    into v_instent_entity_role_map_id
    from abp.abp_entity_master M 
    inner join abp.abp_entity_role_map r 
    on (M.entity_master_id = r.entity_master_id)
    where entity_name ='Live Match' ;
    
    
    
     if v_ent_count > 0 then
     	
          open p_rss_cur for
          select *
          from
          (
              select sa.title_alias, sa.title, sa.full_text, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_article_type_id as asset_type_id,
              		 sa.article_id, abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, abp.abp_get_user_display_name(aa.author_id) as user_name,
              		 abp.abp_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date, 
              		 -- is_instent_asset column added by purushottam for instant asset on dated 20180521
              		(case when eminst.asset_entity_map_id is not null then 1 else 0 end) is_instant_asset  -- 1 for instant asset and 0 non instant
              from   abp.abp_article sa
              join   abp.abp_asset_list sal
              on     sal.asset_id = sa.article_id
              and    sal.asset_type_id = v_article_type_id
              join   abp.abp_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   abp.abp_author_action aa
              on     aa.asset_id = sa.article_id
              and    aa.asset_type_id = sal.asset_type_id
              and    aa.action_id = 4
              left join abp.abp_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) U(entity_id))
              -- added by purushottam for instant asset on dated 20180521
              left join abp.abp_asset_entity_map eminst
              on     eminst.asset_type_id = sal.asset_type_id
              and    eminst.asset_id = sal.asset_id
              and    eminst.entity_role_map_id = v_instent_entity_role_map_id
              ---- end on dated 20180521
              
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_article_type_id = coalesce(p_asset_type_id,v_article_type_id)
              and    sa.is_published = 1
              and    exists(select 1
                            from   abp.abp_asset_entity_map aem
                            where  aem.asset_id = sa.article_id
                            and    aem.asset_type_id = v_article_type_id
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest(p_entityrole_mapid) U(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = v_ent_count)
              union
              select sa.title_alias, sa.title, sa.album_desc, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_album_type_id as asset_type_id,
              		 sa.album_id, abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, abp.abp_get_user_display_name(aa.author_id) as user_name,
              		 abp.abp_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date, 
              		-- is_instent_asset column added by purushottam for instant asset on dated 20180521
              		(case when eminst.asset_entity_map_id is not null then 1 else 0 end) is_instant_asset
              from   abp.abp_album sa
              join   abp.abp_asset_list sal
              on     sal.asset_id = sa.album_id
              and    sal.asset_type_id = v_album_type_id
              join   abp.abp_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   abp.abp_author_action aa
              on     aa.asset_id = sa.album_id
              and    aa.asset_type_id = v_album_type_id
              and    aa.action_id = 4
              left join abp.abp_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) U(entity_id))
              -- added by purushottam for instant asset on dated 20180521
              left join abp.abp_asset_entity_map eminst
              on     eminst.asset_type_id = sal.asset_type_id
              and    eminst.asset_id = sal.asset_id
              and    eminst.entity_role_map_id = v_instent_entity_role_map_id
              ---- end on dated 20180521
              
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_album_type_id = coalesce(p_asset_type_id,v_album_type_id)
              and    sa.is_published = 1
              and    exists(select 1
                            from   abp.abp_asset_entity_map aem
                            where  aem.asset_id = sa.album_id
                            and aem.asset_type_id = v_album_type_id
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest(p_entityrole_mapid) U(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = v_ent_count)
              union
              select sv.title_alias, sv.title, sv.video_desc, sv.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_video_type_id as asset_type_id,
              		 sv.video_id, abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, abp.abp_get_user_display_name(aa.author_id) user_name,
              		 abp.abp_get_entity_name(aem.entity_role_map_id) as l_entity_name, sv.updated_date,
              		-- is_instent_asset column added by purushottam for instant asset on dated 20180521
              		(case when eminst.asset_entity_map_id is not null then 1 else 0 end) is_instant_asset
              from   abp.abp_video sv
              join   abp.abp_asset_list sal
              on     sal.asset_id = sv.video_id
              and    sal.asset_type_id = v_video_type_id
              join   abp.abp_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   abp.abp_author_action aa
              on     aa.asset_id = sv.video_id
              and    aa.asset_type_id = v_video_type_id
              and    aa.action_id = 4
              left join abp.abp_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) U(entity_id))
              -- added by purushottam for instant asset on dated 20180521
              left join abp.abp_asset_entity_map eminst
              on     eminst.asset_type_id = sal.asset_type_id
              and    eminst.asset_id = sal.asset_id
              and    eminst.entity_role_map_id = v_instent_entity_role_map_id
              ---- end on dated 20180521
              
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_video_type_id = coalesce(p_asset_type_id,v_video_type_id)
              and    sv.is_published = 1
              and    exists(select 1
                            from   abp.abp_asset_entity_map aem
                            where  aem.asset_id = sv.video_id
                            and    aem.asset_type_id = v_video_type_id
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest(p_entityrole_mapid) U(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = v_ent_count)
          )rss
          order by  is_instant_asset desc, published_date desc;
          
          open p_image_cur for 
          select aam.album_id, aam.is_cover, i.*
          from   abp.abp_album_asset_map aam
          join   abp.abp_image i
          on     i.image_id = aam.asset_id
          where  album_id in (select asset_id
                              from abp.abp_asset_list
                              where asset_type_id = v_album_type_id
                              and published_date >= v_sysdate - ( p_time || ' hours')::interval
                              and published_date <= v_sysdate)
		and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   abp.abp_asset_entity_map aem
                        where  aem.asset_id = aam.album_id
                        and    aem.asset_type_id = v_album_type_id
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = v_ent_count)
		order by 1;
          
          open p_article_img_cur for
          select aam.article_id, aam.is_cover, i.*
          from   abp.abp_article_asset_map aam
          join   abp.abp_image i
          on     i.image_id = aam.asset_id
		where  article_id in(select asset_id
                               from   abp.abp_asset_list
                               where  asset_type_id = v_article_type_id
                               and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                               and    published_date <= v_sysdate)
		and    aam.asset_type_id = 3
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   abp.abp_asset_entity_map aem
                        where  aem.asset_id = aam.article_id
                        and    aem.asset_type_id = v_article_type_id
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = v_ent_count);
          
          open p_article_video_cur for
          select aam.article_id, v.*
          from   abp.abp_article_asset_map aam
          join   abp.abp_video v
          on     v.video_id = aam.asset_id
		where  article_id in(select asset_id
                               from   abp.abp_asset_list
                               where  asset_type_id = v_article_type_id
                               and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                               and    published_date <= v_sysdate)
		and    aam.asset_type_id = 4
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   abp.abp_asset_entity_map aem
                        where  aem.asset_id = aam.article_id
                        and    aem.asset_type_id = v_article_type_id
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest(p_entityrole_mapid) U(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = v_ent_count);
          
    	else
    	
     	open  p_rss_cur for
        	select *
          from
          (
              select sa.title_alias, sa.title, sa.full_text, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_article_type_id as asset_type_id,
              		 sa.article_id, abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, abp.abp_get_user_display_name(aa.author_id) user_name,
              		 abp.abp_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date,
              		-- is_instent_asset column added by purushottam for instant asset on dated 20180521
              		(case when eminst.asset_entity_map_id is not null then 1 else 0 end) is_instant_asset
              from   abp.abp_article sa
              join   abp.abp_asset_list sal
              on     sal.asset_id = sa.article_id
              and    sal.asset_type_id = v_article_type_id
              join   abp.abp_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   abp.abp_author_action aa
              on     aa.asset_id = sa.article_id
              and    aa.asset_type_id = v_article_type_id
              and    aa.action_id=4
              left join abp.abp_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) U(entity_id))
             -- added by purushottam for instant asset on dated 20180521
              left join abp.abp_asset_entity_map eminst
              on     eminst.asset_type_id = sal.asset_type_id
              and    eminst.asset_id = sal.asset_id
              and    eminst.entity_role_map_id = v_instent_entity_role_map_id
              ---- end on dated 20180521
              
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_article_type_id = coalesce(p_asset_type_id,v_article_type_id)
              and    sa.is_published = 1
              union
              select sa.title_alias, sa.title, sa.album_desc, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_album_type_id as asset_type_id,
              		 sa.album_id, abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, abp.abp_get_user_display_name(aa.author_id) user_name,
              		 abp.abp_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date,
              		-- is_instent_asset column added by purushottam for instant asset on dated 20180521
              		(case when eminst.asset_entity_map_id is not null then 1 else 0 end) is_instant_asset
              from   abp.abp_album sa
              join   abp.abp_asset_list sal
              on     sal.asset_id = sa.album_id
              and    sal.asset_type_id = v_album_type_id
              join   abp.abp_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   abp.abp_author_action aa
              on     aa.asset_id = sa.album_id
              and    aa.asset_type_id = v_album_type_id
              and    aa.action_id = 4
              left join abp.abp_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) U(entity_id))
              -- added by purushottam for instant asset on dated 20180521
              left join abp.abp_asset_entity_map eminst
              on     eminst.asset_type_id = sal.asset_type_id
              and    eminst.asset_id = sal.asset_id
              and    eminst.entity_role_map_id = v_instent_entity_role_map_id
              ---- end on dated 20180521
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_album_type_id = coalesce(p_asset_type_id,v_album_type_id)
              and    sa.is_published = 1
              union
              select sv.title_alias, sv.title, sv.video_desc, sv.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_video_type_id as asset_type_id,
              		 sv.video_id, abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, abp.abp_get_user_display_name(aa.author_id) user_name,
              		 abp.abp_get_entity_name(aem.entity_role_map_id) as l_entity_name, sv.updated_date,
              		-- is_instent_asset column added by purushottam for instant asset on dated 20180521
              		(case when eminst.asset_entity_map_id is not null then 1 else 0 end) is_instant_asset
              from   abp.abp_video sv
              join   abp.abp_asset_list sal
              on     sal.asset_id = sv.video_id
              and    sal.asset_type_id = v_video_type_id
              join   abp.abp_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   abp.abp_author_action  aa
              on     aa.asset_id = sv.video_id
              and    aa.asset_type_id = v_video_type_id
              and    aa.action_id = 4
              left join abp.abp_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) U(entity_id))
              -- added by purushottam for instant asset on dated 20180521
              left join abp.abp_asset_entity_map eminst
              on     eminst.asset_type_id = sal.asset_type_id
              and    eminst.asset_id = sal.asset_id
              and    eminst.entity_role_map_id = v_instent_entity_role_map_id
              ---- end on dated 20180521
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_video_type_id = coalesce(p_asset_type_id,v_video_type_id)
              and    sv.is_published = 1
          )rss
          order by is_instant_asset desc, published_date desc;
          
          open p_image_cur for 
          select aam.album_id, aam.is_cover, i.*
          from   abp.abp_album_asset_map aam
          join   abp.abp_image i
          on     i.image_id = aam.asset_id
          where  album_id in (select asset_id
                              from   abp.abp_asset_list
                              where  asset_type_id = v_album_type_id
                              and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                              and    published_date <= v_sysdate)
		and    aam.is_published=1
          and    aam.is_deleted=0
          order by 1;
          
          open p_article_img_cur for
          select aam.article_id, aam.is_cover, i.*
          from   abp.abp_article_asset_map aam
          join   abp.abp_image i
          on     i.image_id = aam.asset_id
          where  article_id in (select asset_id
                                from   abp.abp_asset_list
                                where  asset_type_id = v_article_type_id
                                and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                                and    published_date <= v_sysdate)
		and aam.asset_type_id = 3
          and aam.is_published = 1
          and aam.is_deleted = 0;
          
          open p_article_video_cur for
          select aam.article_id, v.*
          from   abp.abp_article_asset_map aam
          join   abp.abp_video v
          on     v.video_id = aam.asset_id
          where  article_id in (select asset_id
                                from   abp.abp_asset_list
                                where  asset_type_id = v_article_type_id
                                and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                                and    published_date <= v_sysdate)
		and aam.asset_type_id = 4
          and aam.is_published = 1
          and aam.is_deleted = 0;
          
	end if;

end;

$$;


--
