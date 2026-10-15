-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_user_lederboard_get_bak_20180523(numeric, numeric, numeric[], numeric, refcursor)
-- Type: FUNCTION

-- Name: ss_user_lederboard_get_bak_20180523(numeric, numeric, numeric[], numeric, refcursor); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_user_lederboard_get_bak_20180523(p_opt_type numeric, p_cf_teamid numeric, p_cf_playerid numeric[], p_page_no numeric, p_cur_lederboard refcursor) RETURNS SETOF refcursor
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
 
    V_FROM_NUMBER= 
                    CASE WHEN P_PAGE_NO=1 THEN 1
                          WHEN P_PAGE_NO=2 THEN 50001
                          WHEN P_PAGE_NO=3 THEN 100001
                          WHEN P_PAGE_NO=4 THEN 150001
                          WHEN P_PAGE_NO=5 THEN 200001
                          WHEN P_PAGE_NO=6 THEN 250001
                          WHEN P_PAGE_NO=7 THEN 300001
                          WHEN P_PAGE_NO=8 THEN 350001
                          WHEN P_PAGE_NO=9 THEN 400001
                          WHEN P_PAGE_NO=10 THEN 450001 
                          WHEN P_PAGE_NO=11 THEN 500001
                          WHEN P_PAGE_NO=12 THEN 550001
                          WHEN P_PAGE_NO=13 THEN 600001
                          WHEN P_PAGE_NO=14 THEN 650001
                          WHEN P_PAGE_NO=15 THEN 700001
                          WHEN P_PAGE_NO=16 THEN 750001
                          WHEN P_PAGE_NO=17 THEN 800001
                          WHEN P_PAGE_NO=18 THEN 850001
                          WHEN P_PAGE_NO=19 THEN 900001
                          WHEN P_PAGE_NO=20 THEN 950001
                          
                          END;
                          
                          
     V_TO_NUMBER= 
                     CASE WHEN P_PAGE_NO=1 THEN 50000
                          WHEN P_PAGE_NO=2 THEN 100000
                          WHEN P_PAGE_NO=3 THEN 150000
                          WHEN P_PAGE_NO=4 THEN 200000
                          WHEN P_PAGE_NO=5 THEN 250000
                          WHEN P_PAGE_NO=6 THEN 300000
                          WHEN P_PAGE_NO=7 THEN 350000
                          WHEN P_PAGE_NO=8 THEN 400000
                          WHEN P_PAGE_NO=9 THEN 450000
                          WHEN P_PAGE_NO=10 THEN 500000
                          WHEN P_PAGE_NO=11 THEN 550000
                          WHEN P_PAGE_NO=12 THEN 600000
                          WHEN P_PAGE_NO=13 THEN 650000
                          WHEN P_PAGE_NO=14 THEN 700000
                          WHEN P_PAGE_NO=15 THEN 750000
                          WHEN P_PAGE_NO=16 THEN 800000
                          WHEN P_PAGE_NO=17 THEN 850000
                          WHEN P_PAGE_NO=18 THEN 900000
                          WHEN P_PAGE_NO=19 THEN 950000
                          WHEN P_PAGE_NO=20 THEN 1000000
                          END;                     
 
 
 
    IF(P_OPT_TYPE=1) THEN
   
   WITH TAB_PLAYER_IN AS(
         SELECT CF_USERID,COUNT(CF_PLAYERID) 
         FROM eks.SS_USER_TEAM
         WHERE FAVT_TEAM_ID=P_CF_TEAMID 
         AND CF_PLAYERID IN(SELECT * FROM unnest(P_CF_PLAYERID))
         GROUP BY CF_USERID 
         HAVING COUNT(CF_PLAYERID)=2)
         SELECT COUNT(*)
         INTO V_USER_COUNT
         FROM  TAB_PLAYER_IN;
         
       ELSE
       
       V_USER_COUNT=0;
       
       END IF;

OPEN P_CUR_LEDERBOARD FOR

WITH TAB_PLAYER_IN AS(
     SELECT CF_USERID,
            COUNT(CF_PLAYERID),
            ROW_NUMBER () OVER (ORDER BY CF_USERID ASC) ROW_NUM
     FROM   eks.SS_USER_TEAM
     WHERE  FAVT_TEAM_ID=P_CF_TEAMID 
     AND CF_PLAYERID IN(SELECT * FROM unnest(P_CF_PLAYERID))
     GROUP BY CF_USERID
     HAVING COUNT(CF_PLAYERID)=2),
TAB_STAR_PLAYER AS (
     SELECT C.CF_USERID,
            C.CF_PLAYERID,
            T.ROW_NUM
     FROM   eks.SS_USER_TEAM C
     JOIN   TAB_PLAYER_IN T
     ON     C.CF_USERID=T.CF_USERID                   
     WHERE  C.CF_PLAYER_CATEGORYID=1
                   ),
 TAB_UNCAMPED_PLAYER AS(
     SELECT C.CF_USERID,
            C.CF_PLAYERID,
            T.ROW_NUM
     FROM   eks.SS_USER_TEAM C
     JOIN   TAB_PLAYER_IN T
     ON     C.CF_USERID=T.CF_USERID
     WHERE  C.CF_PLAYER_CATEGORYID=2)
     
     SELECT
         A.CF_USERID,
         A.FULL_NAME,
         CASE WHEN  A.CF_CLIENTID=1 
           THEN  'HTTPS://WWW.FACEBOOK.COM/'|| A.SOCIAL_ID  
           WHEN   A.CF_CLIENTID=2  
           THEN   'HTTPS://TWITTER.COM/INTENT/USER?USER_ID='|| A.SOCIAL_ID  
           WHEN   A.CF_CLIENTID=3 
           THEN   A.EMAIL_ID
           WHEN   A.CF_CLIENTID=4 
           THEN   CAST(A.MOBILE_NO AS VARCHAR)
            END PROFILE,
      PT.FIRST_NAME||' '||PT.LAST_NAME STAR_PLAYER_NAME,
      SPL.CF_PLAYERID STAR_PLAYERID,
      PL.FIRST_NAME||' '||PL.LAST_NAME UNCAPED_PLAYER_NAME,
      UPL.CF_PLAYERID UNACAPED_PLAYERID,
      A.CREATED_DATE,
      V_USER_COUNT USER_COUNT
    FROM eks.SS_USER A
    JOIN TAB_STAR_PLAYER SPL
    ON A.CF_USERID=SPL.CF_USERID
    JOIN TAB_UNCAMPED_PLAYER UPL
    ON A.CF_USERID=UPL.CF_USERID
    JOIN eks.SS_PLAYER PL
    ON UPL.CF_PLAYERID=PL.CF_PLAYERID
    JOIN eks.SS_PLAYER PT
    ON SPL.CF_PLAYERID=PT.CF_PLAYERID
    WHERE SPL.ROW_NUM BETWEEN V_FROM_NUMBER AND V_TO_NUMBER
    ORDER BY A.CREATED_DATE;
    
    

END;

$$;


--
