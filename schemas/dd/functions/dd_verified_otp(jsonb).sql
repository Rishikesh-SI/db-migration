-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_verified_otp(jsonb)
-- Type: FUNCTION

-- Name: dd_verified_otp(jsonb); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_verified_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	/*'{
  "data": {
    "mobile_no": "",
    "otp": ""
  }
}'*/

	v_email_id text;
	v_otp text;
    v_user_guid text;
begin
	select p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'otp' ,
		   p_inputjson->'data'->>'user_guid' 
	into   v_email_id,
		   v_otp,
		   v_user_guid;

	if exists(select 1 from dd.dd_otp_details
			 where email_id=v_email_id and otp::text=v_otp and expiry_date > current_timestamp at time zone 'utc'
			) then
			 
			 update dd.dd_otp_details
			 set is_verified= 1
			 where email_id=v_email_id
			 and otp::text=v_otp;
			 
			 
			  if v_user_guid is not null then
			 update dd.dd_web_user
			 set email_id=v_email_id
			 where  user_guid=v_user_guid;
			 end if;
			p_data	:= '{"status": "1",
		 				"message": "Success"}';
			 
	else		 
			p_data	:= '{"status": "0",
		 				"message": "Invalid OTP"}';	
			
	end if;	
	
end;

$$;


--
