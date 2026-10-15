-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr_beta
-- Object: labadkr_show_get_rss_data(numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: labadkr_show_get_rss_data(numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: labadkr_beta; Owner: -
--

CREATE FUNCTION labadkr_beta.labadkr_show_get_rss_data(p_time numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_rss_cur refcursor, p_image_cur refcursor, p_article_img_cur refcursor, p_article_video_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$
 

declare
	
    v_time numeric;
    v_sysdate timestamp;
    v_ent_count numeric;
    v_entity_query text := ' ';
    v_lang_ent_array numeric[];
    v_asset_list_id_array numeric[];
    
begin
	
    if p_time = 48 then
    	v_time := 48;
    else
    	v_time := p_time;
    end if;
    
    v_sysdate := current_timestamp at time zone 'utc';
    
    select array(select erm.entity_role_map_id
                 from   labadkr.labadkr_entity_role_map erm
                 join   labadkr.labadkr_entity_master em
                 on     em.entity_master_id = erm.entity_master_id
                 join   labadkr.labadkr_entity_category ec
                 on     ec.entity_role_id = erm.entity_role_id
                 where  erm.entity_role_id in (select entity_role_id
                                               from   labadkr.labadkr_entity_category c1
                                               join   unnest(array['Language']) m(category_name)
                                               on     m.category_name = c1.category_name
                                               where  c1.is_active = 1
                                               and    c1.is_deleted = 0
                                               and    c1.is_published = 1
                                              )
                 and erm.is_active = 1
                )
	into v_lang_ent_array;
    
    select count(1)
    into   v_ent_count
    from   (select entityid
            from unnest(p_entityrole_mapid) u(entityid)) a;
	
    if v_ent_count > 0 then
    	
        v_entity_query := 'and exists(select 1
        							  from   labadkr.labadkr_asset_entity_map aem
                                      where  aem.asset_id = al.asset_id
                                      and    aem.asset_type_id = al.asset_type_id
                                      and    aem.entity_role_map_id in (select entity_role_mapid
                                      									from unnest($2) u(entity_role_mapid))
									  group by aem.asset_id, aem.asset_type_id
                                      having count(1) = '||v_ent_count||')';
        
    end if;
    
    execute 'select array(select al.asset_list_id
    					  from   labadkr.labadkr_asset_list al
                          join   labadkr.labadkr_entity_role_map erm
                          on     erm.entity_role_map_id = al.secondary_entity_role_map_id
                          and    erm.priority > 0
                          join   labadkr.labadkr_author_action aa
                          on     aa.asset_id = al.asset_id
                          and    aa.asset_type_id = al.asset_type_id
                          and    aa.action_id = 4
                          left join labadkr.labadkr_asset_entity_map aem
                          on     aem.asset_type_id = al.asset_type_id
                          and    aem.asset_id = al.asset_id
                          and    aem.entity_role_map_id in (select langentityid
                          									from   unnest($1) u(langentityid))
                          where 
                          ((al.published_date >= timestamp '''||v_sysdate||''' -
                                  ('''||v_time||' hours'')::interval
                          		   and al.published_date <= '''||v_sysdate||''')
                                  or 
                                  (al.updated_date >= timestamp '''||v_sysdate||''' - 
                                  ('''||v_time||' hours'')::interval
                                  	  and al.updated_date <= '''||v_sysdate||'''))
                                
                                
                
                                      
                                    
						  and    al.asset_type_id in(1,2,4,5)
                          and    al.is_published = 1'
                          ||v_entity_query||')'
	into    v_asset_list_id_array
    using   v_lang_ent_array, p_entityrole_mapid;
    
    open p_rss_cur for
    select *
    from
    (
        select a.title_alias, a.title,
        a.full_text, a.published_date, 
        al.short_desc, al.image_path, 
        al.image_file_name, al.asset_type_id,
        	   al.asset_id article_id, labadkr.labadkr_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   labadkr.labadkr_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, 
        aa.author_id user_id,
        	   labadkr.labadkr_get_user_display_name(aa.author_id) as user_name, 
        labadkr.labadkr_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   labadkr.labadkr_asset_list al
        join   labadkr.labadkr_article a
        on     a.article_id = al.asset_id
        join   labadkr.labadkr_author_action aa
        on     aa.asset_id = al.asset_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join labadkr.labadkr_asset_entity_map aem
        on     aem.asset_type_id = al.asset_type_id
        and    aem.asset_id = al.asset_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) u(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) u(assetlistid))
        and    al.asset_type_id = 1
        -- cahnges done in rakesh date :-13-12-2017
        and  (
                   (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate)
or     (al.updated_date >= v_sysdate - ( v_time || ' hours')::interval
		and    al.updated_date <= v_sysdate
       and (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate))
               
               )
          -- cahnges done in rakesh date :-13-12-2017
        union
        
        select a.title_alias, a.title, a.album_desc, a.published_date, al.short_desc, 
        al.image_path, al.image_file_name, al.asset_type_id, al.asset_id,
			   labadkr.labadkr_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   labadkr.labadkr_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name,
        aa.author_id user_id,
        	   labadkr.labadkr_get_user_display_name(aa.author_id) as user_name,
        labadkr.labadkr_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   labadkr.labadkr_asset_list al
        join   labadkr.labadkr_album a
        on     a.album_id = al.asset_id
        join   labadkr.labadkr_author_action aa
        on     aa.asset_id = a.album_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join labadkr.labadkr_asset_entity_map aem
        on     aem.asset_id = al.asset_id
        and    aem.asset_type_id = al.asset_type_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) u(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) u(assetlistid))
        and    al.asset_type_id = 2
         -- cahnges done in rakesh date :-13-12-2017
          and  (
                   (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate)
    or     (al.updated_date >= v_sysdate - ( v_time || ' hours')::interval
		and    al.updated_date <= v_sysdate
       and (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate))
               
               )
          -- cahnges done in rakesh date :-13-12-2017
        union
        select v.title_alias, v.title, v.video_desc, v.published_date, al.short_desc, al.image_path, al.image_file_name, al.asset_type_id, al.asset_id,
        	   labadkr.labadkr_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   labadkr.labadkr_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id,
        	   labadkr.labadkr_get_user_display_name(aa.author_id) user_name, labadkr.labadkr_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   labadkr.labadkr_asset_list al
        join   labadkr.labadkr_video v
        on     v.video_id = al.asset_id
        join   labadkr.labadkr_author_action aa
        on     aa.asset_id = v.video_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join labadkr.labadkr_asset_entity_map aem
        on     aem.asset_type_id = al.asset_type_id
        and    aem.asset_id = al.asset_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) u(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) u(assetlistid))
        and    al.asset_type_id = 4
         -- cahnges done in rakesh date :-13-12-2017
          and  (
                   (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate)
    or     (al.updated_date >= v_sysdate - ( v_time || ' hours')::interval
		and    al.updated_date <= v_sysdate
       and (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate))
               
               )
          -- cahnges done in rakesh date :-13-12-2017
        union
        select t.title_alias, 
        t.channel_name, t.channel_desc, 
        t.published_date, al.short_desc, 
        al.image_path, al.image_file_name, al.asset_type_id, 
        al.asset_id,
        	   labadkr.labadkr_get_entity_name(al.primary_entity_role_map_id) as p_entity_name,
        	   labadkr.labadkr_get_entity_name(al.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id,
        	   labadkr.labadkr_get_user_display_name(aa.author_id) user_name, labadkr.labadkr_get_entity_name(aem.entity_role_map_id) as l_entity_name,
        	   al.updated_date
        from   labadkr.labadkr_asset_list al
        join   labadkr.labadkr_topic t
        on     t.topic_id = al.asset_id
        join   labadkr.labadkr_author_action aa
        on     aa.asset_id = t.topic_id
        and    aa.asset_type_id = al.asset_type_id
        and    aa.action_id = 4
        left join labadkr.labadkr_asset_entity_map aem
        on     aem.asset_type_id = al.asset_type_id
        and    aem.asset_id = al.asset_id
        and    aem.entity_role_map_id in (select langentityid
                                          from   unnest(v_lang_ent_array) u(langentityid))
        where  al.asset_list_id in(select assetlistid
                                   from   unnest(v_asset_list_id_array) u(assetlistid))
        and    al.asset_type_id = 5
         -- cahnges done in rakesh date :-13-12-2017
          and  (
                   (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate)
    or     (al.updated_date >= v_sysdate - ( v_time || ' hours')::interval
		and    al.updated_date <= v_sysdate
       and (al.published_date >= v_sysdate - (v_time||' hours')::interval
                 and    al.published_date <= v_sysdate))
               
               )
          -- cahnges done in rakesh date :-13-12-2017
    )rss
    order by published_date desc;
    
    open p_image_cur for
    select aam.album_id, aam.is_cover, i.*
    from   labadkr.labadkr_album_asset_map aam
    join   labadkr.labadkr_image i
    on     i.image_id = aam.asset_id
    and    aam.asset_type_id = 3
    join   labadkr.labadkr_asset_list al
    on     al.asset_id = aam.album_id
    and    al.asset_type_id = 2
    where  al.asset_list_id in(select assetlistid
                               from   unnest(v_asset_list_id_array) u(assetlistid))
    and    aam.is_published = 1
    and    aam.is_deleted = 0
    order by 1;
    
    open p_article_img_cur for
    select aam.article_id, aam.is_cover, i.*
    from   labadkr.labadkr_article_asset_map aam
    join   labadkr.labadkr_image i
    on     i.image_id = aam.asset_id
    and    aam.asset_type_id = 3
	join   labadkr.labadkr_asset_list al
    on     al.asset_id = aam.article_id
    and    al.asset_type_id = 1
    where  al.asset_list_id in(select assetlistid
                               from   unnest(v_asset_list_id_array) u(assetlistid))
    and    aam.is_published = 1
    and    aam.is_deleted = 0
    order by 1;
    
    open p_article_video_cur for
    select aam.article_id, v.*
    from   labadkr.labadkr_article_asset_map aam
    join   labadkr.labadkr_video v
    on     v.video_id = aam.asset_id
    and    aam.asset_type_id = 4
	join   labadkr.labadkr_asset_list al
    on     al.asset_id = aam.article_id
    and    al.asset_type_id = 1
    where  al.asset_list_id in(select assetlistid
                               from   unnest(v_asset_list_id_array) u(assetlistid))
    and    aam.is_published = 1
    and    aam.is_deleted = 0
    order by 1;

end;

 
$_$;


--
