-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_verified_otp(jsonb)
-- Type: FUNCTION

-- Name: labkc_verified_otp(jsonb); Type: FUNCTION; Schema: labkc; Owner: -
--

CREATE FUNCTION labkc.labkc_verified_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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

	if exists(select 1 from labkc.labkc_otp_details
			 where mobile_no=v_mobile_no and otp=v_otp and expiry_date > current_timestamp at time zone 'utc'
			) then
			 
			 update labkc.labkc_otp_details
			 set is_verified= 1
			 where mobile_no=v_mobile_no and otp=v_otp;
			 
			p_data	:= '{"status": "1",
		 				"message": "Success"}';
			 
	else		 
			p_data	:= '{"status": "0",
		 				"message": "Failed"}';	
			
	end if;	
	
end;

$$;


--
