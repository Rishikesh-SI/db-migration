-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: tt5_user_team_get(numeric, numeric, numeric)
-- Type: FUNCTION

-- Name: tt5_user_team_get(numeric, numeric, numeric); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.tt5_user_team_get(p_opt_type numeric, p_cf_userid numeric, p_cf_tourid numeric) RETURNS TABLE(cf_userid numeric, cf_tourid numeric, full_name character varying, email_id character varying, mobile_no numeric, cf_playerid numeric, first_name character varying, last_name character varying, skill_name character varying, cf_player_categoryid numeric, category_name character varying, fav_teamid numeric, fav_team_name character varying)
    LANGUAGE plpgsql
    AS $$

/*--********************************PREFACE BLOCK********************************/
--  NAME:  IPL.SS_USER_TEAM_GET
--  Parameters:                  
--  External Output:  Returns NUMBER

--  Written/Modified:   Date:           Reason:
--  GANESH M          04/01/2018     Creation
/*--********************************END PREFACE BLOCK****************************/

DECLARE

V_FULL_NAME        varchar(4000);
V_EMAIL_ID 		   varchar(4000);
V_MOBILE_NO 	   numeric;
V_FAV_TEAMID       numeric;
V_FAV_TEAM_NAME    varchar(500);
BEGIN
  
 SELECT   US.FULL_NAME,
		  US.EMAIL_ID,
          US.MOBILE_NO,
          US.FAV_TEAM_ID
 INTO     V_FULL_NAME,
 		  V_EMAIL_ID,
          V_MOBILE_NO,
          V_FAV_TEAMID
 FROM     IPL.SS_USER US
 WHERE    CF_USERID = P_CF_USERID;
 
 ------------------------------------------------------
 SELECT  TEAM_SHORT_NAME
 INTO    V_FAV_TEAM_NAME   
 FROM    IPL.SS_TEAM UT
 WHERE   CF_TEAMID =  V_FAV_TEAMID;
------------------------------------------------------
 
 
  
  RETURN QUERY 
SELECT 
		P_CF_USERID CF_USERI,
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
FROM 	IPL.ss_user_team_23jan2018 U
JOIN 	IPL.SS_PLAYER PL
ON 		PL.CF_PLAYERID=U.CF_PLAYERID
JOIN 	IPL.SS_TOUR_PLAYER TP
ON 		TP.CF_PLAYERID=U.CF_PLAYERID
AND 	TP.CF_PLAYERID=PL.CF_PLAYERID
AND 	TP.CF_PLAYER_CATEGORYID=U.CF_PLAYER_CATEGORYID
AND 	TP.CF_TOURID=U.CF_TOURID
JOIN 	IPL.SS_PLAYER_CATEGORY_TYPE PCT
ON 		PCT.CF_PLAYER_CATEGORYID=TP.CF_PLAYER_CATEGORYID
JOIN 	IPL.SS_SKILL_MASTER SK
ON 		SK.CF_SKILLID=TP.CF_SKILLID
WHERE 	U.CF_USERID=P_CF_USERID
AND   	U.CF_TOURID=P_CF_TOURID
ORDER BY PCT.CF_PLAYER_CATEGORYID;
END;
 $$;


--
