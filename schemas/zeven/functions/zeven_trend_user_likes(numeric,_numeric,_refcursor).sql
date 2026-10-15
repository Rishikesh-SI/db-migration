-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_trend_user_likes(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: zeven_trend_user_likes(numeric, numeric, refcursor); Type: FUNCTION; Schema: zeven; Owner: -
--

CREATE FUNCTION zeven.zeven_trend_user_likes(p_userid numeric, p_trend_type numeric, p_cur_user_likes refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
begin 
    open p_cur_user_likes for 
      select distinct zm.articleid,zm.categoryid,case coalesce(zua.articleid,0) when 0 then 0 else 1 end as user_liked
      from   zeven.zeven_trend_master zm
      left join  zeven.zeven_track_user_activity zua
              on   zua.articleid = zm.articleid
                   and
--                   zua.categoryid = zm.categoryid
--                   and 
                   zua.userid = p_userid
                   and 
                   zua.activityid = 3
                   and
                   zua.asset_type_id = zm.asset_type_id
      where   zm.trend_type_id = p_trend_type
              and
              zm.is_latest = 1;
end;
$$;


--
