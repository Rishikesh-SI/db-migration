-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_show_get_rss_data(numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: jafc_show_get_rss_data(numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_show_get_rss_data(p_time numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_rss_cur refcursor, p_image_cur refcursor, p_article_img_cur refcursor, p_article_video_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
     v_sysdate timestamp;
     v_ent_count numeric ;
     v_video_type_id numeric := 4;
     v_article_type_id numeric := 1;
     v_album_type_id numeric := 2;
     v_array numeric[];
     
begin
	
     v_sysdate := current_timestamp at time zone 'utc';
     
     select array(select erm.entity_role_map_id
                  from   jafc.jafc_entity_role_map erm
                  join   jafc.jafc_entity_master em
                  on     em.entity_master_id = erm.entity_master_id
                  join   jafc.jafc_entity_category ec
                  on     ec.entity_role_id = erm.entity_role_id
                  where  erm.entity_role_id in (select entity_role_id
                                                from   jafc.jafc_entity_category c1
                                                join   unnest(array['language']) m(category_name)
                                                on     m.category_name = c1.category_name
                                                where  c1.is_active = 1
                                                and    c1.is_deleted = 0
                                                and    c1.is_published = 1
                                               )
                  and erm.is_active = 1
                 )
	into v_array;
     
    	select count(1)
    	into   v_ent_count
    	from   (select entityid from unnest(p_entityrole_mapid) u(entityid)) a;
     
     if v_ent_count > 0 then
     	
          open p_rss_cur for
          select *
          from
          (
              select sa.title_alias, sa.title, sa.full_text, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_article_type_id as asset_type_id,
              		 sa.article_id, jafc.jafc_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 jafc.jafc_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, jafc.jafc_get_user_display_name(aa.author_id) as user_name,
              		 jafc.jafc_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date
              from   jafc.jafc_article sa
              join   jafc.jafc_asset_list sal
              on     sal.asset_id = sa.article_id
              and    sal.asset_type_id = v_article_type_id
              join   jafc.jafc_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   jafc.jafc_author_action aa
              on     aa.asset_id = sa.article_id
              and    aa.asset_type_id = sal.asset_type_id
              and    aa.action_id = 4
              left join jafc.jafc_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) u(entity_id))
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_article_type_id = coalesce(p_asset_type_id,v_article_type_id)
              and    sa.is_published = 1
              and    exists(select 1
                            from   jafc.jafc_asset_entity_map aem
                            where  aem.asset_id = sa.article_id
                            and    aem.asset_type_id = v_article_type_id
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest(p_entityrole_mapid) u(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = v_ent_count)
              union
              select sa.title_alias, sa.title, sa.album_desc, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_album_type_id as asset_type_id,
              		 sa.album_id, jafc.jafc_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 jafc.jafc_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, jafc.jafc_get_user_display_name(aa.author_id) as user_name,
              		 jafc.jafc_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date
              from   jafc.jafc_album sa
              join   jafc.jafc_asset_list sal
              on     sal.asset_id = sa.album_id
              and    sal.asset_type_id = v_album_type_id
              join   jafc.jafc_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   jafc.jafc_author_action aa
              on     aa.asset_id = sa.album_id
              and    aa.asset_type_id = v_album_type_id
              and    aa.action_id = 4
              left join jafc.jafc_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) u(entity_id))
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_album_type_id = coalesce(p_asset_type_id,v_album_type_id)
              and    sa.is_published = 1
              and    exists(select 1
                            from   jafc.jafc_asset_entity_map aem
                            where  aem.asset_id = sa.album_id
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest(p_entityrole_mapid) u(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = v_ent_count)
              union
              select sv.title_alias, sv.title, sv.video_desc, sv.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_video_type_id as asset_type_id,
              		 sv.video_id, jafc.jafc_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 jafc.jafc_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, jafc.jafc_get_user_display_name(aa.author_id) user_name,
              		 jafc.jafc_get_entity_name(aem.entity_role_map_id) as l_entity_name, sv.updated_date
              from   jafc.jafc_video sv
              join   jafc.jafc_asset_list sal
              on     sal.asset_id = sv.video_id
              and    sal.asset_type_id = v_video_type_id
              join   jafc.jafc_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   jafc.jafc_author_action aa
              on     aa.asset_id = sv.video_id
              and    aa.asset_type_id = v_video_type_id
              and    aa.action_id = 4
              left join jafc.jafc_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) u(entity_id))
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_video_type_id = coalesce(p_asset_type_id,v_video_type_id)
              and    sv.is_published = 1
              and    exists(select 1
                            from   jafc.jafc_asset_entity_map aem
                            where  aem.asset_id = sv.video_id
                            and    aem.asset_type_id = v_video_type_id
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest(p_entityrole_mapid) u(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = v_ent_count)
          )rss
          order by published_date desc;
          
          open p_image_cur for 
          select aam.album_id, aam.is_cover, i.*
          from   jafc.jafc_album_asset_map aam
          join   jafc.jafc_image i
          on     i.image_id = aam.asset_id
          where  album_id in (select asset_id
                              from jafc.jafc_asset_list
                              where asset_type_id = v_album_type_id
                              and published_date >= v_sysdate - ( p_time || ' hours')::interval
                              and published_date <= v_sysdate)
		and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   jafc.jafc_asset_entity_map aem
                        where  aem.asset_id = aam.album_id
                        and    aem.asset_type_id = v_album_type_id
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest(p_entityrole_mapid) u(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = v_ent_count)
		order by 1;
          
          open p_article_img_cur for
          select aam.article_id, aam.is_cover, i.*
          from   jafc.jafc_article_asset_map aam
          join   jafc.jafc_image i
          on     i.image_id = aam.asset_id
		where  article_id in(select asset_id
                               from   jafc.jafc_asset_list
                               where  asset_type_id = v_article_type_id
                               and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                               and    published_date <= v_sysdate)
		and    aam.asset_type_id = 3
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   jafc.jafc_asset_entity_map aem
                        where  aem.asset_id = aam.article_id
                        and    aem.asset_type_id = v_article_type_id
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest(p_entityrole_mapid) u(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = v_ent_count);
          
          open p_article_video_cur for
          select aam.article_id, v.*
          from   jafc.jafc_article_asset_map aam
          join   jafc.jafc_video v
          on     v.video_id = aam.asset_id
		where  article_id in(select asset_id
                               from   jafc.jafc_asset_list
                               where  asset_type_id = v_article_type_id
                               and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                               and    published_date <= v_sysdate)
		and    aam.asset_type_id = 4
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   jafc.jafc_asset_entity_map aem
                        where  aem.asset_id = aam.article_id
                        and    aem.asset_type_id = v_article_type_id
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest(p_entityrole_mapid) u(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = v_ent_count);
          
    	else
    	
     	open  p_rss_cur for
        	select *
          from
          (
              select sa.title_alias, sa.title, sa.full_text, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_article_type_id as asset_type_id,
              		 sa.article_id, jafc.jafc_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 jafc.jafc_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, jafc.jafc_get_user_display_name(aa.author_id) user_name,
              		 jafc.jafc_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date
              from   jafc.jafc_article sa
              join   jafc.jafc_asset_list sal
              on     sal.asset_id = sa.article_id
              and    sal.asset_type_id = v_article_type_id
              join   jafc.jafc_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   jafc.jafc_author_action aa
              on     aa.asset_id = sa.article_id
              and    aa.asset_type_id = v_article_type_id
              and    aa.action_id=4
              left join jafc.jafc_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) u(entity_id))
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_article_type_id = coalesce(p_asset_type_id,v_article_type_id)
              and    sa.is_published = 1
              union
              select sa.title_alias, sa.title, sa.album_desc, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_album_type_id as asset_type_id,
              		 sa.album_id, jafc.jafc_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 jafc.jafc_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, jafc.jafc_get_user_display_name(aa.author_id) user_name,
              		 jafc.jafc_get_entity_name(aem.entity_role_map_id) as l_entity_name, sa.updated_date
              from   jafc.jafc_album sa
              join   jafc.jafc_asset_list sal
              on     sal.asset_id = sa.album_id
              and    sal.asset_type_id = v_album_type_id
              join   jafc.jafc_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   jafc.jafc_author_action aa
              on     aa.asset_id = sa.album_id
              and    aa.asset_type_id = v_album_type_id
              and    aa.action_id = 4
              left join jafc.jafc_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) u(entity_id))
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_album_type_id = coalesce(p_asset_type_id,v_album_type_id)
              and    sa.is_published = 1
              union
              select sv.title_alias, sv.title, sv.video_desc, sv.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_video_type_id as asset_type_id,
              		 sv.video_id, jafc.jafc_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 jafc.jafc_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, jafc.jafc_get_user_display_name(aa.author_id) user_name,
              		 jafc.jafc_get_entity_name(aem.entity_role_map_id) as l_entity_name, sv.updated_date
              from   jafc.jafc_video sv
              join   jafc.jafc_asset_list sal
              on     sal.asset_id = sv.video_id
              and    sal.asset_type_id = v_video_type_id
              join   jafc.jafc_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   jafc.jafc_author_action  aa
              on     aa.asset_id = sv.video_id
              and    aa.asset_type_id = v_video_type_id
              and    aa.action_id = 4
              left join jafc.jafc_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest(v_array) u(entity_id))
              where  sal.published_date >= v_sysdate - ( p_time || ' hours')::interval
              and    sal.published_date <= v_sysdate
              and    v_video_type_id = coalesce(p_asset_type_id,v_video_type_id)
              and    sv.is_published = 1
          )rss
          order by published_date desc;
          
          open p_image_cur for 
          select aam.album_id, aam.is_cover, i.*
          from   jafc.jafc_album_asset_map aam
          join   jafc.jafc_image i
          on     i.image_id = aam.asset_id
          where  album_id in (select asset_id
                              from   jafc.jafc_asset_list
                              where  asset_type_id = v_album_type_id
                              and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                              and    published_date <= v_sysdate)
		and    aam.is_published=1
          and    aam.is_deleted=0
          order by 1;
          
          open p_article_img_cur for
          select aam.article_id, aam.is_cover, i.*
          from   jafc.jafc_article_asset_map aam
          join   jafc.jafc_image i
          on     i.image_id = aam.asset_id
          where  article_id in (select asset_id
                                from   jafc.jafc_asset_list
                                where  asset_type_id = v_article_type_id
                                and    published_date >= v_sysdate - ( p_time || ' hours')::interval
                                and    published_date <= v_sysdate)
		and aam.asset_type_id = 3
          and aam.is_published = 1
          and aam.is_deleted = 0;
          
          open p_article_video_cur for
          select aam.article_id, v.*
          from   jafc.jafc_article_asset_map aam
          join   jafc.jafc_video v
          on     v.video_id = aam.asset_id
          where  article_id in (select asset_id
                                from   jafc.jafc_asset_list
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
