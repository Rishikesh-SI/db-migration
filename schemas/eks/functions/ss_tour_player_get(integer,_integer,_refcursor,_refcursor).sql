-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour_player_get(integer, integer, refcursor, refcursor)
-- Type: FUNCTION

-- Name: ss_tour_player_get(integer, integer, refcursor, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_tour_player_get(p_opt_type integer, p_cf_tourid integer, p_player_details refcursor, p_player_team_stats refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  P.KHAMKAR              03/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************

DECLARE

V_DISPLAY_FLAG   NUMERIC;
V_IS_ACTIVE      NUMERIC;
BEGIN
        
	--------------------------------------------------------------------
        /* GET PLAYER DETAILS */
        
       SELECT       PLAYER_DISPLAY_FLAG,IS_ACTIVE
       INTO STRICT  V_DISPLAY_FLAG,V_IS_ACTIVE
       FROM         eks.SS_TOUR
       WHERE CF_TOURID=P_CF_TOURID;
       
       OPEN P_PLAYER_DETAILS FOR
        SELECT 
                   A.CF_PLAYERID,
                   A.FIRST_NAME,
                   A.LAST_NAME,
                   coalesce(A.FIRST_NAME,'') ||' '|| coalesce(A.LAST_NAME,'') PLAYER_NAME,
                   C.CF_PLAYER_CATEGORYID,
                   C.CATEGORY_NAME,
                   D.SKILL_NAME,
                   B.CF_SKILLID,
                   B.IS_ACTIVE,
                   PS.SELECTED_PERCENTAGE AS  OVERALL_SEL_PER,
                   V_DISPLAY_FLAG DISPLAY_FLAG,
                   B.PAST_TEAMID,
                   B.CF_TOURNAMENTID,
                   E.TOURNAMENT_NAME,
                   V_IS_ACTIVE  END_OF_TOUR,
                   B.played_matches,
                   B.raid_points , 
                   B.raid_strike_rate::numeric(5,2) as raid_strike_rate, 
                   B.tackle_points, 
                   B.tackle_strike_rate::numeric(5,2) as tackle_strike_rate, 
                   T.team_name past_team_name
        FROM       eks.SS_PLAYER A
        JOIN       eks.SS_TOUR_PLAYER B
        ON         A.CF_PLAYERID=B.CF_PLAYERID
        JOIN       eks.SS_PLAYER_CATEGORY_TYPE C
        ON         B.CF_PLAYER_CATEGORYID=C.CF_PLAYER_CATEGORYID
        JOIN       eks.SS_SKILL_MASTER D
        ON         B.CF_SKILLID=D.CF_SKILLID 
        JOIN       eks.SS_TOURNAMENT E
        ON         B.CF_TOURNAMENTID=E.CF_TOURNAMENTID
        LEFT JOIN  eks.SS_PLAYER_TOUR_SELECTION PS
        ON 		   PS.CF_PLAYERID = B.CF_PLAYERID
        AND        PS.CF_TOURID = B.CF_TOURID
        LEFT JOIN eks.SS_TOUR_TEAM T 
        on ( B.past_teamid = T.cf_teamid 
            and B.CF_TOURID = T.CF_TOURID )
        WHERE      B.CF_TOURID=P_CF_TOURID
        AND        B.IS_ACTIVE=1
         order by C.CF_PLAYER_CATEGORYID, random();
	--------------------------------------------------------------------

       OPEN P_PLAYER_TEAM_STATS FOR
       SELECT
             A.CF_TEAMID,
             A.TEAM_NAME,
             A.TEAM_SHORT_NAME,
             B.PLAYER_COUNT USER_COUNT,
             B.CF_PLAYERID,
             D.FIRST_NAME,
             D.LAST_NAME,
             B.SELECTED_PERCENTAGE 
       FROM  eks.SS_TOUR_TEAM A
       JOIN  eks.SS_PLAYER_TEAM_SELECTION B
       ON    A.CF_TEAMID=B.CF_TEAMID
       JOIN  eks.SS_TOUR_PLAYER C
       ON    B.CF_PLAYERID=C.CF_PLAYERID
       AND   C.CF_TOURID=P_CF_TOURID
       AND   B.CF_TOURID=C.CF_TOURID
       JOIN  eks.SS_PLAYER D
       ON    C.CF_PLAYERID=D.CF_PLAYERID
       WHERE B.CF_TOURID=P_CF_TOURID;

END;

$$;


--
