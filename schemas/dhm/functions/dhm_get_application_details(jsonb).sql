-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_get_application_details(jsonb)
-- Type: FUNCTION

-- Name: dhm_get_application_details(jsonb); Type: FUNCTION; Schema: dhm; Owner: -
--

CREATE FUNCTION dhm.dhm_get_application_details(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

DECLARE
v_json jsonb;
V_FIRST_NAME VARCHAR(100);
V_LAST_NAME VARCHAR(100);
v_app_id numeric;
v_result numeric;
v_status varchar(20);
v_dob date;
v_race_category VARCHAR(1000);
err_msg text;
p_result numeric;

--********************************PREFACE BLOCK*******************************
--  NAME: get_application_details
--
--  Purpose:
-- 
--  Parameters:  
--
--
--  External Output:  
--                    
--
--  Written/Modified by:   Date:           Reason:
--  R. BHATKAR             21/08/2018     
--********************************END PREFACE BLOCK***************************
	

begin
 	
	v_json:=p_json;
	
select  v_json->'data'->>'first_name',
        v_json->'data'->>'last_name',
	    v_json->'data'->>'date_of_birth',
	    v_json->'data'->>'race_category'
into    V_FIRST_NAME,
        V_LAST_NAME,
		v_dob ,
		v_race_category
		;

V_FIRST_NAME := UPPER(V_FIRST_NAME);
V_LAST_NAME := UPPER(V_LAST_NAME);

	
    select APP_ID, lower(status)
 	into strict v_app_id, v_status
 	FROM  dhm.dhm_APP_STATUS
 	WHERE upper(FIRST_NAME)	= V_FIRST_NAME
 	AND   upper(LAST_NAME) = V_LAST_NAME
 	and   DATE_OF_BIRTH = v_dob
 	AND   upper(RACE) = upper(trim(v_race_category));
    
    
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
          YEARS_PARTICIPATED,
	      app_guid 
       
	FROM  dhm.dhm_APP_STATUS
	WHERE app_id = v_app_id
  )row into p_data
  ;
 
exception
	when others then
    	--p_data = '{"error":"Error is comming"}';
		  err_msg := SQLERRM;
		  p_result := -1;
		  p_data := '{"data":{"message" :"'||coalesce(err_msg, '')||'" ,"result":"'||coalesce(p_result, 0)||'"}}';
end;

$$;


--
