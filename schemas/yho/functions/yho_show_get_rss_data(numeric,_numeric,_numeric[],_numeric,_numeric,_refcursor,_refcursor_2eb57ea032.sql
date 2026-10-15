-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_show_get_rss_data(numeric, numeric, numeric[], numeric, numeric, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: yho_show_get_rss_data(numeric, numeric, numeric[], numeric, numeric, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: yho; Owner: -
--

CREATE FUNCTION yho.yho_show_get_rss_data(p_time numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_pagenumber numeric, p_itemnumber numeric, p_rss_cur refcursor, p_image_cur refcursor, p_article_img_cur refcursor, p_article_video_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
    v_time numeric;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_entity_query text := ' ';
    v_lang_ent_array numeric[];
    v_asset_list_id_array numeric[];
    v_fromrownumber numeric ; 
    v_torownumber numeric ;
    
begin
	
    p_pagenumber := coalesce(p_pagenumber,1) ;
    p_itemnumber := coalesce(p_itemnumber,25) ;
    
    v_fromrownumber := (p_pagenumber * p_itemnumber - (p_itemnumber - 1));
    v_torownumber   := (p_pagenumber * p_itemnumber);
    
    if p_time = 48 then
    	v_time := 48;
    else
    	v_time := p_time;
    end if;
       
    v_sysdate := current_timestamp at time zone 'utc';
    
    select array(SELECT ERM.ENTITY_ROLE_MAP_ID
                 FROM   yho.yho_ENTITY_ROLE_MAP ERM
                 JOIN   yho.yho_ENTITY_MASTER EM
                 on     EM.entity_master_id = erm.entity_master_id
                 join   yho.yho_ENTITY_CATEGORY ec
                 on     ec.entity_role_id = ERM.ENTITY_ROLE_ID
                 where  ERM.ENTITY_ROLE_ID in (SELECT ENTITY_ROLE_ID
                                               FROM   yho.yho_ENTITY_CATEGORY c1
                                               JOIN   UNNEST(Array['Language']) M(CATEGORY_NAME)
                                               ON     M.CATEGORY_NAME = C1.CATEGORY_NAME
                                               WHERE  C1.IS_active = 1
                                               and    c1.is_deleted = 0
                                               and    c1.is_published = 1
                                              )
                 and ERM.IS_active = 1
                )
	into v_lang_ent_array;
    
    select count(1)
    into   v_ent_count
    from   (select entityid
            from unnest(p_entityrole_mapid) U(entityid)) a;
	
    if v_ent_count > 0 then
    	
        v_entity_query := 'and exists(select 1
        							  from   yho.yho_asset_entity_map aem
                                      where  aem.asset_id = al.asset_id
                                      and    aem.asset_type_id = al.asset_type_id
                                      and    aem.entity_role_map_id in (select entity_role_mapid
                                      									from unnest($2) U(entity_role_mapid))
									  group by aem.asset_id, aem.asset_type_id
                                      having count(1) = '||v_ent_count||')';
        
    end if;
    
    execute 'select array(select asset_list_id
    					  from (select al.asset_list_id, row_number() over(order by published_date desc) srno
                          		from   yho.yho_asset_list al
                                join   yho.yho_entity_role_map erm
                                on     erm.entity_role_map_id = al.secondary_entity_role_map_id
                                and    erm.priority > 0
                                join   yho.yho_author_action aa
                                on     aa.asset_id = al.asset_id
                                and    aa.asset_type_id = al.asset_type_id
                                and    aa.action_id = 4
                                join   yho.yho_user u
                                on     u.user_id = aa.author_id
                                and    u.partner_id::numeric = 1
                                left join yho.yho_asset_entity_map aem
                                on     aem.asset_type_id = al.asset_type_id
                                and    aem.asset_id = al.asset_id
                                and    aem.entity_role_map_id in (select langentityid
                                								  from   unnest($1) U(langentityid))
                          		where ((al.published_date >= '''||v_sysdate||'''::timestamp - ('''||v_time||' hours'')::interval
                                		and al.published_date <= '''||v_sysdate||''')
                                       or (al.updated_date >= '''||v_sysdate||'''::timestamp - ('''||v_time||' hours'')::interval
                                       	   and al.updated_date <= '''||v_sysdate||'''))
						  		and    al.asset_type_id in(1,2,4,5)
                          		and    al.is_published = 1'
                          		||v_entity_query||')tab
                          where srno between '||v_fromrownumber||' and '||v_torownumber||')'
	into    v_asset_list_id_array
    using   v_lang_ent_array, p_entityrole_mapid;
    
    open p_rss_cur for
    select *
    from
    (
        select a.title_alias, a.title, a.full_text, a.published_date, al.short_desc, al.image_path, al.image_file_name, al.asset_type_id,
        	   al.asset_id article_id, yho.yho_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   yho.yho_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id,
        	   yho.yho_get_user_display_name(aa.author_id) as user_name, yho.yho_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   yho.yho_asset_list al
        join   yho.yho_article a
        on     a.article_id = al.asset_id
        join   yho.yho_author_action aa
        on     aa.asset_id = al.asset_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join yho.yho_asset_entity_map aem
        on     aem.asset_type_id = al.asset_type_id
        and    aem.asset_id = al.asset_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) U(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) U(assetlistid))
        and    al.asset_type_id = 1
        union
        select a.title_alias, a.title, a.album_desc, a.published_date, al.short_desc, al.image_path, al.image_file_name, al.asset_type_id, al.asset_id,
			   yho.yho_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   yho.yho_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id,
        	   yho.yho_get_user_display_name(aa.author_id) as user_name, yho.yho_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   yho.yho_asset_list al
        join   yho.yho_album a
        on     a.album_id = al.asset_id
        join   yho.yho_author_action aa
        on     aa.asset_id = a.album_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join yho.yho_asset_entity_map aem
        on     aem.asset_id = al.asset_id
        and    aem.asset_type_id = al.asset_type_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) U(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) U(assetlistid))
        and    al.asset_type_id = 2
        union
        select v.title_alias, v.title, v.video_desc, v.published_date, al.short_desc, al.image_path, al.image_file_name, al.asset_type_id, al.asset_id,
        	   yho.yho_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   yho.yho_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id,
        	   yho.yho_get_user_display_name(aa.author_id) user_name, yho.yho_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   yho.yho_asset_list al
        join   yho.yho_video v
        on     v.video_id = al.asset_id
        join   yho.yho_author_action aa
        on     aa.asset_id = v.video_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join yho.yho_asset_entity_map aem
        on     aem.asset_type_id = al.asset_type_id
        and    aem.asset_id = al.asset_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) U(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) U(assetlistid))
        and    al.asset_type_id = 4
        union
        select t.title_alias, t.channel_name, t.channel_desc, t.published_date, al.short_desc, al.image_path, al.image_file_name, al.asset_type_id, al.asset_id,
        	   yho.yho_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   yho.yho_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id,
        	   yho.yho_get_user_display_name(aa.author_id) user_name, yho.yho_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   yho.yho_asset_list al
        join   yho.yho_topic t
        on     t.topic_id = al.asset_id
        join   yho.yho_author_action aa
        on     aa.asset_id = t.topic_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join yho.yho_asset_entity_map aem
        on     aem.asset_type_id = al.asset_type_id
        and    aem.asset_id = al.asset_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) U(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) U(assetlistid))
        and    al.asset_type_id = 5
    )rss
    order by published_date desc;
    
    open p_image_cur for
    select aam.album_id, aam.is_cover, i.*
    from   yho.yho_album_asset_map aam
    join   yho.yho_image i
    on     i.image_id = aam.asset_id
    and    aam.asset_type_id = 3
    join   yho.yho_asset_list al
    on     al.asset_id = aam.album_id
    and    al.asset_type_id = 2
    where  al.asset_list_id in(select assetlistid
                               from   unnest(v_asset_list_id_array) U(assetlistid))
    and    aam.is_published = 1
    and    aam.is_deleted = 0
    order by 1;
    
    open p_article_img_cur for
    select aam.article_id, aam.is_cover, i.*
    from   yho.yho_article_asset_map aam
    join   yho.yho_image i
    on     i.image_id = aam.asset_id
    and    aam.asset_type_id = 3
	join   yho.yho_asset_list al
    on     al.asset_id = aam.article_id
    and    al.asset_type_id = 1
    where  al.asset_list_id in(select assetlistid
                               from   unnest(v_asset_list_id_array) U(assetlistid))
    and    aam.is_published = 1
    and    aam.is_deleted = 0
    order by 1;
    
    open p_article_video_cur for
    select aam.article_id, v.*
    from   yho.yho_article_asset_map aam
    join   yho.yho_video v
    on     v.video_id = aam.asset_id
    and    aam.asset_type_id = 4
	join   yho.yho_asset_list al
    on     al.asset_id = aam.article_id
    and    al.asset_type_id = 1
    where  al.asset_list_id in(select assetlistid
                               from   unnest(v_asset_list_id_array) U(assetlistid))
    and    aam.is_published = 1
    and    aam.is_deleted = 0
    order by 1;

end;

$_$;


--
