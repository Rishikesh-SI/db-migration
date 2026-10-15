-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_get_application_details(character varying, character varying, timestamp without time zone, character varying)
-- Type: FUNCTION

-- Name: labjfc_get_application_details(character varying, character varying, timestamp without time zone, character varying); Type: FUNCTION; Schema: labjfc; Owner: -
--

CREATE FUNCTION labjfc.labjfc_get_application_details(p_first_name character varying, p_last_name character varying, p_dob timestamp without time zone, p_race_category character varying, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE

V_FIRST_NAME VARCHAR(100);
V_LAST_NAME VARCHAR(100);
v_app_id numeric;
v_result numeric;
v_status varchar(20);

BEGIN

V_FIRST_NAME := UPPER(P_FIRST_NAME);
V_LAST_NAME := UPPER(P_LAST_NAME);

begin
 	
    select APP_ID, lower(status)
 	into strict v_app_id, v_status
 	FROM  labjfc.labjfc_APP_STATUS
 	WHERE upper(FIRST_NAME)	= V_FIRST_NAME
 	AND   upper(LAST_NAME) = V_LAST_NAME
 	and   DATE_OF_BIRTH = P_DOB
 	AND   upper(RACE) = upper(P_RACE_CATEGORY);
    
    
   select row_to_json(row) from (
select  APP_ID,
        FIRST_NAME,
        LAST_NAME,
        cast(DATE_OF_BIRTH as date)DATE_OF_BIRTH,
        GENDER,
        RACE,
        STATUS,
        REJECT_REASON,
        BIB_NO,
        SECTION,
        TSHIRT_SIZE,
        RACE_DAY_INFO_BOOK,
        TSHIRT_TYPE,
        YEARS_PARTICIPATED
       
	FROM  labjfc.labjfc_APP_STATUS
	WHERE app_id = v_app_id
     )row into p_data
     ;
    
    
 
    
    
    
exception
	when no_data_found then
    	p_data = '{"error":"Error is comming" }';
end;

 


END;

$$;


--
