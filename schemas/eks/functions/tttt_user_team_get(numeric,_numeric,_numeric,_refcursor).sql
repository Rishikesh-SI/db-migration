-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: tttt_user_team_get(numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: tttt_user_team_get(numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.tttt_user_team_get(p_opt_type numeric, p_cf_userid numeric, p_cf_tourid numeric, p_cur_user_team refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*--********************************PREFACE BLOCK********************************/
--  NAME:  eks.SS_USER_TEAM_GET
--  Parameters:                  
--  External Output:  Returns NUMBER

--  Written/Modified:   Date:           Reason:
--  GANESH M          04/01/2018     Creation
/*--********************************END PREFACE BLOCK****************************/

DECLARE

V_FULL_NAME        eks.SS_USER.FULL_NAME%TYPE;
V_EMAIL_ID 		   eks.SS_USER.EMAIL_ID%TYPE;
V_MOBILE_NO 	   eks.SS_USER.MOBILE_NO%TYPE;
V_FAV_TEAMID       eks.SS_USER.FAV_TEAM_ID%TYPE;
V_FAV_TEAM_NAME    eks.SS_TEAM.TEAM_SHORT_NAME%TYPE;
BEGIN
  
 SELECT   US.FULL_NAME,
		  US.EMAIL_ID,
          US.MOBILE_NO,
          US.FAV_TEAM_ID
 INTO     V_FULL_NAME,
 		  V_EMAIL_ID,
          V_MOBILE_NO,
          V_FAV_TEAMID
 FROM     eks.SS_USER_23jan2018 US
 WHERE    CF_USERID = P_CF_USERID;
 
 ------------------------------------------------------
 SELECT  TEAM_SHORT_NAME
 INTO    V_FAV_TEAM_NAME   
 FROM    eks.SS_TEAM UT
 WHERE   CF_TEAMID =  V_FAV_TEAMID;
------------------------------------------------------
 
 
  
 OPEN P_CUR_USER_TEAM
 FOR
SELECT 
		P_CF_USERID CF_USERID,
		P_CF_TOURID CF_TOURID,
		V_FULL_NAME FULL_NAME,
		V_EMAIL_ID EMAIL_ID,
		V_MOBILE_NO MOBILE_NO,
		PL.CF_PLAYERID,
		PL.FIRST_NAME,
		PL.LAST_NAME,
		SK.SKILL_NAME,
		PCT.CF_PLAYER_CATEGORYID,
		PCT.CATEGORY_NAME,
		V_FAV_TEAMID FAV_TEAMID,
		V_FAV_TEAM_NAME FAV_TEAM_NAME
FROM 	eks.ss_user_team_23jan2018 U
JOIN 	eks.SS_PLAYER PL
ON 		PL.CF_PLAYERID=U.CF_PLAYERID
JOIN 	eks.SS_TOUR_PLAYER TP
ON 		TP.CF_PLAYERID=U.CF_PLAYERID
AND 	TP.CF_PLAYERID=PL.CF_PLAYERID
AND 	TP.CF_PLAYER_CATEGORYID=U.CF_PLAYER_CATEGORYID
AND 	TP.CF_TOURID=U.CF_TOURID
JOIN 	eks.SS_PLAYER_CATEGORY_TYPE PCT
ON 		PCT.CF_PLAYER_CATEGORYID=TP.CF_PLAYER_CATEGORYID
JOIN 	eks.SS_SKILL_MASTER SK
ON 		SK.CF_SKILLID=TP.CF_SKILLID
WHERE 	U.CF_USERID=P_CF_USERID
AND   	U.CF_TOURID=P_CF_TOURID
ORDER BY PCT.CF_PLAYER_CATEGORYID;
END;

$$;


--
