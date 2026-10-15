-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: wf_user_fp_req(numeric, character varying, character varying, character varying, refcursor)
-- Type: FUNCTION

-- Name: wf_user_fp_req(numeric, character varying, character varying, character varying, refcursor); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.wf_user_fp_req(p_opt_type numeric, p_email_id character varying, p_user_password character varying, p_cf_user_fp_reqid character varying, p_cur_user refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
-- GANESH MAHANOR                18/07/2017      CREATION

-- ********************************END PREFACE BLOCK***************************
      DECLARE
      
              V_EAMIL_EXISTS           NUMERIC;
              V_CF_USER_FP_REQID       VARCHAR;
              V_CF_CUSTOM_USERID       NUMERIC;
              V_OLD_PASSWORD           VARCHAR;
              V_EMAIL_ID               VARCHAR;
              V_ERROR_MESSAGE          VARCHAR;
              V_FULL_NAME              VARCHAR;
              V_SYSDATE                TIMESTAMP(0);
              V_RET_TYPE               NUMERIC;
              V_CF_USER_FP_REQID1      VARCHAR;
              V_CF_USERID               INT;
              V_UPPER_EMAIL_ID VARCHAR := UPPER(TRIM(p_email_id));

    BEGIN
    ----------------------------------------------------------------------------
        SELECT  CURRENT_TIMESTAMP
        INTO    V_SYSDATE;
        
                   
    ----------------------------------------------------------------------------
         BEGIN
        
            SELECT      1,
                        CF_CUSTOM_USERID,
                        EMAIL_ID,
                        USER_PASSWORD,
                        FULL_NAME
                       
            INTO STRICT
                        V_EAMIL_EXISTS,
                        V_CF_CUSTOM_USERID,
                        V_EMAIL_ID,
                        V_OLD_PASSWORD,
                        V_FULL_NAME 
            FROM        pkl.WF_USER_CUSTOM
            WHERE       UPPER_EMAIL_ID = V_UPPER_EMAIL_ID;
            
            
            
            EXCEPTION
            WHEN NO_DATA_FOUND THEN
            
                      V_EAMIL_EXISTS := 0;
        
        END;
        
                   
    ----------------------------------------------------------------------------
    /*
    P_OPT_TYPE 1 Generate request to change password
    */

        IF( P_OPT_TYPE = 1 AND V_EAMIL_EXISTS = 1)
        THEN       
       
            UPDATE pkl.WF_USER_FP_REQ
            SET   FP_STATUS = 2
            WHERE CF_USERID = V_CF_CUSTOM_USERID
            AND   EMAIL_ID = V_UPPER_EMAIL_ID
            AND   FP_STATUS = 0;   
        
        V_CF_USER_FP_REQID = UUID_GENERATE_V1();
        
        INSERT INTO pkl.WF_USER_FP_REQ
            ( 
                CF_USER_FP_REQID,
                CF_USERID,
                EMAIL_ID,
                OLD_PASSWORD,
                NEW_PASSWORD,
                FP_STATUS,
                CREATED_DATE,
                UPDATED_DATE
            )
            VALUES
            (
                V_CF_USER_FP_REQID,
                V_CF_CUSTOM_USERID,
                V_UPPER_EMAIL_ID,
                V_OLD_PASSWORD,
                NULL,
                0,
                V_SYSDATE ,
                V_SYSDATE 
           )RETURNING  CF_USER_FP_REQID INTO V_CF_USER_FP_REQID1;   
        
       V_CF_USER_FP_REQID=P_CF_USER_FP_REQID;
          
          V_RET_TYPE:=1;
          
         
          
--------------------------------------------------------------------------------
                    RAISE NOTICE 'HI 1';
                   RAISE NOTICE  '%',V_CF_CUSTOM_USERID;
        ELSIF(P_OPT_TYPE = 2
        AND P_USER_PASSWORD IS NOT NULL 
        AND P_CF_USER_FP_REQID IS NOT NULL 
        )
        THEN 
--------------------------------------------------------------------------------
      
          IF (P_CF_USER_FP_REQID IS NOT NULL)
          THEN
          UPDATE  pkl.WF_USER_CUSTOM A
          SET     USER_PASSWORD = P_USER_PASSWORD,
          UPDATED_DATE = V_SYSDATE
          WHERE EXISTS (SELECT CF_USER_FP_REQID 
                      FROM pkl.WF_USER_FP_REQ
                     WHERE CF_USER_FP_REQID = P_CF_USER_FP_REQID 
                     AND A.CF_CUSTOM_USERID=CF_USERID);  
          

-------------------------------------------------------------
          UPDATE  pkl.WF_USER_FP_REQ
          SET     NEW_PASSWORD = P_USER_PASSWORD,
          FP_STATUS = 1,
          UPDATED_DATE = V_SYSDATE
          WHERE   CF_USER_FP_REQID = P_CF_USER_FP_REQID
          AND     FP_STATUS = 0;

          V_OLD_PASSWORD:=P_USER_PASSWORD;
          V_RET_TYPE := 1;
      
      
---------------------------------------------------------------
        ELSIF ( P_CF_USER_FP_REQID IS  NULL)
          THEN
          
            V_RET_TYPE:=3;
            V_ERROR_MESSAGE := 'User not found in fp req';
          
        ELSE
          
            V_RET_TYPE:=0;
            V_ERROR_MESSAGE := 'Some error occured 2';
        
END IF;
         ELSIF (V_EAMIL_EXISTS = 0)
            THEN
                V_RET_TYPE:=2;
                V_ERROR_MESSAGE := 'Email id does not exists';
                
            ELSIF (P_OPT_TYPE = 2 AND P_USER_PASSWORD IS  NULL  ) 
            
            THEN
            
                V_RET_TYPE:=4; 
                V_ERROR_MESSAGE := 'User password should not be null';
            
            
            ELSIF (P_OPT_TYPE = 2 AND P_CF_USER_FP_REQID IS  NULL ) 
            THEN
            
                V_RET_TYPE:=5;
                V_ERROR_MESSAGE := 'Request id should not be null';
          
            ELSE
            
                V_RET_TYPE:=0;
                V_ERROR_MESSAGE := 'Some error occured 1';
            
            END IF;
--------------------------------------------------------------  
          

              OPEN P_CUR_USER FOR
                SELECT  V_RET_TYPE          RET_TYPE,
                        V_EMAIL_ID          EMAIL_ID,
                        V_OLD_PASSWORD      OLD_PASSWORD,
                        V_CF_CUSTOM_USERID  CF_USERID , 
                        V_FULL_NAME         FULL_NAME,
                        CASE WHEN P_OPT_TYPE=1 THEN V_CF_USER_FP_REQID1 ELSE P_CF_USER_FP_REQID END CF_USER_FP_REQID;

               
         EXCEPTION
           WHEN OTHERS THEN
              
              OPEN P_CUR_USER FOR
              SELECT  -1 RET_TYPE;

 
 END;

$$;


--
