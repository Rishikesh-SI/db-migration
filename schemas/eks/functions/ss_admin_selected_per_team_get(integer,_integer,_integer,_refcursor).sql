-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_admin_selected_per_team_get(integer, integer, integer, refcursor)
-- Type: FUNCTION

-- Name: ss_admin_selected_per_team_get(integer, integer, integer, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_admin_selected_per_team_get(p_opt_type integer, p_cf_tourid integer, p_cf_teamid integer, p_selected_per_team refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  Ganesh Mahanor             09/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************

BEGIN
        
	--------------------------------------------------------------------
    
      IF(P_CF_TEAMID=0)THEN
      
       OPEN P_SELECTED_PER_TEAM FOR
       SELECT
            B.CF_PLAYERID,
             D.FIRST_NAME,
             D.LAST_NAME,
             NULL CF_TEAMID,
             NULL TEAM_NAME,
             NULL TEAM_SHORT_NAME,
             B.USER_COUNT,
             B.PLAYER_COUNT,
             B.SELECTED_PERCENTAGE,
             T.CATEGORY_NAME,
             null tot_user_player_count,
             null player_team_percentage
       FROM  eks.SS_PLAYER_TOUR_SELECTION B
       JOIN  eks.SS_TOUR_PLAYER C
       ON    B.CF_PLAYERID=C.CF_PLAYERID
       AND   C.CF_TOURID=P_CF_TOURID
       AND   B.CF_TOURID=C.CF_TOURID
       JOIN  eks.SS_PLAYER_CATEGORY_TYPE T
       ON T.CF_PLAYER_CATEGORYID=C.CF_PLAYER_CATEGORYID
       JOIN  eks.SS_PLAYER D
       ON    C.CF_PLAYERID=D.CF_PLAYERID
       WHERE B.CF_TOURID=P_CF_TOURID
       ORDER BY B.SELECTED_PERCENTAGE DESC ,B.PLAYER_COUNT DESC;
      
      
     
      ELSE
      
      OPEN P_SELECTED_PER_TEAM FOR
       SELECT
            B.CF_PLAYERID,
             D.FIRST_NAME,
             D.LAST_NAME,
             A.CF_TEAMID,
             A.TEAM_NAME,
             A.TEAM_SHORT_NAME,
             B.USER_COUNT,
             B.PLAYER_COUNT,
             B.SELECTED_PERCENTAGE ,
             T.CATEGORY_NAME,
             S.player_count tot_user_player_count, 
        	 round((B.PLAYER_COUNT /  S.player_count)*100) player_team_percentage
       FROM  eks.SS_TOUR_TEAM A
       JOIN  eks.SS_PLAYER_TEAM_SELECTION B
       ON    A.CF_TEAMID=B.CF_TEAMID
       JOIN  eks.SS_TOUR_PLAYER C
       ON    B.CF_PLAYERID=C.CF_PLAYERID
       AND   C.CF_TOURID=P_CF_TOURID
       AND   B.CF_TOURID=C.CF_TOURID
       JOIN  eks.SS_PLAYER_CATEGORY_TYPE T
       ON T.CF_PLAYER_CATEGORYID=C.CF_PLAYER_CATEGORYID
       JOIN  eks.SS_PLAYER D       
       ON    C.CF_PLAYERID=D.CF_PLAYERID
       JOIN eks.SS_PLAYER_TOUR_SELECTION s on (B.CF_PLAYERID = S.CF_PLAYERID)
       WHERE B.CF_TOURID=P_CF_TOURID
       AND   A.CF_TEAMID=P_CF_TEAMID
       ORDER BY B.SELECTED_PERCENTAGE DESC,B.PLAYER_COUNT DESC;
       
       
       END IF;

END;

$$;


--
