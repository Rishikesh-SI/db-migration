-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: gfg_show_get_site_map_data(numeric, numeric, numeric, numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gfg_show_get_site_map_data(numeric, numeric, numeric, numeric, refcursor, refcursor); Type: FUNCTION; Schema: gfg; Owner: -
--

CREATE FUNCTION gfg.gfg_show_get_site_map_data(p_asset_type_id numeric, p_language_id numeric, p_page_number numeric, p_item_number numeric, p_count refcursor, p_rss_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $_$ 

declare 
v_sysdate timestamp;
v_ent_count numeric ;
v_video_type_id numeric :=4;
v_article_type_id numeric :=1;
v_album_type_id numeric :=2;
v_lang_filter_query varchar(100) := ' ';
v_array numeric[];
v_fromrownumber numeric;
v_torownumber numeric;
v_count numeric;
begin
	
    
    
	   v_sysdate:= current_timestamp at time zone 'utc';
   
   if p_language_id is not null then
   		v_lang_filter_query := ' and erm.entity_role_map_id in($1) ';
   end if;
   
   execute 'select array(  
  select erm.entity_role_map_id              
                    from gfg.gfg_entity_role_map erm
                    inner join  gfg.gfg_entity_master em on em.entity_master_id=erm.entity_master_id 
                    inner join gfg.gfg_entity_category ec on ec.entity_role_id=erm.entity_role_id
                    where erm.entity_role_id = 60'
                    ||v_lang_filter_query||
                    'and erm.is_active=1)'
                     into v_array
                     using p_language_id;
   
   /*select array(  
  select erm.entity_role_map_id              
                    from gfg.gfg_entity_role_map erm
                    inner join  gfg.gfg_entity_master em on em.entity_master_id=erm.entity_master_id 
                    inner join gfg.gfg_entity_category ec on ec.entity_role_id=erm.entity_role_id
                    where erm.entity_role_id in (select entity_role_id from gfg.gfg_entity_category c1
                                                  inner join  unnest(array['language']) m(category_name)
                                                   on m.category_name=c1.category_name
                                                  where c1.is_active=1
                                                  and c1.is_deleted=0
                                                  and c1.is_published=1
                                                  )
                    and erm.is_active=1)
                     into v_array;*/
	
    select count(1)
    into v_count
    from gfg.gfg_asset_list al
    join gfg.gfg_asset_entity_map aem
    on aem.asset_id = al.asset_id
    and aem.asset_type_id = al.asset_type_id
    where al.published_date <= v_sysdate
    and al.is_published = 1
    and al.asset_type_id = coalesce(p_asset_type_id,al.asset_type_id)
    and aem.entity_role_map_id in (select entity_id
                                   from   unnest(v_array) u(entity_id));
	
    if p_item_number is not null then
    	v_fromrownumber := (p_page_number * p_item_number - (p_item_number - 1));
  		v_torownumber   := (p_page_number * p_item_number);
	else
    	v_fromrownumber := 1;
  		v_torownumber   := v_count;
    end if;
	
    open p_count for select v_count;
    
  open  p_rss_cur for
  select *
  from
  (
      select row_number()over (order by published_date desc) as slno, *
      from(
          select sal.asset_title as title, sal.title_alias, sa.published_date, sal.image_path, sal.image_file_name, sa.article_id as asset_id,
          		 gfg.gfg_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
          		 gfg.gfg_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
          		 gfg.gfg_get_entity_name(saem.entity_role_map_id) as l_entity_name, (sd.meta_info->'keywords') as meta_info
          from gfg.gfg_article sa
          join gfg.gfg_asset_list sal
          on sal.asset_id = sa.article_id
          and sal.asset_type_id = v_article_type_id
          join gfg.gfg_asset_entity_map saem
          on saem.asset_id = sa.article_id
          and saem.asset_type_id = v_article_type_id
          and saem.entity_role_map_id in (select entity_id
                                          from   unnest(v_array) u(entity_id))
          /*join gfg.gfg_asset_entity_map saem1
          on saem1.asset_id = sa.article_id
          and saem1.asset_type_id = v_article_type_id
          and saem1.entity_role_map_id in(select entity_id
                                          from   unnest(v_array) u(entity_id))*/
          left join gfg.gfg_seo_data sd
          on sa.article_id = sd.asset_id
          and sd.asset_type_id = v_article_type_id
          where /*sal.published_date >= v_sysdate - ('48 hours')::interval
          and */sal.published_date <= v_sysdate
          and sa.is_published = 1
          and v_article_type_id = coalesce(p_asset_type_id,v_article_type_id)
          union all
          select sal.asset_title as title, sal.title_alias, sa.published_date, sal.image_path, sal.image_file_name, sa.album_id as asset_id,
          		 gfg.gfg_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
          		 gfg.gfg_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
          		 gfg.gfg_get_entity_name(saem.entity_role_map_id) as l_entity_name, (sd.meta_info->'keywords') as meta_info
          from  gfg.gfg_album sa
          join gfg.gfg_asset_list sal
          on sal.asset_id = sa.album_id
          and sal.asset_type_id = v_album_type_id
          join gfg.gfg_asset_entity_map saem
          on saem.asset_id = sa.album_id
          and saem.asset_type_id = v_album_type_id
          and saem.entity_role_map_id in (select entity_id
                                          from   unnest(v_array) u(entity_id))
          /*join gfg.gfg_asset_entity_map saem1
          on saem1.asset_id = sa.album_id
          and saem1.asset_type_id = v_album_type_id
          and saem1.entity_role_map_id in(select entity_id
                                          from   unnest(v_array) u(entity_id))*/
          left join gfg.gfg_seo_data sd
          on sa.album_id = sd.asset_id
          and sd.asset_type_id = v_album_type_id
          where /*sal.published_date >= v_sysdate - ('48 hours')::interval
          and */sal.published_date <= v_sysdate
          and v_album_type_id = coalesce(p_asset_type_id,v_album_type_id)
          and sa.is_published = 1
          union all
          select sal.asset_title as title, sal.title_alias, sv.published_date, sal.image_path, sal.image_file_name, sv.video_id as asset_id,
          		 gfg.gfg_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name,
          		 gfg.gfg_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
          		 gfg.gfg_get_entity_name(saem.entity_role_map_id) as l_entity_name, (sd.meta_info->'keywords') as meta_info
          from  gfg.gfg_video sv
          join gfg.gfg_asset_list sal
          on sal.asset_id = sv.video_id
          and sal.asset_type_id = v_video_type_id
          join gfg.gfg_asset_entity_map saem
          on saem.asset_id = sv.video_id
          and saem.asset_type_id = v_video_type_id
          and saem.entity_role_map_id in (select entity_id
                                          from   unnest(v_array) u(entity_id))
          /*join gfg.gfg_asset_entity_map saem1
          on saem1.asset_id = sv.video_id
          and saem1.asset_type_id = v_video_type_id
          and saem1.entity_role_map_id in(select entity_id
                                          from   unnest(v_array) u(entity_id))*/
          left join gfg.gfg_seo_data sd
          on sv.video_id = sd.asset_id
          and sd.asset_type_id = v_video_type_id
          where /*sal.published_date >= v_sysdate - ('48 hours')::interval
          and */sal.published_date <= v_sysdate
          and v_video_type_id = coalesce(p_asset_type_id,v_video_type_id)
          and sv.is_published = 1
      )rss
  ) tab
  where slno between v_fromrownumber and v_torownumber;
  
end;

 $_$;


--
