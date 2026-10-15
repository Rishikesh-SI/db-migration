-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labkc_generate_otp(jsonb); Type: FUNCTION; Schema: labkc; Owner: -
--

CREATE FUNCTION labkc.labkc_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
		   
	insert into labkc.labkc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified)	   
	values(v_mobile_no,v_otp,current_timestamp at time zone 'utc',current_timestamp at time zone 'utc' + '30 MINUTE'::interval
		  ,0);
		
		 p_data	:= '{"status": "1",
		 "message": "Success"}';
		 
		  -- p_data	:= 	jsonb_set(p_data, '{otp}', v_otp::text::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;

$$;


--
