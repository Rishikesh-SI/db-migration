-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: pk_user_team_get(numeric, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: pk_user_team_get(numeric, numeric, numeric, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.pk_user_team_get(p_opt_type numeric, p_cf_userid numeric, p_cf_tourid numeric, p_cur_user_team refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

/*--********************************PREFACE BLOCK********************************/
--  NAME:  eks.SS_USER_TEAM_GET
--  Parameters:                  
--  External Output:  Returns NUMBER

--  Written/Modified:   Date:           Reason:
--  GANESH M          04/01/2018     Creation
/*--********************************END PREFACE BLOCK****************************/

BEGIN
    
 OPEN P_CUR_USER_TEAM
 FOR
SELECT 
US.CF_USERID,
U.CF_TOURID,
US.FULL_NAME,
US.EMAIL_ID,
US.MOBILE_NO,
PL.CF_PLAYERID,
PL.FIRST_NAME,
PL.LAST_NAME,
SK.SKILL_NAME,
PCT.CF_PLAYER_CATEGORYID,
PCT.CATEGORY_NAME,
UT.CF_TEAMID FAV_TEAMID,
UT.TEAM_SHORT_NAME FAV_TEAM_NAME
FROM eks.SS_USER US
JOIN eks.SS_USER_TEAM U
ON US.CF_USERID=U.CF_USERID
AND US.FAV_TEAM_ID=U.FAVT_TEAM_ID
JOIN eks.SS_PLAYER PL
ON PL.CF_PLAYERID=U.CF_PLAYERID
JOIN eks.SS_TOUR_PLAYER TP
ON TP.CF_PLAYERID=U.CF_PLAYERID
AND TP.CF_PLAYERID=PL.CF_PLAYERID
AND TP.CF_PLAYER_CATEGORYID=U.CF_PLAYER_CATEGORYID
AND TP.CF_TOURID=U.CF_TOURID
JOIN eks.SS_PLAYER_CATEGORY_TYPE PCT
ON PCT.CF_PLAYER_CATEGORYID=TP.CF_PLAYER_CATEGORYID
JOIN eks.SS_SKILL_MASTER SK
ON SK.CF_SKILLID=TP.CF_SKILLID
JOIN eks.SS_TEAM UT
ON UT.CF_TEAMID=U.FAVT_TEAM_ID
WHERE US.CF_USERID=P_CF_USERID
AND U.CF_TOURID=P_CF_TOURID
ORDER BY PCT.CF_PLAYER_CATEGORYID;

END;

$$;


--
