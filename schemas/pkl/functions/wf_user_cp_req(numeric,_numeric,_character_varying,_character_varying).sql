-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pkl
-- Object: wf_user_cp_req(numeric, numeric, character varying, character varying)
-- Type: FUNCTION

-- Name: wf_user_cp_req(numeric, numeric, character varying, character varying); Type: FUNCTION; Schema: pkl; Owner: -
--

CREATE FUNCTION pkl.wf_user_cp_req(p_opt_type numeric, p_cf_userid numeric, p_old_password character varying, p_new_password character varying, OUT p_ret_type numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
-- GANESH MAHANOR                18/07/2017      CREATION

-- ********************************END PREFACE BLOCK***************************
DECLARE

V_OLD_PASSWORD 		pkl.WF_USER_CUSTOM.USER_PASSWORD%TYPE;
V_SOCIAL_ID			pkl.WF_USER.SOCIAL_ID%TYPE;	
V_CF_USERID         NUMERIC;
V_SYSDATE      		TIMESTAMP(0);
V_PASS_MATCHES  	NUMERIC;
    BEGIN
    -----------------------------------------------------
    SELECT  CURRENT_TIMESTAMP
    INTO    V_SYSDATE;
    ------------------------------------------------------
    BEGIN
    
        SELECT SOCIAL_ID
        INTO  STRICT
               V_SOCIAL_ID
        FROM   pkl.WF_USER 
        WHERE  CF_USERID = P_CF_USERID;
        --------------------------------------------------------
        V_CF_USERID := CAST ( V_SOCIAL_ID AS NUMERIC);
        --------------------------------------------------------
		SELECT  1,
           CF_CUSTOM_USERID,
           USER_PASSWORD,
    	INTO STRICT
           V_PASS_MATCHES
           V_CF_USERID,
           V_OLD_PASSWORD
     	FROM  pkl.WF_USER_CUSTOM  
     	WHERE CF_CUSTOM_USERID=V_CF_USERID
     	AND   USER_PASSWORD=P_OLD_PASSWORD;
        ----------------------------------------------------------
        
        UPDATE pkl.WF_USER_CUSTOM
        SET  USER_PASSWORD=P_NEW_PASSWORD,
             UPDATED_DATE = V_SYSDATE		
        WHERE CF_CUSTOM_USERID=V_CF_USERID;
        ----------------------------------------------------------
        P_RET_TYPE := 1;
    EXCEPTION
    WHEN NO_DATA_FOUND THEN
   
            V_PASS_MATCHES=0;
            P_RET_TYPE=2;
    
    END;
          
   
   EXCEPTION
   WHEN OTHERS THEN
   P_RET_TYPE=-1;
   END;
    

$$;


--
