-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_tour_player_get_1(integer, integer, refcursor, refcursor)
-- Type: FUNCTION

-- Name: ss_tour_player_get_1(integer, integer, refcursor, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_tour_player_get_1(p_opt_type integer, p_cf_tourid integer, p_player_details refcursor, p_player_team_stats refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  P.KHAMKAR              03/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************

DECLARE

V_DISPLAY_FLAG   NUMERIC;

BEGIN
        
	--------------------------------------------------------------------
        /* GET PLAYER DETAILS */
        
       
       
       
       SELECT       PLAYER_DISPLAY_FLAG
       INTO STRICT  V_DISPLAY_FLAG
       FROM         eks.SS_TOUR
       WHERE CF_TOURID=P_CF_TOURID;
       
       OPEN P_PLAYER_DETAILS FOR
        SELECT 
                   A.CF_PLAYERID,
                   A.FIRST_NAME,
                   A.LAST_NAME,
                   C.CF_PLAYER_CATEGORYID,
                   C.CATEGORY_NAME,
                   D.SKILL_NAME,
                   B.CF_SKILLID,
                   B.IS_ACTIVE,
                   PS.SELECTED_PERCENTAGE AS  OVERALL_SEL_PER,
                   V_DISPLAY_FLAG DISPLAY_FLAG     
        FROM       eks.SS_PLAYER A
        JOIN       eks.SS_TOUR_PLAYER B
        ON         A.CF_PLAYERID=B.CF_PLAYERID
        JOIN       eks.SS_PLAYER_CATEGORY_TYPE C
        ON         B.CF_PLAYER_CATEGORYID=C.CF_PLAYER_CATEGORYID
        JOIN       eks.SS_SKILL_MASTER D
        ON         B.CF_SKILLID=D.CF_SKILLID 
        LEFT JOIN  eks.SS_PLAYER_TOUR_SELECTION PS
        ON 		   PS.CF_PLAYERID = B.CF_PLAYERID
        AND        PS.CF_TOURID = B.CF_TOURID
        WHERE      B.CF_TOURID=P_CF_TOURID
        ORDER BY   A.FIRST_NAME;
	--------------------------------------------------------------------

       OPEN P_PLAYER_TEAM_STATS FOR
       SELECT
             A.CF_TEAMID,
             A.TEAM_NAME,
             A.TEAM_SHORT_NAME,
             B.USER_COUNT,
             B.CF_PLAYERID,
             D.FIRST_NAME,
             D.LAST_NAME,
             B.SELECTED_PERCENTAGE,
             C.PLAYED_MATCHES,
             C.TOTAL_RUNS,
             C.HIGHEST_SCORE,
             C.AVERAGE,
             C.STRIKE_RATE,
             C.CENTURY,
             C.FIFTY,
             C.PAST_TEAMID,
             C.TOTAL_WICKETS,
             C.BEST_BOWLING,
             C.ECONOMY,
             C.TOTAL_FOUR,
             C.TOTAL_SIX,
             C.TOTAL_CATCHES,
             C.STUMPING,
             C.THREE_WICKET_HAUL
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
