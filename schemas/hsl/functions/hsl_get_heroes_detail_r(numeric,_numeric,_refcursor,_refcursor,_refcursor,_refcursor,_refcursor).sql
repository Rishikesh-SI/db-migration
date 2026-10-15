-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_get_heroes_detail_r(numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: hsl_get_heroes_detail_r(numeric, numeric, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: hsl; Owner: -
--

CREATE FUNCTION hsl.hsl_get_heroes_detail_r(p_entityrolemapid numeric, p_languageid numeric, p_heroesdata refcursor, p_nextprevdata refcursor, p_assetcount refcursor, p_category refcursor, p_skillset refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$ 

declare
	
     v_end_date timestamp := current_timestamp at time zone 'utc';
     v_week_rating_id numeric;
     v_hero_rating_id numeric;
     
begin
	
     select max(end_date)
     into   v_end_date
     from   hsl.hsl_rating_week
     where  language_id = p_languageid
     and    is_published = 1;
     
     select rating_week_id
     into   v_week_rating_id
     from   hsl.hsl_rating_week 
     where  v_end_date between start_date and end_date
     and    language_id = p_languageid;
     
     select hero_rating_id
     into   v_hero_rating_id
     from   hsl.hsl_hero_rating
     where  rating_week_id = v_week_rating_id
     and    entity_role_map_id = p_entityrolemapid
     and    language_id = p_languageid;
     
     if v_hero_rating_id is not null then
     	
          open p_heroesdata for
          select *,hsl.hsl_get_entity_name(sport_id) sport_name
          from   hsl.hsl_hero_rating
          where  hero_rating_id = v_hero_rating_id;
                    
     else
     	
          open p_heroesdata for
          select hero_rating_id, entity_role_map_id, sport_id, role_text, asset_text, asset_title, player_name, player_display_name, rating, rating_week_id, created_date,
          updated_date, created_by, updated_by, is_active, is_deleted, asset_guid, language_id, skill_set_1, skill_set_2, skill_set_3,player_dob,player_pob,league_code,league_id,
          hsl.hsl_get_entity_name(sport_id) sport_name
          from   hsl.hsl_hero_rating hr
          where  hr.rating_week_id = (select hr1.rating_week_id
                                      from   hsl.hsl_hero_rating hr1
                                      join   hsl.hsl_rating_week rw
                                      on     rw.rating_week_id = hr1.rating_week_id
                                      where  hr1.entity_role_map_id = hr.entity_role_map_id
                                      and    hr1.language_id = hr.language_id
                                      and    entity_role_map_id = p_entityrolemapid
                                      and    hr1.language_id = p_languageid
                                      order by rw.week_number desc
                                      limit 1);
          
     end if;
     
     open p_nextprevdata for
     select a.*, source_object_id
     from 
     (
         select
         lag(entity_role_map_id) over(order by rating) prevplayerid,
         lag(player_display_name) over(order by rating) prevplayername,
         lag(sport_id) over(order by rating) prevsportid,
         entity_role_map_id currentplayerid,
         player_display_name currentplayername,
         lead(entity_role_map_id) over(order by rating) nextplayerid,
         lead(player_display_name) over(order by rating) nextplayername,
         lead(sport_id) over(order by rating) nextsportid
         from   hsl.hsl_hero_rating
         where  rating_week_id = v_week_rating_id
     ) a
     left join hsl.hsl_entity_role_map
     on entity_role_map_id = currentplayerid
     where currentplayerid = p_entityrolemapid;
     
     perform hsl.hsl_get_asset_count_by_cat_r(array[p_entityrolemapid, p_languageid], null, null, p_assetcount, p_category) s;
     
     open p_skillset for
     select *
     from   hsl.hsl_sport_skillset_map
     where  sport_id in
     (
         select hr.sport_id
         from   hsl.hsl_hero_rating hr
         where  hr.entity_role_map_id = p_entityrolemapid
         and    hr.rating_week_id = (select max(hr1.rating_week_id)
                                     from   hsl.hsl_hero_rating hr1
                                     where  hr1.entity_role_map_id = hr.entity_role_map_id)
     );
     
end;

 $$;


--
