-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_show_get_site_map_data(numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: abp_show_get_site_map_data(numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_show_get_site_map_data(p_time numeric, p_asset_type_id numeric, p_language_id numeric, p_rss_cur refcursor) RETURNS SETOF refcursor
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
begin

	   v_sysdate:= current_timestamp at time zone 'utc';
   
   if p_language_id is not null then
   		v_lang_filter_query := ' and erm.entity_role_map_id in($1) ';
   end if;
   
   execute 'select array(  
  SELECT ERM.ENTITY_ROLE_MAP_ID              
                    FROM abp.abp_ENTITY_ROLE_MAP ERM
                    INNER JOIN  abp.abp_ENTITY_MASTER EM on EM.entity_master_id=erm.entity_master_id 
                    inner join abp.abp_ENTITY_CATEGORY ec on ec.entity_role_id=ERM.ENTITY_ROLE_ID
                    where ec.category_name = '''||'Language'||''''
                    ||v_lang_filter_query||
                    'and ERM.IS_active=1)'
                     into v_array
                     using p_language_id;
   
   /*select array(  
  SELECT ERM.ENTITY_ROLE_MAP_ID              
                    FROM abp.abp_ENTITY_ROLE_MAP ERM
                    INNER JOIN  abp.abp_ENTITY_MASTER EM on EM.entity_master_id=erm.entity_master_id 
                    inner join abp.abp_ENTITY_CATEGORY ec on ec.entity_role_id=ERM.ENTITY_ROLE_ID
                    where ERM.ENTITY_ROLE_ID in (SELECT ENTITY_ROLE_ID FROM abp.abp_ENTITY_CATEGORY c1
                                                  INNER JOIN  UNNEST(Array['Language']) M(CATEGORY_NAME)
                                                   ON M.CATEGORY_NAME=C1.CATEGORY_NAME
                                                  WHERE C1.IS_active=1
                                                  and c1.is_deleted=0
                                                  and c1.is_published=1
                                                  )
                    and ERM.IS_active=1)
                     into v_array;*/

  open  p_rss_cur for
  select *
  from(select sal.asset_title as title, sal.title_alias, sa.published_date, sal.image_path, sal.image_file_name, sa.article_id as asset_id,
       abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
       abp.abp_get_entity_name(saem1.entity_role_map_id) as l_entity_name, em.canonical_url lang_url
       from abp.abp_article sa
       inner join abp.abp_asset_list sal
       on sal.asset_id = sa.article_id
       and (sal.asset_type_id = v_article_type_id or sal.asset_type_id = 5)
       inner join abp.abp_asset_entity_map saem
       on saem.asset_id = sa.article_id
       and (saem.asset_type_id = v_article_type_id or saem.asset_type_id = 5)
       inner join abp.abp_asset_entity_map saem1
       on saem1.asset_id = sa.article_id
       and (saem1.asset_type_id = v_article_type_id or saem1.asset_type_id = 5)
       and saem1.entity_role_map_id in(select entity_id
                                       from   unnest(v_array) U(entity_id))
       inner join abp.abp_entity_role_map erm on (erm.entity_role_map_id = saem1.entity_role_map_id )
       inner join abp.abp_entity_master em on (erm.entity_master_id = em.entity_master_id)
       where sal.published_date >= v_sysdate - (p_time||' hours')::interval
       -- and sal.published_date <= v_sysdate
       and sa.is_published=1
       and (v_article_type_id = coalesce(p_asset_type_id,v_article_type_id) or v_article_type_id = 5)
       and saem.entity_role_map_id in (select entity_id
                                       from   unnest(v_array) U(entity_id))
       union all
       select sal.asset_title as title, sal.title_alias, sa.published_date, sal.image_path, sal.image_file_name, sa.album_id as asset_id,
       abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
       abp.abp_get_entity_name(saem1.entity_role_map_id) as l_entity_name, em.canonical_url lang_url
       from  abp.abp_album sa
       inner join abp.abp_asset_list sal
       on sal.asset_id = sa.album_id
       and sal.asset_type_id = v_album_type_id
       inner join abp.abp_asset_entity_map saem
       on saem.asset_id = sa.album_id
       and saem.asset_type_id = v_album_type_id
       inner join abp.abp_asset_entity_map saem1
       on saem1.asset_id = sa.album_id
       and saem1.asset_type_id = v_album_type_id
       and saem1.entity_role_map_id in(select entity_id
                                       from   unnest(v_array) U(entity_id))
       inner join abp.abp_entity_role_map erm on (erm.entity_role_map_id = saem1.entity_role_map_id )
       inner join abp.abp_entity_master em on (erm.entity_master_id = em.entity_master_id)
       where --  sal.published_date >= v_sysdate - ('48 hours')::interval
       -- and sal.published_date <= v_sysdate
       -- and 
       v_album_type_id = coalesce(p_asset_type_id,v_album_type_id)
       and sa.is_published=1
       and saem.entity_role_map_id in (select entity_id
                                       from   unnest(v_array) U(entity_id))
       union all
       select sal.asset_title as title, sal.title_alias, sv.published_date, sal.image_path, sal.image_file_name, sv.video_id as asset_id,
       abp.abp_get_entity_name(sal.primary_entity_role_map_id) as p_entity_name, abp.abp_get_entity_name(sal.secondary_entity_role_map_id) as s_entity_name,
       abp.abp_get_entity_name(saem1.entity_role_map_id) as l_entity_name , em.canonical_url lang_url
       from  abp.abp_video sv
       inner join abp.abp_asset_list sal
       on sal.asset_id = sv.video_id
       and sal.asset_type_id = v_video_type_id
       inner join abp.abp_asset_entity_map saem
       on saem.asset_id = sv.video_id
       and saem.asset_type_id = v_video_type_id
       inner join abp.abp_asset_entity_map saem1
       on saem1.asset_id = sv.video_id
       and saem1.asset_type_id = v_video_type_id
       and saem1.entity_role_map_id in(select entity_id
                                       from   unnest(v_array) U(entity_id))
       inner join abp.abp_entity_role_map erm on (erm.entity_role_map_id = saem1.entity_role_map_id )
       inner join abp.abp_entity_master em on (erm.entity_master_id = em.entity_master_id)
       where  
       --  sal.published_date >= v_sysdate - ('48 hours')::interval
       --  and sal.published_date <= v_sysdate
       -- and 
       v_video_type_id = coalesce(p_asset_type_id,v_video_type_id)   
       and sv.is_published=1
       and saem.entity_role_map_id in (select entity_id
                                       from   unnest(v_array) U(entity_id))
      )rss
      order by published_date desc;

end;

 

$_$;


--
