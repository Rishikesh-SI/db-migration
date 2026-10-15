-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_get_rating_week_r(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: labrstg_get_rating_week_r(numeric, numeric, numeric); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_get_rating_week_r(p_rating_year numeric, p_week_of_year numeric, p_language_id numeric, OUT p_ratingjson jsonb) RETURNS jsonb
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
       select max(end_date) into v_end_date from labrstg.labrstg_rating_week
       where language_id = p_language_id
       and is_published = 1;
    
        select rating_week_id into  v_rating_id
        from labrstg.labrstg_rating_week 
        where v_end_date between start_date and end_date
        and language_id = p_language_id;
  
  else 
     select rating_week_id into  v_rating_id
     from labrstg.labrstg_rating_week
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
from labrstg.labrstg_rating_week
    where language_id = p_language_id
)a ) as weeks,
(select 
array_to_json(array_agg(a))
from
(
select  
labrstg.labrstg_hero_rating.entity_role_map_id,
labrstg.labrstg_hero_rating.sport_id,
labrstg.labrstg_hero_rating.role_text,
labrstg.labrstg_hero_rating.asset_text,
labrstg.labrstg_hero_rating.asset_title,
labrstg.labrstg_hero_rating.player_name,
labrstg.labrstg_hero_rating.player_display_name,
labrstg.labrstg_hero_rating.rating,
a.trend,
rank() over (order by labrstg.labrstg_hero_rating.rating ) as rank,
row_to_json(asset_map.*) as asset_map
from labrstg.labrstg_hero_rating
inner join labrstg.labrstg_rating_week on labrstg.labrstg_rating_week.rating_week_id=labrstg.labrstg_hero_rating.rating_week_id
inner join (select hero_rating_id, asset_id ,asset_type_id,is_cover,asset_order,i.image_file_name, i.image_path from labrstg.labrstg_hero_rating_asset_map hram
            left join labrstg.labrstg_image i
            on i.image_id = hram.asset_id)  asset_map
          on asset_map.hero_rating_id=labrstg.labrstg_hero_rating.hero_rating_id
inner join (
select *,case when lr_rating > rating then 1
                                                  when lr_rating < rating then -1
              else 0 end trend
from (
select h.*,lag(rating) over (partition by entity_role_map_id order by r.week_number )   lr_rating
,r.week_number
from labrstg.labrstg_hero_rating h
join labrstg.labrstg_rating_week r
on h.rating_week_id = r.rating_week_id
where     h.entity_role_map_id in (select entity_role_map_id from labrstg.labrstg_hero_rating where rating_week_id=v_rating_id)
    ) a
) a on a.rating_week_id=labrstg.labrstg_hero_rating.rating_week_id and a.entity_role_map_id=labrstg.labrstg_hero_rating.entity_role_map_id
where labrstg.labrstg_hero_rating.rating_week_id=v_rating_id
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
from labrstg.labrstg_asset_entity_map
where asset_type_id=v_asset_type_id
and asset_id=v_rating_id 
order by 1
)a) as entitydata,
      
(select
meta_info 
from labrstg.labrstg_seo_data
where asset_type_id=v_asset_type_id
and asset_id=v_rating_id) as seo

          from labrstg.labrstg_rating_week
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
              from labrstg.labrstg_rating_week
              where language_id = p_language_id
            ) a
           ) as weeks,
           (select array_to_json(array_agg(a))
            from
            (
              select labrstg.labrstg_hero_rating.entity_role_map_id, labrstg.labrstg_hero_rating.sport_id, labrstg.labrstg_get_entity_name(labrstg.labrstg_hero_rating.sport_id) as sport_name, labrstg.labrstg_hero_rating.role_text, labrstg.labrstg_hero_rating.asset_text, labrstg.labrstg_hero_rating.asset_title,
                     labrstg.labrstg_hero_rating.player_name, labrstg.labrstg_hero_rating.player_display_name, labrstg.labrstg_hero_rating.rating, a.trend, rank() over (order by labrstg.labrstg_hero_rating.rating ) as rank,
                     row_to_json(asset_map.*) as asset_map
              from labrstg.labrstg_hero_rating
              inner join labrstg.labrstg_rating_week
              on labrstg.labrstg_rating_week.rating_week_id = labrstg.labrstg_hero_rating.rating_week_id
              and labrstg.labrstg_rating_week.language_id = labrstg.labrstg_hero_rating.language_id
              left join (select hero_rating_id, asset_id ,asset_type_id,is_cover,asset_order,i.image_file_name, i.image_path
                          from labrstg.labrstg_hero_rating_asset_map hram
                          left join labrstg.labrstg_image i
                          on i.image_id = hram.asset_id
                          and hram.language_id = p_language_id
                         ) asset_map
              on asset_map.hero_rating_id = labrstg.labrstg_hero_rating.hero_rating_id
              left join (select *,case when lr_rating > rating then 1 when lr_rating < rating then -1 else 0 end trend
                          from
                          (
                            select h.*,lag(rating) over (partition by entity_role_map_id order by r.week_number ) lr_rating ,r.week_number
                            from labrstg.labrstg_hero_rating h
                            join labrstg.labrstg_rating_week r
                            on h.rating_week_id = r.rating_week_id
                            and h.language_id = r.language_id
                            where h.entity_role_map_id in (select entity_role_map_id
                                                           from labrstg.labrstg_hero_rating
                                                           where rating_week_id = v_rating_id
                                                           and language_id = p_language_id
                                                           )) a) a
              on a.rating_week_id = labrstg.labrstg_hero_rating.rating_week_id
              and a.entity_role_map_id = labrstg.labrstg_hero_rating.entity_role_map_id
              where labrstg.labrstg_hero_rating.rating_week_id = v_rating_id
              order by rating) a )as playerdata,
           (select array_to_json(array_agg(a))
            from
            (select priority, entity_role_map_id, is_linkable, is_visible
             from labrstg.labrstg_asset_entity_map
             where asset_type_id = v_asset_type_id
             and asset_id = v_rating_id
             order by 1) a ) as entitydata,      
           (select meta_info
            from labrstg.labrstg_seo_data
            where asset_type_id = v_asset_type_id
            and asset_id = v_rating_id) as seo
    from labrstg.labrstg_rating_week
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
