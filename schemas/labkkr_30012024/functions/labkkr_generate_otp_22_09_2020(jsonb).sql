-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_generate_otp_22_09_2020(jsonb)
-- Type: FUNCTION

-- Name: labkkr_generate_otp_22_09_2020(jsonb); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_generate_otp_22_09_2020(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	/*'{
  "data": {
    "mobile_no": "",
    "otp": ""
  }
}'*/

	v_mobile_no character varying(1000);
	v_otp numeric;

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp' 
	into   v_mobile_no,
		   v_otp;
		   
	insert into labkkr.labkkr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified)	   
	values(v_mobile_no,v_otp,current_timestamp at time zone 'utc',current_timestamp at time zone 'utc' + '30 MINUTE'::interval
		  ,0);
		
		 p_data	:= '{"status": "1",
		 "message": "Success"}';
		 
		  -- p_data	:= 	jsonb_set(p_data, '{otp}', v_otp::text::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;

$$;


--
