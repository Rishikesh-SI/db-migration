-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_winner_list_get(numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: ss_user_winner_list_get(numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_user_winner_list_get(p_opt_type numeric, p_cf_tourid numeric, p_cf_teamid numeric, p_cur_winner refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  GANESH MAHANOR         16/01/2018
-- ********************************END PREFACE BLOCK***************************

 DECLARE
 
 V_FROM_NUMBER     NUMERIC;
 V_TO_NUMBER       NUMERIC;
 V_USER_COUNT      NUMERIC;
 
 
 BEGIN
 
 open p_cur_winner for
 with 
 tab_user_list
 as
 (
 select cf_userid , count(distinct t.cf_playerid) matches,  -- count(distinct t.cf_player_categoryid), 
     count(1) over() user_count
 from eks.ss_user_team t 
 inner join eks.ss_selected_team_player sp 
 on t.favt_team_id = sp.cf_teamid
 and t.cf_playerid = sp.cf_playerid
 where t.cf_tourid = p_cf_tourid
 and t.favt_team_id  = p_cf_teamid
 group by cf_userid
 having -- count(distinct t.cf_playerid) = count(distinct t.cf_player_categoryid) and
  count(distinct t.cf_playerid) >= 1 
 ),
 tab_user_team
 as
 (
     select t.cf_userid, t.favt_team_id, t.cf_playerid, t.cf_player_categoryid --, ul.user_count
     from eks.ss_user_team t
     inner join tab_user_list ul 
     on (t.cf_userid = ul.cf_userid)
    -- inner join  eks.ss_selected_team_player sp 
    -- on t.favt_team_id = sp.cf_teamid
 	-- and t.cf_playerid = sp.cf_playerid
     where t.favt_team_id  = p_cf_teamid
      
 )
 ,
tab_raider_player 
as (
     select c.cf_userid,
            c.cf_playerid , 
    		t.favt_team_id
    		-- ,t.user_count    		
     from   eks.ss_user_team c
     join   tab_user_team t
     on     c.cf_userid=t.cf_userid  
     and 	c.cf_player_categoryid = t.cf_player_categoryid
     where  c.cf_player_categoryid=1
    and  c.favt_team_id  = p_cf_teamid
  ),
 tab_defender_player 
 as(
     select c.cf_userid,
            c.cf_playerid -- ,  t.row_num
     from   eks.ss_user_team c
     join   tab_user_team t
     on     c.cf_userid=t.cf_userid
     and 	c.cf_player_categoryid = t.cf_player_categoryid
     where  c.cf_player_categoryid=2
     and  c.favt_team_id  = p_cf_teamid
 ),  
 tab_allrounder_player 
 as(
     select c.cf_userid,
            c.cf_playerid -- ,   t.row_num
     from   eks.ss_user_team c
     join   tab_user_team t
     on     c.cf_userid=t.cf_userid and c.favt_team_id=t.favt_team_id
     and 	c.cf_player_categoryid = t.cf_player_categoryid
     where  c.cf_player_categoryid=3
     and  c.favt_team_id  = p_cf_teamid
 )

     select rank() over(order by ul.matches desc, a.created_date) rank ,
         a.cf_userid,
         a.full_name,
         t.team_name, t.team_short_name,
         case when  a.cf_clientid=1 
           then  'https://www.facebook.com/'|| a.social_id  
           when   a.cf_clientid=2  
           then   'https://twitter.com/intent/user?user_id='|| a.social_id  
           when   a.cf_clientid=3 
           then   a.email_id
           when   a.cf_clientid=4 
           then   cast(a.mobile_no as varchar)
            end profile_link,
        ul.matches,
      pt.first_name||' '||pt.last_name raider_player_name,
      rpl.cf_playerid raider_playerid,
      pl.first_name||' '||pl.last_name defender_player_name,
      dpl.cf_playerid defender_playerid,
      arpt.first_name||' '||arpt.last_name allrounder_player_name,
      arp.cf_playerid allrounder_playerid,
      a.created_date as Entry_time     
     --, ul.user_count user_count
    from eks.ss_user a
    join tab_raider_player rpl
    on a.cf_userid=rpl.cf_userid
    join tab_defender_player dpl
    on a.cf_userid=dpl.cf_userid
    left join tab_allrounder_player arp
    on a.cf_userid=arp.cf_userid
    join eks.ss_player pl
    on dpl.cf_playerid=pl.cf_playerid
    join eks.ss_player pt
    on rpl.cf_playerid=pt.cf_playerid
    left join eks.ss_player arpt
    on arp.cf_playerid=arpt.cf_playerid
    join eks.ss_team t
    on t.cf_teamid = rpl.favt_team_id 
    join tab_user_list ul
    on a.cf_userid = ul.cf_userid
  --  where rpl.row_num between v_from_number and v_to_number
    order by rank, a.created_date ; 

 
END;

$$;


--
