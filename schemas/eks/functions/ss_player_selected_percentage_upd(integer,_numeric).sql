-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_player_selected_percentage_upd(integer, numeric)
-- Type: FUNCTION

-- Name: ss_player_selected_percentage_upd(integer, numeric); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_player_selected_percentage_upd(p_opt_type integer, p_cf_tourid numeric, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  Ganesh Mahanor               05/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************
DECLARE 

V_TOTAL_USERS               NUMERIC;
REC_TEAM                    RECORD;
V_TOTAL_TEAM_USERS          NUMERIC; 

 CUR_TEAM  CURSOR(P_CF_TOURID INTEGER) 
      FOR 
      SELECT
      CF_TEAMID,
      ROW_NUMBER () OVER (ORDER BY CF_TEAMID) ROW_NUM
      FROM eks.SS_TOUR_TEAM
      WHERE CF_TOURID=P_CF_TOURID;
BEGIN
     
     
     SELECT  COUNT(1)
     INTO    V_TOTAL_USERS
     FROM   eks.SS_USER;
	-- WHERE   CF_TOURID = P_CF_TOURID;
     --------------------------------------------------------------
     INSERT INTO eks.SS_PLAYER_TOUR_SELECTION
     (
     CF_PLAYERID,
     CF_TOURID,
     USER_COUNT, 
     PLAYER_COUNT,    
     SELECTED_PERCENTAGE    
     )
     SELECT   CF_PLAYERID,
     		  CF_TOURID,
              USER_COUNT,
              PLAYER_COUNT,
              SELECTED_PERCENTAGE
     FROM (
             SELECT     CF_PLAYERID,
                        P_CF_TOURID   CF_TOURID,
                        V_TOTAL_USERS USER_COUNT,
                        COUNT(1)   PLAYER_COUNT,
                       ROUND( CASE WHEN V_TOTAL_USERS = 0 
                        	 THEN 0 
                        	 ELSE (COUNT(1)/V_TOTAL_USERS)*100
         				END )	SELECTED_PERCENTAGE
             FROM    	eks.SS_USER_TEAM
             WHERE     	CF_TOURID = P_CF_TOURID
             GROUP BY   CF_PLAYERID
           ) TAB 
     ON CONFLICT (CF_PLAYERID,CF_TOURID)
     DO UPDATE 
     	SET   PLAYER_COUNT = EXCLUDED.PLAYER_COUNT,
        	  USER_COUNT = EXCLUDED.USER_COUNT,
              SELECTED_PERCENTAGE = EXCLUDED.SELECTED_PERCENTAGE;
     ------------------------------------------------------------- 				
     
    
       
     
      
      OPEN CUR_TEAM(P_CF_TOURID);
      
      LOOP
     
      FETCH CUR_TEAM INTO REC_TEAM;
     
      EXIT WHEN NOT FOUND;
   
    
     SELECT  COUNT(1)
     INTO    V_TOTAL_TEAM_USERS
     FROM   eks.SS_USER
     WHERE   FAV_TEAM_ID =  REC_TEAM.CF_TEAMID;
    
    INSERT INTO eks.SS_PLAYER_TEAM_SELECTION
    (
    CF_PLAYERID,
    CF_TEAMID,
    CF_TOURID,
    USER_COUNT,
    PLAYER_COUNT,
    SELECTED_PERCENTAGE)
    SELECT
              CF_PLAYERID,
              CF_TEAMID,
     		  CF_TOURID,
              USER_COUNT,
              PLAYER_COUNT,
              SELECTED_PERCENTAGE
     FROM (        
    
     SELECT             CF_PLAYERID,
                        REC_TEAM.CF_TEAMID,
                        P_CF_TOURID   CF_TOURID,
                        V_TOTAL_TEAM_USERS USER_COUNT,
                       COUNT(1)   PLAYER_COUNT,
                        ROUND( CASE WHEN V_TOTAL_USERS = 0 
                        	 THEN 0 
                        	 ELSE (COUNT(1)/V_TOTAL_TEAM_USERS)*100
         				END )	SELECTED_PERCENTAGE
             FROM    	eks.SS_USER_TEAM
             WHERE     	CF_TOURID = P_CF_TOURID
             AND FAVT_TEAM_ID=REC_TEAM.CF_TEAMID
             GROUP BY   CF_PLAYERID,CF_TEAMID
           ) TAB 
          ON CONFLICT (CF_PLAYERID,CF_TOURID,CF_TEAMID)
          DO UPDATE 
     	  SET   PLAYER_COUNT = EXCLUDED.PLAYER_COUNT,
        	  USER_COUNT = EXCLUDED.USER_COUNT,
              SELECTED_PERCENTAGE = EXCLUDED.SELECTED_PERCENTAGE;
     END LOOP;
      
    --------------------------------------------------------------
     P_RET_TYPE := 1;             
     --------------------------------------------------------------
     
     
     
     
END;

$$;


--
