-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_get_rating_week_r(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: abp_get_rating_week_r(numeric, numeric, numeric); Type: FUNCTION; Schema: abpp; Owner: -
--

CREATE FUNCTION abpp.abp_get_rating_week_r(p_rating_year numeric, p_week_of_year numeric, p_language_id numeric, OUT p_ratingjson jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
	 v_rating_id numeric;
     v_datajsonarr jsonb[];
     v_datajson jsonb;
     
     v_playerdataarray jsonb[];
     v_playerdatajson jsonb;
     
     v_json1 varchar(1000000) := '{"data":[';
     v_week_json jsonb;
    
    v_asset_type_id numeric  :=7;
    v_end_date timestamp;
    v_data_count numeric;
     
begin
	
 if (p_rating_year is  null or p_week_of_year is  null)
  then 
       select max(end_date) into v_end_date from abp.abp_rating_week
       where language_id = p_language_id
       and is_published = 1;
    
        select rating_week_id into  v_rating_id
        from abp.abp_rating_week 
        where v_end_date between start_date and end_date
        and language_id = p_language_id;
  
  else 
     select rating_week_id into  v_rating_id
     from abp.abp_rating_week
     where rating_year = p_rating_year
     and week_of_year = p_week_of_year
     and language_id = p_language_id;
end if;

        
 /*select array(
     select row_to_json(row) jsonrow
     from
     (select 
           rating_year,
           week_of_year,
           show_in_web,
           show_in_mobile,
           show_in_app,
           is_published,
           is_trashed,
           updated_by,
           published_date,
           (
           select array_to_json(array_agg(a))
from(
select 
distinct 
rating_week_id,
start_date,
end_date,
rating_year,
week_of_year,
show_in_web,
show_in_mobile,
show_in_app,
week_number
from abp.abp_rating_week
    where language_id = p_language_id
)A ) as weeks,
(select 
array_to_json(array_agg(a))
from
(
select  
abp.abp_hero_rating.entity_role_map_id,
abp.abp_hero_rating.sport_id,
abp.abp_hero_rating.role_text,
abp.abp_hero_rating.asset_text,
abp.abp_hero_rating.asset_title,
abp.abp_hero_rating.player_name,
abp.abp_hero_rating.player_display_name,
abp.abp_hero_rating.rating,
A.trend,
rank() over (order by abp.abp_hero_rating.rating ) as rank,
row_to_json(asset_map.*) as asset_map
from abp.abp_hero_rating
inner join abp.abp_rating_week on abp.abp_rating_week.rating_week_id=abp.abp_hero_rating.rating_week_id
inner join (select hero_rating_id, asset_id ,asset_type_id,is_cover,asset_order,i.image_file_name, i.image_path from abp.abp_hero_rating_asset_map hram
            left join abp.abp_image i
            on i.image_id = hram.asset_id)  asset_map
          on asset_map.hero_rating_id=abp.abp_hero_rating.hero_rating_id
inner join (
SELECT *,CASE WHEN LR_RATING > RATING THEN 1
                                                  WHEN LR_RATING < RATING THEN -1
              ELSE 0 END TREND
FROM (
SELECT H.*,LAG(RATING) OVER (PARTITION BY ENTITY_ROLE_MAP_ID ORDER BY R.WEEK_NUMBER )   LR_RATING
,R.WEEK_NUMBER
FROM abp.abp_HERO_RATING H
JOIN abp.abp_RATING_WEEK R
ON H.RATING_WEEK_ID = R.RATING_WEEK_ID
WHERE     H.ENTITY_ROLE_MAP_ID IN (SELECT ENTITY_ROLE_MAP_ID FROM abp.abp_HERO_RATING WHERE RATING_WEEK_ID=v_rating_id)
    ) A
) a on a.RATING_WEEK_ID=abp.abp_hero_rating.rating_week_id and A.entity_role_map_id=abp.abp_hero_rating.entity_role_map_id
where abp.abp_hero_rating.rating_week_id=v_rating_id
    order by rating
)a 
 )as playerdata ,
      
      (select 
array_to_json(array_agg(a))
from
(
select 
priority,
entity_role_map_id,
is_linkable,
is_visible
from abp.abp_asset_entity_map
where asset_type_id=v_asset_type_id
and asset_id=v_rating_id 
order by 1
)a) as entitydata,
      
(select
meta_info 
from abp.abp_seo_data
where asset_type_id=v_asset_type_id
and asset_id=v_rating_id) as seo

          from abp.abp_rating_week
          where rating_week_id=v_rating_id
     
     ) as row
      )
     into v_authorjsonarr;*/
     
     select array(
  select row_to_json(row) jsonrow
  from
  (
    select rating_year, week_of_year, show_in_web, show_in_mobile, show_in_app, is_published, is_trashed, updated_by, published_date,language_id,
           (select array_to_json(array_agg(a))
            from
            (
              select distinct rating_week_id, start_date, end_date, rating_year, week_of_year, show_in_web, show_in_mobile, show_in_app, week_number
              from abp.abp_rating_week
              where language_id = p_language_id
            ) A
           ) as weeks,
           (select array_to_json(array_agg(a))
            from
            (
              select abp.abp_hero_rating.entity_role_map_id, abp.abp_hero_rating.sport_id, abp.abp_get_entity_name(abp.abp_hero_rating.sport_id) as sport_name, abp.abp_hero_rating.role_text, abp.abp_hero_rating.asset_text, abp.abp_hero_rating.asset_title,
                     abp.abp_hero_rating.player_name, abp.abp_hero_rating.player_display_name, abp.abp_hero_rating.rating, A.trend, rank() over (order by abp.abp_hero_rating.rating ) as rank,
                     row_to_json(asset_map.*) as asset_map
              from abp.abp_hero_rating
              inner join abp.abp_rating_week
              on abp.abp_rating_week.rating_week_id = abp.abp_hero_rating.rating_week_id
              and abp.abp_rating_week.language_id = abp.abp_hero_rating.language_id
              left join (select hero_rating_id, asset_id ,asset_type_id,is_cover,asset_order,i.image_file_name, i.image_path
                          from abp.abp_hero_rating_asset_map hram
                          left join abp.abp_image i
                          on i.image_id = hram.asset_id
                          and hram.language_id = p_language_id
                         ) asset_map
              on asset_map.hero_rating_id = abp.abp_hero_rating.hero_rating_id
              left join (SELECT *,CASE WHEN LR_RATING > RATING THEN 1 WHEN LR_RATING < RATING THEN -1 ELSE 0 END TREND
                          FROM
                          (
                            SELECT H.*,LAG(RATING) OVER (PARTITION BY ENTITY_ROLE_MAP_ID ORDER BY R.WEEK_NUMBER ) LR_RATING ,R.WEEK_NUMBER
                            FROM abp.abp_HERO_RATING H
                            JOIN abp.abp_RATING_WEEK R
                            ON H.RATING_WEEK_ID = R.RATING_WEEK_ID
                            and h.language_id = r.language_id
                            WHERE H.ENTITY_ROLE_MAP_ID IN (SELECT ENTITY_ROLE_MAP_ID
                                                           FROM abp.abp_HERO_RATING
                                                           WHERE RATING_WEEK_ID = v_rating_id
                                                           and language_id = p_language_id
                                                           )) A) a
              on a.RATING_WEEK_ID = abp.abp_hero_rating.rating_week_id
              and A.entity_role_map_id = abp.abp_hero_rating.entity_role_map_id
              where abp.abp_hero_rating.rating_week_id = v_rating_id
              order by rating) a )as playerdata,
           (select array_to_json(array_agg(a))
            from
            (select priority, entity_role_map_id, is_linkable, is_visible
             from abp.abp_asset_entity_map
             where asset_type_id = v_asset_type_id
             and asset_id = v_rating_id
             order by 1) a ) as entitydata,      
           (select meta_info
            from abp.abp_seo_data
            where asset_type_id = v_asset_type_id
            and asset_id = v_rating_id) as seo
    from abp.abp_rating_week
    where rating_week_id = v_rating_id
    and  language_id = p_language_id
    ) as row)
    into v_datajsonarr;
    
    select count(1)
    	into   v_data_count
    	from   unnest(v_datajsonarr) data;
     
    foreach v_datajson in array v_datajsonarr
    loop
      v_json1 := v_json1||v_datajson||',';
     end loop;
     
      if v_data_count > 0 then
     	v_json1 := substring(v_json1,1,(length(v_json1)-1));
     else
     	v_json1 := substring(v_json1,1,(length(v_json1)));
     end if;
     
      v_json1 := v_json1||']}';
      
      p_ratingjson  := v_json1::jsonb;
 
     
     -- foreach v_playerdatajson in array v_playerdataarray
     -- loop
     -- 	v_json := v_playerdatajson;
     -- end loop;
     -- v_json := substring(v_json,1,(length(v_json)-1));
     -- v_json := v_json||']}';
      
   --  plyerdata := v_json::jsonb;
     
    -- p_result := 1;
     
/*exception
	
    when others then
      p_result := -1;*/
     
end;

$$;


--
