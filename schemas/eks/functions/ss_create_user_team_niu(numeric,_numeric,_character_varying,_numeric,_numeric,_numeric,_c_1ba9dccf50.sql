-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_create_user_team_niu(numeric, numeric, character varying, numeric, numeric, numeric, character varying, character varying, character varying, numeric[], numeric[], numeric[])
-- Type: FUNCTION

-- Name: ss_create_user_team_niu(numeric, numeric, character varying, numeric, numeric, numeric, character varying, character varying, character varying, numeric[], numeric[], numeric[]); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_create_user_team_niu(p_opt_type numeric, p_cf_tourid numeric, p_socialid character varying, p_clientid numeric, p_fav_team_id numeric, p_mobile_no numeric, p_full_name character varying, p_email_id character varying, p_source_type character varying, p_arr_playerid numeric[], p_arr_skillid numeric[], p_arr_player_categoryid numeric[], OUT p_ret_type numeric, OUT p_cf_userid numeric, OUT p_user_guid character varying) RETURNS record
    LANGUAGE plpgsql
    AS $$

DECLARE 
--********************************PREFACE BLOCK*******************************
--  NAME:   eks.SS_CREATE_USER_TEAM
--
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified:   Date:           Reason:
--  P.KHAMKAR           03/01/2018      CREATION
--********************************END PREFACE BLOCK***************************
DECLARE

V_SYSDATE                     		  TIMESTAMP(0);
V_SOURCE_TYPEID                       NUMERIC;
V_SOURCE_NAME                         VARCHAR(500);
V_UPP_SOURCE_NAME                     VARCHAR(500);
V_MOBILE_NUMBER                       NUMERIC;
V_MOBILE_NUM                          NUMERIC;
V_ERROR_MESSAGE						  VARCHAR(4000);
V_VARCHAR_VALUE                       VARCHAR(4000);
V_IS_ERROR                            NUMERIC(5);
V_MOBILE_LENGTH                       NUMERIC(5);
V_MOBILE_NUMBER_EXISTS                NUMERIC(5);
V_FAV_TEAM_EXISTS                     NUMERIC(5);
V_EMAILID_EXISTS                      NUMERIC(5);
V_UPPER_EMAIL_ID                      VARCHAR(500);
V_EMAIL_ID                            VARCHAR(500);
V_PLAYER_COUNT                        NUMERIC(5);
V_PLAYER_DIST_COUNT                   NUMERIC(5);
V_IS_ACTIVE                           NUMERIC(5);
V_TEAM_PLAYER_COUNT                   NUMERIC(5);
V_PLAYER_CATEGORYID_COUNT             NUMERIC(5);
V_CF_USERID							  NUMERIC(30);
V_USER_GUID						      VARCHAR(4000);
V_IN_PLY_COUNT                        NUMERIC(5);
V_MESSAGE                             VARCHAR(4000);
V_SOCIALID                            VARCHAR(4000);
V_SOCIAL_USER_EXISTS                  NUMERIC(5);
V_SOCIALID_F                          VARCHAR(4000);
V_EMAIL_ID_F                          VARCHAR(4000);
V_UPER_EMAIL_ID_F                     VARCHAR(4000);
V_IS_MOB_NULL                         NUMERIC(5);
V_SOCIALID_LEN_FLAG                   NUMERIC(5);
V_IS_EMAIL_NULL                       NUMERIC(5);
V_PLAYER_CAT_COUNT                    NUMERIC(5);
V_FULL_NAME                           VARCHAR(4000);
V_FULLNAME_LEN_GLAG                   NUMERIC(5);
BEGIN

    /*-------------------------------------------------------------*/
    SELECT CURRENT_TIMESTAMP
    INTO STRICT  V_SYSDATE;
    
    V_SOURCE_NAME        :=P_SOURCE_TYPE;
    V_MOBILE_NUM         :=P_MOBILE_NO;
    V_EMAIL_ID           :=P_EMAIL_ID;
    V_SOCIALID           :=P_SOCIALID;
    V_FULL_NAME          :=P_FULL_NAME;
    
    
    V_UPP_SOURCE_NAME    :=UPPER(V_SOURCE_NAME);
   
    V_UPPER_EMAIL_ID     :=UPPER(TRIM(V_EMAIL_ID));
    V_MOBILE_NUMBER      :=TRIM(V_MOBILE_NUM::TEXT);
    V_MOBILE_LENGTH      := CASE WHEN P_CLIENTID=4 THEN LENGTH(TRIM(V_MOBILE_NUMBER::TEXT)::TEXT)
                                 ELSE 10 
                            END;  
                            
    V_IS_MOB_NULL        := CASE WHEN P_CLIENTID=4 AND P_MOBILE_NO IS NULL THEN 1 
                                 /* WHEN P_CLIENTID IN (1,2) AND  COALESCE (LENGTH(TRIM(V_MOBILE_NUMBER::TEXT)::TEXT),0) =0 
                                 THEN 1 */
                                 ELSE 0
                            END;
                            
    V_IS_EMAIL_NULL      := CASE WHEN P_CLIENTID=3 AND COALESCE (LENGTH(V_UPPER_EMAIL_ID),0) = 0  THEN 1
                                 WHEN P_CLIENTID IN (1,2) 
                                 AND  V_UPPER_EMAIL_ID IS NOT NULL
                                 AND  LENGTH(V_UPPER_EMAIL_ID) = 0 THEN 1
                                 WHEN P_CLIENTID=4 THEN 0 
                                 ELSE 0 
                                 END ;
                                 
    V_SOCIALID_LEN_FLAG  := CASE WHEN P_CLIENTID IN (1,2) AND LENGTH(TRIM(V_SOCIALID)) > 0 
                                 THEN 1
                                 WHEN P_CLIENTID IN (3,4)
                                 THEN 1 
                                 ELSE 0
                             END;
                             
    V_FULLNAME_LEN_GLAG  :=CASE WHEN LENGTH(TRIM(V_FULL_NAME)) = 0 THEN 1 ELSE 0 END;
                             
                                
    /*------------------ #VALIDATION PART SATRT# --------------------*/
    -- #TOUR VALIDATION
    BEGIN
    
    SELECT
          IS_ACTIVE,
          TEAM_PLAYER_COUNT,
          MAX_PLAYER_CAT
    INTO STRICT
          V_IS_ACTIVE,
          V_TEAM_PLAYER_COUNT,
          V_PLAYER_CAT_COUNT
    FROM  eks.SS_TOUR
    WHERE CF_TOURID=P_CF_TOURID;
    
    IF (V_IS_ACTIVE <> 1)
    THEN
    
    P_RET_TYPE := 2;
    V_ERROR_MESSAGE := 'TOUR_IS_LOCKED';
    V_VARCHAR_VALUE := 'CF_TOURID : '||P_CF_TOURID || ' '||'IS_ACTIVE :'||V_IS_ACTIVE;
    V_IS_ERROR := 1; 
     
    RAISE EXCEPTION 'EXP_TOUR_IS_LOCKED';
    
    END IF;
    
    EXCEPTION 
    WHEN NO_DATA_FOUND THEN
    
    P_RET_TYPE := 3;
    V_ERROR_MESSAGE := 'INVALID_TOURID';
    V_VARCHAR_VALUE := 'CF_TOURID : '||P_CF_TOURID;
    V_IS_ERROR := 1; 
     
    RAISE EXCEPTION 'EXP_INVALID_TOURID';
    
    END;
    
    -- #SOURCE CHECKING
    BEGIN
    
    SELECT  CF_SOURCE_TYPEID
    INTO STRICT
            V_SOURCE_TYPEID
    FROM    eks.SS_SOURCE_TYPE
    WHERE   SOURCE_TYPE_NAME=V_UPP_SOURCE_NAME;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    
    P_RET_TYPE := 4;
    V_ERROR_MESSAGE := 'INVALID_SOURCE_NAME';
    V_VARCHAR_VALUE := 'SOURCE_NAME : '||V_SOURCE_NAME;
    V_IS_ERROR := 1; 
     
    RAISE EXCEPTION 'EXP_INVALID_SOURCE_NAME';
    
    END;
    /*-------------------------------------------------------------*/
    -- #FULLNAME LENGTH CHECKING
    IF ( V_FULLNAME_LEN_GLAG =1)
    THEN
    
        P_RET_TYPE := 13;
        V_ERROR_MESSAGE:= 'FULL_NAME_IS_NULL';
        V_VARCHAR_VALUE := 1;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_FULL_NAME_IS_NULL';   
    
    END IF;
    
    /*-------------------------------------------------------------*/
    -- #FAVT TEAM CHECKING
    BEGIN
    
    SELECT  1
    INTO STRICT
            V_FAV_TEAM_EXISTS 
    FROM    eks.SS_TOUR_TEAM
    WHERE   CF_TEAMID=P_FAV_TEAM_ID
    AND     CF_TOURID=P_CF_TOURID;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    
    P_RET_TYPE := 5;
    V_ERROR_MESSAGE := 'FAVT_TEAM_NOT_FOUND';
    V_VARCHAR_VALUE := 'FAVT_TAEMID : '||P_FAV_TEAM_ID;
    V_IS_ERROR := 1; 
     
    RAISE EXCEPTION 'EXP_FAVT_TEAM_NOT_FOUND';
    
    END;
    /*-------------------------------------------------------------*/
    -- #TW & FB USER CHECKING
    IF (  
         P_CLIENTID IN (1,2)
        )
    THEN 
    
    BEGIN 
    
    SELECT 1
    INTO STRICT 
          V_SOCIAL_USER_EXISTS
    FROM  eks.SS_USER
    WHERE SOCIAL_ID  =P_SOCIALID
    AND   CF_CLIENTID=P_CLIENTID;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    V_SOCIAL_USER_EXISTS :=0;
    END;
    
    ELSE 
    
    V_SOCIAL_USER_EXISTS :=0;    
    
    END IF;
    
    /*-------------------------------------------------------------*/
    -- #MOBILE LENGTH CHECKING
    IF ( V_MOBILE_LENGTH <> 10 )
    THEN
    
    P_RET_TYPE := 6;
    V_ERROR_MESSAGE := 'MOBILE_NUMBER_INVALID';
    V_VARCHAR_VALUE := 'MOBILE_NO : '||P_MOBILE_NO;
    V_IS_ERROR := 1; 
     
    RAISE EXCEPTION 'EXP_MOBILE_NUMBER_INVALID';
    
    END IF;
    
    /*-------------------------------------------------------------*/
    -- #MOBILE ALREADY EXISITS CHECKING
    
    BEGIN 
    
    SELECT 1
    INTO STRICT 
          V_MOBILE_NUMBER_EXISTS
    FROM  eks.SS_USER
    WHERE MOBILE_NO  =V_MOBILE_NUM
    AND   CF_CLIENTID=P_CLIENTID;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    V_MOBILE_NUMBER_EXISTS :=0;
    END;
    
    
    /*-------------------------------------------------------------*/
    -- #EMAILID ALREADY EXISITS CHECKING
    
    BEGIN 
    SELECT 1
    INTO STRICT 
          V_EMAILID_EXISTS
    FROM  eks.SS_USER
    WHERE UPPER_EMAIL_ID =V_UPPER_EMAIL_ID
    AND   CF_CLIENTID=P_CLIENTID;
    
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
    V_EMAILID_EXISTS :=0;
    END;
    
    /*-------------------------------------------------------------*/
    -- #DUPLICATE PLAYERID CHECKING
    
    SELECT  COUNT(1),COUNT(DISTINCT PLAYERID)
    INTO    V_PLAYER_COUNT,V_PLAYER_DIST_COUNT
    FROM    UNNEST(P_ARR_PLAYERID) PLAYERID ; 
    
    IF (V_PLAYER_COUNT <> V_PLAYER_DIST_COUNT)
    THEN
    
    P_RET_TYPE := 7;
    V_ERROR_MESSAGE := 'DUPLICATE_PLAYERID_FOUND';
    V_VARCHAR_VALUE := 'TOTAL_PLAYER_COUNT : '||V_PLAYER_COUNT || ' '||'UNIQUE_PLAYER_COUNT : '||V_PLAYER_DIST_COUNT;
    V_IS_ERROR := 1; 
     
    RAISE EXCEPTION 'EXP_DUPLICATE_PLAYERID_FOUND';
    
    END IF;
   
   /*-------------------------------------------------------------*/
    -- #PLAYER CATEGORYID CHECKING
    
    SELECT  COUNT(DISTINCT PLAYER_CATEGORYID)
    INTO    V_PLAYER_CATEGORYID_COUNT
    FROM    UNNEST(P_ARR_PLAYER_CATEGORYID) PLAYER_CATEGORYID; 
   
    
   /*------------------ #VALIDATION PART END# --------------------*/
  
   /*------------------ #GAME LOGIC START# -----------------------*/
   
   V_SOCIALID_F := CASE WHEN P_CLIENTID IN (1,2) THEN  V_SOCIALID
                        WHEN P_CLIENTID =3       THEN  V_UPPER_EMAIL_ID
                        WHEN P_CLIENTID =4       THEN  V_MOBILE_NUMBER::TEXT
                   END;
   
   V_EMAIL_ID_F := CASE WHEN P_CLIENTID IN (1,2) THEN  V_UPPER_EMAIL_ID
                        WHEN P_CLIENTID =3       THEN  V_UPPER_EMAIL_ID
                        WHEN P_CLIENTID =4       THEN  NULL
                   END;
                   
   V_UPER_EMAIL_ID_F :=UPPER(V_EMAIL_ID_F);              
                   
                   
   IF (
           P_OPT_TYPE =1 
       AND V_IS_ACTIVE =1
       AND V_MOBILE_LENGTH =10 
       AND V_MOBILE_NUMBER_EXISTS =0
       AND V_EMAILID_EXISTS =0
       AND V_PLAYER_COUNT = V_PLAYER_DIST_COUNT
       AND V_PLAYER_DIST_COUNT=V_TEAM_PLAYER_COUNT
       AND V_PLAYER_CATEGORYID_COUNT = V_PLAYER_CAT_COUNT
       AND P_FULL_NAME   IS NOT NULL
      --  AND V_EMAIL_ID_F  IS NOT NULL
       AND V_IS_EMAIL_NULL = 0 
       AND P_CLIENTID    IS NOT NULL
       AND V_IS_MOB_NULL = 0
       AND V_SOCIAL_USER_EXISTS =0
       AND V_SOCIALID_LEN_FLAG = 1
       )
   THEN
   
          -- # INSERT INTO USER TABLE
           --  V_USER_GUID  := UUID_GENERATE_V1();
           --   P_USER_GUID  := V_USER_GUID;
           
           
          INSERT INTO eks.SS_USER
           (
            SOCIAL_ID,
            CF_CLIENTID,
            FULL_NAME,
            EMAIL_ID,
            UPPER_EMAIL_ID,
            MOBILE_NO,
            FAV_TEAM_ID,
            USER_GUID,
            CF_SOURCE_TYPEID,
            IS_ACTIVE,
            IS_DELETED,
            CREATED_DATE,
            UPDATED_DATE
           )
          VALUES
          ( 
            V_SOCIALID_F,
            P_CLIENTID,
            P_FULL_NAME,
            V_EMAIL_ID_F,
            V_UPER_EMAIL_ID_F,
            P_MOBILE_NO,
            P_FAV_TEAM_ID,
            UUID_GENERATE_V1(),
            V_SOURCE_TYPEID,
            1,
            0,
            V_SYSDATE,
            V_SYSDATE
          )
          RETURNING CF_USERID,USER_GUID INTO V_CF_USERID,P_USER_GUID; 
          ----------------------------------------------
        /*   Purushottam on date 20180511
        
           BEGIN
           INSERT INTO eks.ss_user_23JAN2018
           (
               CF_USERID,
            SOCIAL_ID,
            CF_CLIENTID,
            FULL_NAME,
            EMAIL_ID,
            UPPER_EMAIL_ID,
            MOBILE_NO,
            FAV_TEAM_ID,
            USER_GUID,
            CF_SOURCE_TYPEID,
            IS_ACTIVE,
            IS_DELETED,
            CREATED_DATE,
            UPDATED_DATE
           )
          VALUES
          ( V_CF_USERID,
            V_SOCIALID_F,
            P_CLIENTID,
            P_FULL_NAME,
            V_EMAIL_ID_F,
            V_UPER_EMAIL_ID_F,
            P_MOBILE_NO,
            P_FAV_TEAM_ID,
            P_USER_GUID,
            V_SOURCE_TYPEID,
            1,
            0,
            V_SYSDATE,
            V_SYSDATE
          );
          
           EXCEPTION
           WHEN OTHERS THEN
           NULL;
          END;
          */
          ------------------------------------------
          INSERT INTO eks.SS_USER_TOUR_MAP
           (
            CF_USERID,
            CF_TOURID,
            SOCIAL_ID,
            CF_CLIENTID,
            UPPER_EMAIL_ID,
            MOBILE_NO,
            FAV_TEAM_ID,
            CF_SOURCE_TYPEID,
            IS_ACTIVE,
            IS_DELETED,
            CREATED_DATE,
            UPDATED_DATE
           )
          VALUES
           (
            V_CF_USERID,
            P_CF_TOURID,
            V_SOCIALID_F,
            P_CLIENTID,
            V_UPER_EMAIL_ID_F,
            P_MOBILE_NO,
            P_FAV_TEAM_ID,
            V_SOURCE_TYPEID,
            1,
            0,
            V_SYSDATE,
            V_SYSDATE
           );
   
         INSERT INTO eks.SS_USER_TEAM
          (
          CF_USERID,
          CF_PLAYERID,
          CF_TOURID,
          CF_SKILLID,
          CF_PLAYER_CATEGORYID,
          CF_SOURCE_TYPEID,
          FAVT_TEAM_ID,
          IS_ACTIVE,
          IS_DELETED,
          CREATED_DATE,
          UPDATED_DATE
         )
        SELECT
        V_CF_USERID CF_USERID,
        TAB.CF_PLAYERID,
        P_CF_TOURID CF_TOURID,
        TAB.PLAYER_SKILLID,
        TAB.PLAYER_CATEGORYID,
        V_SOURCE_TYPEID CF_SOURCE_TYPEID,
        P_FAV_TEAM_ID FAVT_TEAM_ID,
        1 IS_ACTIVE,
        0 IS_DELETED,
        V_SYSDATE CREATED_DATE,
        V_SYSDATE UPDATED_DATE
        FROM    
        (
        WITH
        TAB_USER_PLAYER  AS  
        (
           SELECT  *
           FROM    UNNEST(P_ARR_PLAYERID,P_ARR_SKILLID,P_ARR_PLAYER_CATEGORYID) 
                        U(CF_PLAYERID,PLAYER_SKILLID,PLAYER_CATEGORYID)    
        )    
        SELECT  
            	BPT.CF_PLAYERID,
            	UP.PLAYER_SKILLID,
                UP.PLAYER_CATEGORYID
        FROM  	eks.SS_TOUR_PLAYER  BPT
        JOIN   	TAB_USER_PLAYER UP
        ON    	BPT.CF_PLAYERID = UP.CF_PLAYERID
        AND     BPT.CF_PLAYER_CATEGORYID=UP.PLAYER_CATEGORYID
        WHERE   BPT.CF_TOURID = P_CF_TOURID
        AND     BPT.IS_ACTIVE=1
        AND     UP.PLAYER_SKILLID IN (BPT.CF_SKILLID)     
        ) TAB;   
        
        GET DIAGNOSTICS V_IN_PLY_COUNT = ROW_COUNT;
		
		--------------------------------------------------------------
		/* 
        BEGIN
		
		WITH
        TAB_USER_PLAYER  AS  
        (
           SELECT  *
           FROM    UNNEST(P_ARR_PLAYERID,P_ARR_SKILLID,P_ARR_PLAYER_CATEGORYID) 
                        U(CF_PLAYERID,PLAYER_SKILLID,PLAYER_CATEGORYID)    
        ) 
		INSERT INTO eks.ss_user_team_23jan2018
          (
          CF_USERID,
          CF_PLAYERID,
          CF_TOURID,
          CF_SKILLID,
          CF_PLAYER_CATEGORYID,
          CF_SOURCE_TYPEID,
          FAVT_TEAM_ID,
          IS_ACTIVE,
          IS_DELETED,
          CREATED_DATE,
          UPDATED_DATE
         )
        SELECT
        V_CF_USERID CF_USERID,
        TAB.CF_PLAYERID,
        P_CF_TOURID CF_TOURID,
        TAB.PLAYER_SKILLID,
        TAB.PLAYER_CATEGORYID,
        V_SOURCE_TYPEID CF_SOURCE_TYPEID,
        P_FAV_TEAM_ID FAVT_TEAM_ID,
        1 IS_ACTIVE,
        0 IS_DELETED,
        V_SYSDATE CREATED_DATE,
        V_SYSDATE UPDATED_DATE
		FROM  TAB_USER_PLAYER TAB;
		
		EXCEPTION 
		WHEN OTHERS THEN
		NULL;
		
		END;
		*/ 
		
		-------------------------------------------------------------
		
        IF (V_IN_PLY_COUNT <> V_TEAM_PLAYER_COUNT)
        THEN

        P_RET_TYPE := 8;
        V_ERROR_MESSAGE:= 'EXP_PLAYER_NOT_INSERTED';
        V_VARCHAR_VALUE := 'IN_PLY_COUNT: '||V_IN_PLY_COUNT||' TOTAL_PLAYERS: '||V_TEAM_PLAYER_COUNT;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_PLAYER_NOT_INSERTED';        
         
        
        END IF;
        
        P_RET_TYPE :=1;
        P_CF_USERID := V_CF_USERID;
        
   ELSIF (     P_OPT_TYPE =1 
           AND V_SOCIAL_USER_EXISTS =1
          )
    THEN 
        P_RET_TYPE := 16;
        V_ERROR_MESSAGE:= 'SOCIAL_USER_EXISTS';
        V_VARCHAR_VALUE := 'SOCIALID: '||P_SOCIALID;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_SOCIAL_USER_EXISTS';
    
   ELSIF (     P_OPT_TYPE =1 
           AND V_SOCIALID_LEN_FLAG =0
          )
    THEN 
        P_RET_TYPE := 18;
        V_ERROR_MESSAGE:= 'INVALID_SOCAILID';
        V_VARCHAR_VALUE := 'SOCIALID: '||-1 ;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_INVALID_SOCAILID';
    
   ELSIF (     P_OPT_TYPE =1 
           AND V_MOBILE_NUMBER_EXISTS =1
            
         )
   THEN 
        P_RET_TYPE := 9;
        V_ERROR_MESSAGE:= 'MOBILE_NUMBER_EXISTS';
        V_VARCHAR_VALUE := 'MOBILE_NO: '||P_MOBILE_NO||' ' ||'EMAIL_ID: '||P_EMAIL_ID;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_MOBILE_NUMBER_EXISTS'; 
   
  ELSIF (      P_OPT_TYPE =1 
           AND V_EMAILID_EXISTS=1
         )
   THEN 
        P_RET_TYPE := 10;
        V_ERROR_MESSAGE:= 'EMAILID_EXISTS';
        V_VARCHAR_VALUE := 'MOBILE_NO: '||P_MOBILE_NO||' ' ||'EMAIL_ID: '||P_EMAIL_ID;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_MEMAILID_EXISTS'; 
   
  ELSIF (     P_OPT_TYPE =1 
           AND V_PLAYER_DIST_COUNT <> V_TEAM_PLAYER_COUNT
         )
   THEN 
        P_RET_TYPE := 11;
        V_ERROR_MESSAGE:= 'INVALID_PLAYER_COUNT';
        V_VARCHAR_VALUE := 'PLAYER_DIST_COUNT: '||V_PLAYER_DIST_COUNT||' ' ||'TEAM_PLAYER_COUNT: '||V_TEAM_PLAYER_COUNT;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_INVALID_PLAYER_COUNT'; 
   
   ELSIF (     P_OPT_TYPE =1 
           AND V_PLAYER_CATEGORYID_COUNT <> V_PLAYER_CAT_COUNT
         )
   THEN 
        P_RET_TYPE := 12;
        V_ERROR_MESSAGE:= 'PLAYER_CATEGORYID_COUNT_MISSMATCH';
        V_VARCHAR_VALUE := 'PLAYER_CATEGORYID_COUNT: '||V_PLAYER_CATEGORYID_COUNT;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_PLAYER_CATEGORYID_COUNT_MISSMATCH'; 
        
  ELSIF (     P_OPT_TYPE =1 
           -- AND V_EMAIL_ID_F IS NULL
           AND V_IS_EMAIL_NULL =1 
          --  AND P_CLIENTID = 3
         )
   THEN 
        P_RET_TYPE := 14;
        V_ERROR_MESSAGE:= 'EMAIL_ID_IS_NULL';
        V_VARCHAR_VALUE := 1;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_EMAIL_ID_IS_NULL';
        
   ELSIF (     P_OPT_TYPE =1 
           AND P_FULL_NAME IS NULL
         )
   THEN 
        P_RET_TYPE := 13;
        V_ERROR_MESSAGE:= 'FULL_NAME_IS_NULL';
        V_VARCHAR_VALUE := 1;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_FULL_NAME_IS_NULL';   
   

  
   ELSIF (     P_OPT_TYPE =1 
           AND V_IS_MOB_NULL =1
           AND P_CLIENTID = 4
          )
    THEN 
        P_RET_TYPE := 15;
        V_ERROR_MESSAGE:= 'MOBILE_NO_IS_NULL';
        V_VARCHAR_VALUE := 1;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_MOBILE_NO_IS_NULL';
        
  
    
    ELSIF (     P_OPT_TYPE =1 
           AND V_SOCIAL_USER_EXISTS =0
           -- AND V_EMAIL_ID_F IS NULL
           AND V_IS_EMAIL_NULL =1 
           AND V_IS_MOB_NULL = 1
           AND V_SOCIALID_LEN_FLAG =0
          )
    THEN 
        P_RET_TYPE := 17;
        V_ERROR_MESSAGE:= 'INVALID_INPUT';
        V_VARCHAR_VALUE := 'SOCIALID: '||-1 ||' ' ||'EMAIL_ID: '||-1 || ' '||'MOB: ' ||-1;
        V_IS_ERROR := 1;

        RAISE EXCEPTION 'EXP_INVALID_INPUT';
        
  
        
   END IF;
   
    /*------------------ #GAME LOGIC END# -------------------------*/
/* ppppppppp
EXCEPTION  
WHEN OTHERS  THEN

 V_MESSAGE :=  'error_handling : ' || sqlstate|| '/' || sqlerrm ;

-- GET STACKED DIAGNOSTICS V_MESSAGE = PG_EXCEPTION_CONTEXT ;

P_RET_TYPE := CASE WHEN P_RET_TYPE IS NULL THEN -1 ELSE P_RET_TYPE END;
V_ERROR_MESSAGE:= CASE WHEN V_ERROR_MESSAGE IS NULL THEN V_MESSAGE ELSE V_ERROR_MESSAGE END;
V_VARCHAR_VALUE := CASE WHEN V_VARCHAR_VALUE IS NULL THEN '1' ELSE V_VARCHAR_VALUE END;
----------------------------------------------------------------
ppppppp */
/**
Log error
**/

PERFORM eks.ss_log_ins
(
    V_SOURCE_TYPEID, --<p_cf_source_typeid numeric>, 
    V_CF_USERID,--<p_cf_userid numeric>, 
    P_SOCIALID,--<p_social_id character varying>, 
    P_CLIENTID,--<p_client_id numeric>,
    'SS_CREATE_USER_TEAM',--<p_procedure_name character varying>, 
    p_ret_type,--<p_ret_type numeric>, 
    V_ERROR_MESSAGE,--<p_error_message character varying>, 
    V_VARCHAR_VALUE,--<p_varchar_value1 character varying>, 
    NULL--<p_varchar_value2 character varying>
);

RAISE NOTICE 'Transaction rollback';

--------------------------------------------------------
END;

$$;


--
