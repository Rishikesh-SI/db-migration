-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: khi
-- Object: khi_show_get_rss_data(numeric, numeric, numeric[], refcursor)
-- Type: FUNCTION

-- Name: khi_show_get_rss_data(numeric, numeric, numeric[], refcursor); Type: FUNCTION; Schema: khi; Owner: -
--

CREATE FUNCTION khi.khi_show_get_rss_data(p_time numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_rss_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare 
    v_time numeric;
    v_sysdate timestamp;
	v_ent_count numeric ;
    v_video_type_id numeric :=4;
    v_article_type_id numeric :=1;
    v_album_type_id numeric :=2;
    
begin
	
    v_sysdate:= current_timestamp at time zone 'utc';
    if p_time =48 then
    v_time:=72;
    
    else 
    v_time=p_time;
    end if;
    select count(1)
    into   v_ent_count
    from   (select entityid from unnest(p_entityrole_mapid) U(entityid)) a;
    
    if v_ent_count >0 then
    
    	open  p_rss_cur for
        select * from (
            select sa.title_alias, sa.title, sa.full_text, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_article_type_id as asset_type_id,
            sa.article_id, khi.khi_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, khi.khi_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
            aa.author_id user_id, khi.khi_get_user_display_name(aa.author_id) user_name
            from khi.khi_article sa
      		inner join khi.khi_asset_list sal
      		on sal.asset_id=sa.article_id
      		and  sal.asset_type_id=v_article_type_id
      		inner join khi.khi_author_action  aa
      		on aa.asset_id=sa.article_id
      		and aa.asset_type_id=v_article_type_id
      		and aa.action_id=4
      		where sal.published_date >= v_sysdate - ( v_time || ' hours')::interval
            and sal.published_date <= v_sysdate
      		and v_article_type_id=coalesce(p_asset_type_id,v_article_type_id)
    		and sa.is_published = 1
      		and    exists(select 1
                          from   khi.khi_asset_entity_map aem
                          where  aem.asset_id = sa.article_id
                          and    aem.asset_type_id = v_article_type_id
                          and    aem.entity_role_map_id in (select entity_role_mapid
                                                            from unnest(p_entityrole_mapid) U(entity_role_mapid))
                          group by aem.asset_id, aem.asset_type_id
                          having count(1) = v_ent_count)
      		union all
            select sa.title_alias, sa.title, sa.album_desc, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_album_type_id, sa.album_id,
            khi.khi_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, khi.khi_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
            aa.author_id user_id, khi.khi_get_user_display_name(aa.author_id) user_name
            from  khi.khi_album sa
            inner join khi.khi_asset_list sal
            on sal.asset_id=sa.album_id
            and  sal.asset_type_id=v_album_type_id
            inner join khi.khi_author_action  aa
            on aa.asset_id=sa.album_id
            and aa.asset_type_id=v_album_type_id
            and aa.action_id=4
            where sal.published_date >=v_sysdate - ( v_time || ' hours')::interval
            and sal.published_date <= v_sysdate
            and v_album_type_id=coalesce(p_asset_type_id,v_album_type_id)
    		and sa.is_published = 1
            and    exists(select 1
                          from   khi.khi_asset_entity_map aem
                          where  aem.asset_id = sa.album_id
                          and    aem.asset_type_id = v_album_type_id
                          and    aem.entity_role_map_id in (select entity_role_mapid
                                                            from unnest(p_entityrole_mapid) U(entity_role_mapid))
                          group by aem.asset_id, aem.asset_type_id
                          having count(1) = v_ent_count)
			union all
            select sv.title_alias, sv.title, sv.video_desc, sv.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_video_type_id, sv.video_id,
            khi.khi_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, khi.khi_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
            aa.author_id user_id, khi.khi_get_user_display_name(aa.author_id) user_name
            from  khi.khi_video sv
            inner join khi.khi_asset_list sal
            on sal.asset_id=sv.video_id
            and  sal.asset_type_id=v_video_type_id
            inner join khi.khi_author_action  aa
            on aa.asset_id=sv.video_id
            and aa.asset_type_id=v_video_type_id
            and aa.action_id=4
            where  sal.published_date >=v_sysdate - ( v_time || ' hours')::interval
            and sal.published_date <= v_sysdate
            and v_video_type_id=coalesce(p_asset_type_id,v_video_type_id)
    		and sv.is_published = 1
            and    exists(select 1
                          from   khi.khi_asset_entity_map aem
                          where  aem.asset_id = sv.video_id
                          and    aem.asset_type_id = v_video_type_id
                          and    aem.entity_role_map_id in (select entity_role_mapid
                                                            from unnest(p_entityrole_mapid) U(entity_role_mapid))
                          group by aem.asset_id, aem.asset_type_id
                          having count(1) = v_ent_count)
                                                                              
        )rss
        order by published_date desc;
	
    else
    	
        open  p_rss_cur for
        select * from (
            select sa.title_alias, sa.title, sa.full_text, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_article_type_id as asset_type_id,
            sa.article_id, khi.khi_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, khi.khi_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
            aa.author_id user_id, khi.khi_get_user_display_name(aa.author_id) user_name
            from khi.khi_article sa
            inner join khi.khi_asset_list sal
            on sal.asset_id=sa.article_id
            and  sal.asset_type_id=v_article_type_id
            inner join khi.khi_author_action  aa
            on aa.asset_id=sa.article_id
            and aa.asset_type_id=v_article_type_id
            and aa.action_id=4
            where sal.published_date >= v_sysdate - ( v_time || ' hours')::interval
            and sal.published_date <= v_sysdate
            and v_article_type_id=coalesce(p_asset_type_id,v_article_type_id)
            and sa.is_published = 1
            union all
            select sa.title_alias, sa.title, sa.album_desc, sa.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_album_type_id, sa.album_id,
            khi.khi_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, khi.khi_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
            aa.author_id user_id, khi.khi_get_user_display_name(aa.author_id) user_name
            from  khi.khi_album sa
            inner join khi.khi_asset_list sal
            on sal.asset_id=sa.album_id
            and  sal.asset_type_id=v_album_type_id
            inner join khi.khi_author_action  aa
            on aa.asset_id=sa.album_id
            and aa.asset_type_id=v_album_type_id
            and aa.action_id=4
            where sal.published_date >=v_sysdate - ( v_time || ' hours')::interval
            and sal.published_date <= v_sysdate
            and v_album_type_id=coalesce(p_asset_type_id,v_album_type_id)
            and sa.is_published = 1
            union all
            select sv.title_alias, sv.title, sv.video_desc, sv.published_date, sal.short_desc, sal.image_path, sal.image_file_name, v_video_type_id, sv.video_id,
            khi.khi_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, khi.khi_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
            aa.author_id user_id, khi.khi_get_user_display_name(aa.author_id) user_name
            from  khi.khi_video sv
            inner join khi.khi_asset_list sal
            on sal.asset_id=sv.video_id
            and  sal.asset_type_id=v_video_type_id
            inner join khi.khi_author_action  aa
            on aa.asset_id=sv.video_id
            and aa.asset_type_id=v_video_type_id
            and aa.action_id=4
            where  sal.published_date >=v_sysdate - ( v_time || ' hours')::interval
            and sal.published_date <= v_sysdate
            and v_video_type_id=coalesce(p_asset_type_id,v_video_type_id)
            and sv.is_published = 1
        )rss
        order by published_date desc;
	
    end if;

end;

$$;


--
