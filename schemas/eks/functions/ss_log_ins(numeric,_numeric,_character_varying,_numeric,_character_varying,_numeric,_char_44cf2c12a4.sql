-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: eks
-- Object: ss_log_ins(numeric, numeric, character varying, numeric, character varying, numeric, character varying, character varying, character varying)
-- Type: FUNCTION

-- Name: ss_log_ins(numeric, numeric, character varying, numeric, character varying, numeric, character varying, character varying, character varying); Type: FUNCTION; Schema: eks; Owner: -
--

CREATE FUNCTION eks.ss_log_ins(p_cf_source_typeid numeric, p_cf_userid numeric, p_social_id character varying, p_client_id numeric, p_procedure_name character varying, p_ret_type numeric, p_error_message character varying, p_varchar_value1 character varying, p_varchar_value2 character varying) RETURNS void
    LANGUAGE plpgsql
    AS $$

-- ********************************PREFACE BLOCK*******************************

--  Written/Modified:      Date:           Reason:
--  GANESH MAHANOR             03/01/2018      CREATION

-- ********************************END PREFACE BLOCK***************************
DECLARE

V_SYSDATE         				TIMESTAMP;
V_CF_LOGID 						eks.SS_LOG.CF_LOGID%TYPE;

BEGIN

		SELECT   CURRENT_TIMESTAMP 
		INTO     V_SYSDATE;
		----------------------------------------------------------------
       
        
		INSERT INTO eks.SS_LOG
		(
		
		CF_SOURCE_TYPEID,
		CF_USERID,
        SOCIAL_ID ,
        CLIENT_ID ,
		PROCEDURE_NAME,
		RET_TYPE,
		ERROR_MESSAGE,
		VARCHAR_VALUE1,
		VARCHAR_VALUE2,
		CREATED_DATE,
		UPDATED_DATE
		)
		VALUES
		(
       
		P_CF_SOURCE_TYPEID,
		P_CF_USERID,      
	    P_SOCIAL_ID ,
        P_CLIENT_ID ,
		P_PROCEDURE_NAME,
		P_RET_TYPE,
		P_ERROR_MESSAGE,
		P_VARCHAR_VALUE1,
		P_VARCHAR_VALUE2,
		V_SYSDATE,
		V_SYSDATE
		);
		

END;

$$;


--
