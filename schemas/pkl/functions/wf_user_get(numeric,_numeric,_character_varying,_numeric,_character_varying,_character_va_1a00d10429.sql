-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: wf_user_get(numeric, numeric, character varying, numeric, character varying, character varying, character varying, numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: wf_user_get(numeric, numeric, character varying, numeric, character varying, character varying, character varying, numeric, numeric, refcursor); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.wf_user_get(p_opt_type numeric, p_cf_userid numeric, p_social_id character varying, p_cf_clientid numeric, p_email_id character varying, p_user_password character varying, p_full_name character varying, p_cf_fav_teamid numeric, p_mobile_no numeric, p_user_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

DECLARE

V_SYSDATE				TIMESTAMP;
V_DATE_TIMESTAMP_IST	TIMESTAMP;
V_LOGIN_DATE_IST		DATE;
V_CF_CUSTOM_USERID 		pkl.WF_USER_CUSTOM.CF_CUSTOM_USERID%TYPE;

V_CF_USERID 			pkl.WF_USER.CF_USERID%TYPE;
V_SOCIAL_ID 			pkl.WF_USER.SOCIAL_ID%TYPE;
V_CF_CLIENTID 			pkl.WF_USER.CF_CLIENTID%TYPE;
V_EMAIL_ID 				pkl.WF_USER.EMAIL_ID%TYPE;
V_FULL_NAME 			pkl.WF_USER.FULL_NAME%TYPE;
V_CF_FAV_TEAMID 		pkl.WF_USER.CF_FAV_TEAMID%TYPE;
V_USER_GUID 			pkl.WF_USER.USER_GUID%TYPE;
V_MOBILE_NO				pkl.WF_USER.MOBILE_NO%TYPE;	
V_RET_TYPE				NUMERIC;
V_CUSTOM_SOCIALID       pkl.WF_USER.SOCIAL_ID%TYPE;
V_UPPER_EMAIL_ID		pkl.WF_USER_CUSTOM.UPPER_EMAIL_ID%TYPE;

V_ERROR_MESSAGE		    VARCHAR(4000);
V_MESSAGE				VARCHAR(4000);
V_VARCHAR_VALUE         VARCHAR(4000);
V_IS_ERROR              NUMERIC(5);
V_EMAIL_ID_LENGTH		NUMERIC;
V_PASSWORD_LENGTH		NUMERIC;
BEGIN
 
 BEGIN
 
     SELECT CURRENT_TIMESTAMP
     INTO   V_SYSDATE;
     ----------------------------------------------------------------------
     V_DATE_TIMESTAMP_IST := pkl.KF_IST_TIME_GET();
     -----------------------------------------------------------------------
     V_LOGIN_DATE_IST := CAST(V_LOGIN_DATE_IST AS DATE);
     -----------------------------------------------------------------------
     V_UPPER_EMAIL_ID := UPPER(TRIM(P_EMAIL_ID));
     -----------------------------------------------------------------------
     IF(P_OPT_TYPE = 1)
     THEN
          
          BEGIN
          
           SELECT   CF_USERID,
                    SOCIAL_ID,
                    CF_CLIENTID,
                    EMAIL_ID,
                    FULL_NAME,
                    CF_FAV_TEAMID,
                    USER_GUID
                    
           INTO   STRICT
           			V_CF_USERID,
					V_SOCIAL_ID,
					V_CF_CLIENTID,
					V_EMAIL_ID,
					V_FULL_NAME,
					V_CF_FAV_TEAMID,
					V_USER_GUID,
					V_MOBILE_NO
		   FROM    pkl.WF_USER
           WHERE   SOCIAL_ID = P_SOCIAL_ID
           AND     CF_CLIENTID = CF_CLIENTID;
          
         EXCEPTION
         WHEN NO_DATA_FOUND THEN
            
            SELECT NEXTVAL('pkl.SEQ_WF_USERID')
            INTO   V_CF_USERID;
            ---------------------------------------------------
            V_SOCIAL_ID := P_SOCIAL_ID;
			V_CF_CLIENTID := P_CF_CLIENTID;
			V_EMAIL_ID := COALESCE(P_EMAIL_ID,'-');
			V_FULL_NAME := COALESCE(V_FULL_NAME,'-');
			V_CF_FAV_TEAMID := COALESCE(V_CF_FAV_TEAMID,0);
			V_USER_GUID :=   UUID_GENERATE_V1();
			V_MOBILE_NO := COALESCE(V_MOBILE_NO,0);
            --------------------------------------------------
            INSERT INTO  pkl.WF_USER
            (
            CF_USERID,
			SOCIAL_ID,
			CF_CLIENTID,
			EMAIL_ID,
			FULL_NAME,
			CF_FAV_TEAMID,
			USER_GUID,
			MOBILE_NO,
			CREATED_DATE_IST,
			CREATED_DATE,
			UPDATED_DATE
  			)    
            VALUES
            (
            V_CF_USERID,
			V_SOCIAL_ID,
			V_CF_CLIENTID,
			V_EMAIL_ID,
			V_FULL_NAME,
			V_CF_FAV_TEAMID,
			V_USER_GUID,
			V_MOBILE_NO,
			V_DATE_TIMESTAMP_IST,
			V_SYSDATE,
			V_SYSDATE
   			);
            
         END; 
         
         V_RET_TYPE := 1;
     
     ELSIF (P_OPT_TYPE = 2)
     THEN
           
           BEGIN
               
               SELECT  CF_CUSTOM_USERID,
                       CF_CLIENTID
               INTO STRICT
                       V_CF_CUSTOM_USERID,
                       V_CF_CLIENTID
               FROM    pkl.WF_USER_CUSTOM
               WHERE   UPPER_EMAIL_ID = V_UPPER_EMAIL_ID
               AND     USER_PASSWORD = P_USER_PASSWORD;
           	   ---------------------------------------------------
               V_CUSTOM_SOCIALID := CAST (V_CF_CUSTOM_USERID AS VARCHAR);
               ---------------------------------------------------
               SELECT   CF_USERID,
                        SOCIAL_ID,
                        CF_CLIENTID,
                        EMAIL_ID,
                        FULL_NAME,
                        CF_FAV_TEAMID,
                        USER_GUID

               INTO     V_CF_USERID,
                        V_SOCIAL_ID,
                        V_CF_CLIENTID,
                        V_EMAIL_ID,
                        V_FULL_NAME,
                        V_CF_FAV_TEAMID,
                        V_USER_GUID,
                        V_MOBILE_NO
               FROM    pkl.WF_USER
               WHERE   SOCIAL_ID = V_CUSTOM_SOCIALID
               AND     CF_CLIENTID = CF_CLIENTID;
               ---------------------------------------------------

               V_RET_TYPE := 1;
           EXCEPTION
           WHEN NO_DATA_FOUND THEN
               
               /**
               Invalid email_id password
               **/
               V_RET_TYPE := 2;
           END;
         
     
     ELSIF (P_OPT_TYPE = 3)
     THEN
     
               BEGIN
               
                   SELECT  CF_CUSTOM_USERID,
                           CF_CLIENTID
                   INTO STRICT
                           V_CF_CUSTOM_USERID,
                           V_CF_CLIENTID
                   FROM    pkl.WF_USER_CUSTOM
                   WHERE   UPPER_EMAIL_ID = V_UPPER_EMAIL_ID;
                   
                   V_RET_TYPE := 5;
    			   V_ERROR_MESSAGE := 'EXP_EMAIL_ID_EXISTS';
    			   V_VARCHAR_VALUE := V_UPPER_EMAIL_ID;
    			   V_IS_ERROR := 1; 
         		   RAISE EXCEPTION 'EXP_EMAIL_ID_EXISTS';

               EXCEPTION
               WHEN NO_DATA_FOUND THEN
               NULL;
               END;
               ---------------------------------------------------------------
               V_EMAIL_ID_LENGTH := LENGTH(V_UPPER_EMAIL_ID);
               V_PASSWORD_LENGTH := LENGTH(P_USER_PASSWORD);
               ---------------------------------------------------------------
               IF(V_EMAIL_ID_LENGTH = 0 OR V_UPPER_EMAIL_ID IS NULL)
               THEN
                    V_RET_TYPE := 3;
    				V_ERROR_MESSAGE := 'EXP_EMAIL_ID_NULL';
    				V_VARCHAR_VALUE := V_UPPER_EMAIL_ID;
    				V_IS_ERROR := 1; 
         			RAISE EXCEPTION 'EXP_MATCHDAY_LOCKED';
                    
               END IF;
               ---------------------------------------------------------------
               IF(V_PASSWORD_LENGTH = 0 OR P_USER_PASSWORD IS NULL)
               THEN
                    V_RET_TYPE := 4;
    				V_ERROR_MESSAGE := 'EXP_PASSWORD_NULL';
    				V_VARCHAR_VALUE := P_USER_PASSWORD;
    				V_IS_ERROR := 1; 
         			RAISE EXCEPTION 'EXP_PASSWORD_NULL';
                    
               END IF;
               ---------------------------------------------------------------
               SELECT NEXTVAL('pkl.SEQ_WF_CUSTOM_USERID')
               INTO   V_CF_CUSTOM_USERID;
               ---------------------------------------------------------------
               V_SOCIAL_ID := P_SOCIAL_ID;
			   V_CF_CLIENTID := P_CF_CLIENTID;
		  	   V_EMAIL_ID := COALESCE(P_EMAIL_ID,'-');
			   V_FULL_NAME := COALESCE(V_FULL_NAME,'-');
		 	   V_CF_FAV_TEAMID := COALESCE(V_CF_FAV_TEAMID,0);
		       V_USER_GUID :=   UUID_GENERATE_V1();
			   V_MOBILE_NO := COALESCE(V_MOBILE_NO,0);
               ---------------------------------------------------------------
               INSERT INTO pkl.WF_USER_CUSTOM
               (
               CF_CUSTOM_USERID,
               CF_CLIENTID,
               EMAIL_ID,
               USER_PASSWORD,
               UPPER_EMAIL_ID,
               FULL_NAME,
               CF_FAV_TEAMID,
               CREATED_DATE_IST,
               CREATED_DATE,
               UPDATED_DATE
               )
               VALUES
               (
               V_CF_CUSTOM_USERID,
			   V_CF_CLIENTID,
			   V_EMAIL_ID,
			   P_USER_PASSWORD,
			   V_UPPER_EMAIL_ID,
			   V_FULL_NAME,
			   V_CF_FAV_TEAMID,
			   V_DATE_TIMESTAMP_IST,
			   V_SYSDATE,
			   V_SYSDATE
               );    
               ---------------------------------------------------------------
               SELECT NEXTVAL('pkl.SEQ_WF_USERID')
               INTO   V_CF_USERID;
               ---------------------------------------------------------------
               V_SOCIAL_ID := CAST (V_CF_CUSTOM_USERID AS VARCHAR);
			   ---------------------------------------------------------------
               INSERT INTO  pkl.WF_USER
               (
               CF_USERID,
		 	   SOCIAL_ID,
			   CF_CLIENTID,
			   EMAIL_ID,
			   FULL_NAME,
			   CF_FAV_TEAMID,
			   USER_GUID,
			   MOBILE_NO,
			   CREATED_DATE_IST,
			   CREATED_DATE,
			   UPDATED_DATE
  			   )    
               VALUES
               (
               V_CF_USERID,
			   V_SOCIAL_ID,
			   V_CF_CLIENTID,
			   V_EMAIL_ID,
			   V_FULL_NAME,
			   V_CF_FAV_TEAMID,
			   V_USER_GUID,
			   V_MOBILE_NO,
			   V_DATE_TIMESTAMP_IST,
			   V_SYSDATE,
			   V_SYSDATE
   			   );

               V_RET_TYPE := 1;
     END IF;
     -------------------------------------------------------------------------
     
     

 EXCEPTION  
 WHEN OTHERS  THEN

 V_MESSAGE :=  'error_handling : ' || sqlstate|| '/' || sqlerrm;
 V_RET_TYPE := CASE WHEN V_RET_TYPE IS NULL THEN -1 ELSE V_RET_TYPE END;
 V_ERROR_MESSAGE:= CASE WHEN V_ERROR_MESSAGE IS NULL THEN V_MESSAGE ELSE V_ERROR_MESSAGE END;
 
 END;
    
     OPEN P_USER_CUR FOR
          SELECT    V_RET_TYPE RET_TYPE,
          			V_CF_USERID  CF_USERID,
					V_SOCIAL_ID  SOCIAL_ID ,
					V_CF_CLIENTID CF_CLIENTID,
					V_EMAIL_ID  EMAIL_ID,
					V_FULL_NAME FULL_NAME,
					V_CF_FAV_TEAMID CF_FAV_TEAMID,
					V_USER_GUID USER_GUID,
					V_MOBILE_NO MOBILE_NO;
          
     
END;

$$;


SET default_tablespace = '';

SET default_table_access_method = heap;

--
