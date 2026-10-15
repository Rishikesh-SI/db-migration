-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_get_usr_info_niu(numeric, refcursor, refcursor)
-- Type: FUNCTION

-- Name: zeven_get_usr_info_niu(numeric, refcursor, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_get_usr_info_niu(p_user_id numeric, p_ret refcursor, p_cur_usr_info refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
declare 
----********************************preface block*******************************
----  name:   zeven.zvn_get_usr_info
----
----  parameters:  
----
----
----  external output:  
----                    
----
----  written/modified:   date:           reason:
----  s.sarkar           02/12/2015      creation
----********************************end preface block***************************
v_user_id numeric;

begin
 

  select count(1) into v_user_id
  from zeven.zeven_web_user
  where user_id = p_user_id;

  if v_user_id > 0 then
  
      open p_cur_usr_info for 
        select   
                 zu.user_id,
                 zu.socialid,
                 zu.clientid,
                 user_guid,
                 zu.user_name,
                 full_name,
                 string_agg(zsm.sport_name,'||') within group (order by zu.user_id) sport_name,
                  coalesce(rating.counts,0) total_ratings,
                  coalesce(review.counts,0) total_reviews,
                  coalesce(facility_checkin.counts,0) total_checkins,
                  coalesce(want_to_play.counts,0) as want_to_play,
                  coalesce(following_count,0) as following_count,
                  coalesce(follower_count,0) as follower_count,
                  coalesce(bookmark.counts,0) as bookmark_count
        from        zeven.zeven_web_user zu
        left join  zeven.zeven_user_sport_map zusm
        on      zusm.user_id = zu.user_id
        left join  zeven.zeven_sport_master zsm
        on      zsm.sport_master_id = zusm.sportid
        left join  (
                    select count(1) as counts,user_id
                    from zeven.zeven_comment_review zcr
                    where  user_id = p_user_id and zcr.is_published <> -1 
                    group by user_id
                   )review
        on review.user_id = zu.user_id    
        left join  (
                    select count(1) as counts,user_id
                    from zeven.zeven_rating zr
                    where  user_id = p_user_id
                    group by user_id
                    )rating
        on rating.user_id = zu.user_id
        left join (
                    select count(1) as counts,user_id
                    from zeven.zeven_venue_checkins
                    where  user_id = p_user_id
                    group by user_id
                   )facility_checkin
        on facility_checkin.user_id = zu.user_id  
        left join 
                (
                   select count(1) counts,user_id
                   from   zeven.zeven_want_to_play
                   where  user_id = p_user_id
                   group by user_id
                )want_to_play  
           on want_to_play.user_id =zu.user_id
         left join 
               (
                  select      count(1) following_count,user_id
                  from           zeven.zeven_user_following uf
                  left join      zeven.zeven_web_user zu
                  on             uf.following_id = zu.user_id
                  where          uf.is_active = 1                      
                  and            zu.is_active   = 1
                  and            uf.user_id = p_user_id
                  group by user_id
               )following_cnt
          on following_cnt.user_id = zu.user_id
          left join 
                   (
                     select          count(1) follower_count,following_id                   
                      from           zeven.zeven_user_following uf                    
                      left join      zeven.zeven_web_user zu
                      on             uf.user_id = zu.user_id
                      where          uf.is_active = 1
                      and            zu.is_active   = 1
                      and            uf.following_id = p_user_id
                      group by       following_id
                   )following_cnt
          on following_cnt.following_id = zu.user_id
          left join 
                    (
                      select count(1) counts, user_id
                      from   zeven.zeven_venue_bookmark zvb
                      where  user_id = p_user_id
                      group by user_id
                    )bookmark
          on bookmark.user_id = zu.user_id          
        where zu.user_id = p_user_id
        group by  zu.socialid,zu.clientid,zu.user_name,zu.user_id,user_guid,full_name,coalesce(rating.counts,0),coalesce(review.counts,0)
                  ,coalesce(facility_checkin.counts,0),coalesce(want_to_play.counts,0),coalesce(following_count,0),
                  coalesce(follower_count,0),coalesce(bookmark.counts,0);
    
    open p_ret for select 1;
    else
    open p_ret for select -1;
      
    end if;
  

end;
$$;


--
