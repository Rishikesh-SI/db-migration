-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_show_get_rss_data(numeric, numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: swa_show_get_rss_data(numeric, numeric, numeric, numeric[], refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: swa; Owner: -
--

CREATE FUNCTION swa.swa_show_get_rss_data(p_size numeric, p_time numeric, p_asset_type_id numeric, p_entityrole_mapid numeric[], p_rss_cur refcursor, p_image_cur refcursor, p_article_img_cur refcursor, p_article_video_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$

declare
	
     v_sysdate timestamp;
     v_ent_count numeric ;
     v_video_type_id numeric := 4;
     v_article_type_id numeric := 1;
     v_album_type_id numeric := 2;
     v_array numeric[];
	 
	 v_rn_filter text :=' ' ;
	 
	 v_time_filt text :=' ';
	 
	 v_limit_filter  text :=' ';
     
begin
	
     v_sysdate := current_timestamp at time zone 'utc';
     
	 if p_size is not null then 
	 v_rn_filter  := 'where rn <=$7';
	 v_time_filt:='and sal.published_date <= $3';
	 p_time :=null;
	 v_limit_filter:='where rn <=1000 order by rn ';
	 else 
	 v_time_filt :='and sal.published_date >=$3 - ( $4 ||'' hours'')::interval and sal.published_date <= $3';
	 end if ;
	 
     select array(SELECT ERM.ENTITY_ROLE_MAP_ID
                  FROM   swa.swa_ENTITY_ROLE_MAP ERM
                  JOIN   swa.swa_ENTITY_MASTER EM
                  on     EM.entity_master_id = erm.entity_master_id
                  join   swa.swa_ENTITY_CATEGORY ec
                  on     ec.entity_role_id = ERM.ENTITY_ROLE_ID
                  where  ERM.ENTITY_ROLE_ID in (SELECT ENTITY_ROLE_ID
                                                FROM   swa.swa_ENTITY_CATEGORY c1
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
     
    if v_ent_count > 0 then
     	
          open p_rss_cur for
         execute 'select *
          from
          ( select * from (
              select sa.title_alias, sa.title, 
					sa.full_text, sal.published_date, sal.short_desc, sal.image_path,
					sal.image_file_name, 
					$1 as asset_type_id,
              		 sa.article_id, swa.swa_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 swa.swa_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, 
					 aa.author_id user_id, 
					 swa.swa_get_user_display_name(aa.author_id) as user_name,
              		 swa.swa_get_entity_name(aem.entity_role_map_id) as l_entity_name, 
					 sal.updated_date,
					row_number() over (order by sal.published_date desc) rn
              from   swa.swa_article sa
              join   swa.swa_asset_list sal
              on     sal.asset_id = sa.article_id
              and    sal.asset_type_id = $1
              join   swa.swa_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   swa.swa_author_action aa
              on     aa.asset_id = sa.article_id
              and    aa.asset_type_id = sal.asset_type_id
              and    aa.action_id = 4
              left join swa.swa_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest($6) U(entity_id))
              where      $1 = coalesce($5,$1)
              and    sa.is_published = 1 
			 ' ||v_time_filt||'
              and    exists(select 1
                            from   swa.swa_asset_entity_map aem
                            where  aem.asset_id = sa.article_id
                            and    aem.asset_type_id = $1
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest($2) U(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = '||v_ent_count||')
          																							
          )a
		  '||v_rn_filter||'
       
		
		
		union 
		
		select * from (
		select sa.title_alias, sa.title, sa.album_desc, sal.published_date, sal.short_desc, sal.image_path,
		   sal.image_file_name, $8 as asset_type_id,
              		 sa.album_id, swa.swa_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 swa.swa_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, swa.swa_get_user_display_name(aa.author_id) as user_name,
              		 swa.swa_get_entity_name(aem.entity_role_map_id) as l_entity_name, sal.updated_date,
					row_number() over (order by sal.published_date desc) rn
              from   swa.swa_album sa
              join   swa.swa_asset_list sal
              on     sal.asset_id = sa.album_id
              and    sal.asset_type_id = $8
              join   swa.swa_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   swa.swa_author_action aa
              on     aa.asset_id = sa.album_id
              and    aa.asset_type_id = $8
              and    aa.action_id = 4
              left join swa.swa_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest($6) U(entity_id))
              where    
               $8 = coalesce($5,$8)
              and    sa.is_published = 1
			   ' ||v_time_filt||'
              and    exists(select 1
                            from   swa.swa_asset_entity_map aem
                            where  aem.asset_id = sa.album_id
                            and aem.asset_type_id = $8
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest($2) U(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) ='|| v_ent_count||')
							)
							b
							'||v_rn_filter||'
							
           union 
		   
		    select * from (
		     select sv.title_alias, 
                     sv.title, sv.video_desc,
                     sal.published_date, sal.short_desc,
                     sal.image_path, sal.image_file_name, 
                     $9 as asset_type_id,
              		 sv.video_id, swa.swa_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 swa.swa_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, 
					  aa.author_id user_id,
                     swa.swa_get_user_display_name(aa.author_id) user_name,
              		 swa.swa_get_entity_name(aem.entity_role_map_id) as l_entity_name, sal.updated_date,
					 row_number() over (order by sal.published_date desc) rn
              from   swa.swa_video sv
              join   swa.swa_asset_list sal
              on     sal.asset_id = sv.video_id
              and    sal.asset_type_id = $9
              join   swa.swa_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   swa.swa_author_action aa
              on     aa.asset_id = sv.video_id
              and    aa.asset_type_id = $9
              and    aa.action_id = 4
              left join swa.swa_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest($2) U(entity_id))
              where  
			   sal.published_date <= $3
              and    $9 = coalesce($5,$9)
              and    sv.is_published = 1
			  ' ||v_time_filt||'
              and    exists(select 1
                            from   swa.swa_asset_entity_map aem
                            where  aem.asset_id = sv.video_id
                            and    aem.asset_type_id = $9
                            and    aem.entity_role_map_id in (select entity_role_mapid
                                                              from unnest($2) U(entity_role_mapid))
                            group by aem.asset_id, aem.asset_type_id
                            having count(1) = '|| v_ent_count||')
		
		   )c '||v_rn_filter||'
		
		  
           )rss  
		   order by asset_type_id,rn
		'
		
		  using v_article_type_id,p_entityrole_mapid ,v_sysdate, p_time,
		        p_asset_type_id,v_array,p_size,v_album_type_id ,v_video_type_id,v_time_filt;
          
          open p_image_cur for 
         execute ' select aam.album_id, aam.is_cover, aam.asset_order, i.*
          from   swa.swa_album_asset_map aam
          join   swa.swa_image i
          on     i.image_id = aam.asset_id
          where  album_id in ( select asset_id from (select sal.asset_id,asset_title,
                              row_number() over (order by sal.published_date desc) rn
                              from swa.swa_asset_list sal
                              where sal.asset_type_id = $1
                              ' ||v_time_filt|| '
							  ) a
							  '||v_limit_filter||'
							  )
		  and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   swa.swa_asset_entity_map aem
                        where  aem.asset_id = aam.album_id
                        and    aem.asset_type_id = $1
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest($2) U(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = '|| v_ent_count||')
		order by 1,2 desc,3' 
          
		using v_album_type_id,p_entityrole_mapid,v_sysdate,p_time ;
		
          open p_article_img_cur for
          execute 'select aam.article_id, aam.is_cover, i.*
          from   swa.swa_article_asset_map aam
          join   swa.swa_image i
          on     i.image_id = aam.asset_id
		where  article_id in( select asset_id from (select sal.asset_id,asset_title,
                              row_number() over (order by sal.published_date desc) rn
                              from swa.swa_asset_list sal
                              where sal.asset_type_id = $1
                              ' ||v_time_filt|| '
							  ) a
							  '||v_limit_filter||'
							)
	      and    aam.asset_type_id = 3
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   swa.swa_asset_entity_map aem
                        where  aem.asset_id = aam.article_id
                        and    aem.asset_type_id = $1
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest($2) U(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) =  '|| v_ent_count||')
						'
          using v_article_type_id,p_entityrole_mapid,v_sysdate,p_time ;
		
          open p_article_video_cur for
         execute 'select aam.article_id, v.*
          from   swa.swa_article_asset_map aam
          join   swa.swa_video v
          on     v.video_id = aam.asset_id
		where  article_id in(select asset_id from (select sal.asset_id,asset_title,
                              row_number() over (order by sal.published_date desc) rn
                              from swa.swa_asset_list sal
                              where sal.asset_type_id = $1
                              ' ||v_time_filt|| '
							  ) a
							  '||v_limit_filter||')
		and    aam.asset_type_id = 4
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          and    exists(select 1
                        from   swa.swa_asset_entity_map aem
                        where  aem.asset_id = aam.article_id
                        and    aem.asset_type_id = $1
                        and    aem.entity_role_map_id in (select entity_role_mapid
                                                          from unnest($2) U(entity_role_mapid))
                        group by aem.asset_id, aem.asset_type_id
                        having count(1) = '|| v_ent_count||')'
						
						
	using v_article_type_id,p_entityrole_mapid,v_sysdate,p_time ;
          
   
  else
    	
     	open  p_rss_cur for
        	 execute ' select *
          from
          ( select * from (
              select sa.title_alias, sa.title, 
					sa.full_text, sal.published_date, sal.short_desc, sal.image_path,
					sal.image_file_name, 
					$1 as asset_type_id,
              		 sa.article_id, swa.swa_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 swa.swa_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, 
					 aa.author_id user_id, 
					 swa.swa_get_user_display_name(aa.author_id) as user_name,
              		 swa.swa_get_entity_name(aem.entity_role_map_id) as l_entity_name, 
					 sal.updated_date,
					row_number() over (order by sal.published_date desc) rn
              from   swa.swa_article sa
              join   swa.swa_asset_list sal
              on     sal.asset_id = sa.article_id
              and    sal.asset_type_id = $1
              join   swa.swa_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   swa.swa_author_action aa
              on     aa.asset_id = sa.article_id
              and    aa.asset_type_id = sal.asset_type_id
              and    aa.action_id = 4
              left join swa.swa_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest($6) U(entity_id))
              where      $1 = coalesce($5,$1)
              and    sa.is_published = 1  ' ||v_time_filt||'
             
          																							
          )a
		  '||v_rn_filter||'
       
		
		
		union 
		
		select * from (
		select sa.title_alias, sa.title, sa.album_desc, sal.published_date, sal.short_desc, sal.image_path,
		   sal.image_file_name, $8 as asset_type_id,
              		 sa.album_id, swa.swa_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 swa.swa_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, aa.author_id user_id, swa.swa_get_user_display_name(aa.author_id) as user_name,
              		 swa.swa_get_entity_name(aem.entity_role_map_id) as l_entity_name, sal.updated_date,
					row_number() over (order by sal.published_date desc) rn
              from   swa.swa_album sa
              join   swa.swa_asset_list sal
              on     sal.asset_id = sa.album_id
              and    sal.asset_type_id = $8
              join   swa.swa_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   swa.swa_author_action aa
              on     aa.asset_id = sa.album_id
              and    aa.asset_type_id = $8
              and    aa.action_id = 4
              left join swa.swa_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest($6) U(entity_id))
              where    $8 = coalesce($5,$8)
              and    sa.is_published = 1  ' ||v_time_filt||'
              
							)
							b
							'||v_rn_filter||'
							
           union 
		   
		    select * from (
		     select sv.title_alias, 
                     sv.title, sv.video_desc,
                     sal.published_date, sal.short_desc,
                     sal.image_path, sal.image_file_name, 
                     $9 as asset_type_id,
              		 sv.video_id, swa.swa_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
              		 swa.swa_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name, 
					  aa.author_id user_id,
                     swa.swa_get_user_display_name(aa.author_id) user_name,
              		 swa.swa_get_entity_name(aem.entity_role_map_id) as l_entity_name, sal.updated_date,
					 row_number() over (order by sal.published_date desc) rn
              from   swa.swa_video sv
              join   swa.swa_asset_list sal
              on     sal.asset_id = sv.video_id
              and    sal.asset_type_id = $9
              join   swa.swa_entity_role_map erm
              on     erm.entity_role_map_id = sal.secondary_entity_role_map_id
              and    erm.priority > 0
              join   swa.swa_author_action aa
              on     aa.asset_id = sv.video_id
              and    aa.asset_type_id = $9
              and    aa.action_id = 4
              left join swa.swa_asset_entity_map aem
              on     aem.asset_type_id = sal.asset_type_id
              and    aem.asset_id = sal.asset_id
              and    aem.entity_role_map_id in (select entity_id
                                                from   unnest($2) U(entity_id))
              where     $9 = coalesce($5,$9)
              and    sv.is_published = 1  ' ||v_time_filt||'
              
		
		   )c '||v_rn_filter||'
		
		  
           )rss  
		   order by asset_type_id,rn
		'
		
		  using v_article_type_id,p_entityrole_mapid ,v_sysdate, p_time,
		        p_asset_type_id,v_array,p_size,v_album_type_id ,v_video_type_id;
          
		open p_image_cur for 
           execute ' select aam.album_id, aam.is_cover, aam.asset_order, i.*
          from   swa.swa_album_asset_map aam
          join   swa.swa_image i
          on     i.image_id = aam.asset_id
          where  album_id in ( select asset_id from (select sal.asset_id,asset_title,
                              row_number() over (order by sal.published_date desc) rn
                              from swa.swa_asset_list sal
                              where sal.asset_type_id = $1
                              ' ||v_time_filt|| '
							  ) a
							  '||v_limit_filter||'
							  )
		  and    aam.is_published = 1
          and    aam.is_deleted = 0
          
		  order by 1,2 desc,3' 
          
		using v_album_type_id,p_entityrole_mapid,v_sysdate,p_time ;
          
		
		
          open p_article_img_cur for
          execute 'select aam.article_id, aam.is_cover, i.*
          from   swa.swa_article_asset_map aam
          join   swa.swa_image i
          on     i.image_id = aam.asset_id
		where  article_id in( select asset_id from (select sal.asset_id,asset_title,
                              row_number() over (order by sal.published_date desc) rn
                              from swa.swa_asset_list sal
                              where sal.asset_type_id = $1
                              ' ||v_time_filt|| '
							  ) a
							  '||v_limit_filter||'
							)
	      and    aam.asset_type_id = 3
          and    aam.is_published = 1
          and    aam.is_deleted = 0
          
						'
          using v_article_type_id,p_entityrole_mapid,v_sysdate,p_time ;
		
          
          open p_article_video_cur for
         execute 'select aam.article_id, v.*
          from   swa.swa_article_asset_map aam
          join   swa.swa_video v
          on     v.video_id = aam.asset_id
		where  article_id in(select asset_id from (select sal.asset_id,asset_title,
                              row_number() over (order by sal.published_date desc) rn
                              from swa.swa_asset_list sal
                              where sal.asset_type_id = $1
                              ' ||v_time_filt|| '
							  ) a
							  '||v_limit_filter||')
		and    aam.asset_type_id = 4
          and    aam.is_published = 1
          and    aam.is_deleted = 0
         '				
	using v_article_type_id,p_entityrole_mapid,v_sysdate,p_time ;
          
	end if;
  

end;

$_$;


--
