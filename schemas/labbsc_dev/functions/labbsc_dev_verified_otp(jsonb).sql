-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_verified_otp(jsonb)
-- Type: FUNCTION

-- Name: labbsc_dev_verified_otp(jsonb); Type: FUNCTION; Schema: labbsc_dev; Owner: -
--

CREATE FUNCTION labbsc_dev.labbsc_dev_verified_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_otp numeric;
    v_user_guid text;
begin
	select p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'otp' ,
		   p_inputjson->'data'->>'user_guid' 
	into   v_email_id,
		   v_otp,
		   v_user_guid;

	if exists(select 1 from labbsc_dev.labbsc_dev_otp_details
			 where email_id=v_email_id and otp=v_otp and expiry_date > current_timestamp at time zone 'utc'
			) then
			 
			 update labbsc_dev.labbsc_dev_otp_details
			 set is_verified= 1
			 where email_id=v_email_id
			 and otp=v_otp;
			 
			 
			  if v_user_guid is not null then
			 update labbsc_dev.labbsc_dev_web_user
			 set email_id=v_email_id
			 where  user_guid=v_user_guid;
			 end if;
			p_data	:= '{"status": "1",
		 				"message": "Success"}';
			 
	else		 
			p_data	:= '{"status": "0",
		 				"message": "Failed"}';	
			
	end if;	
	
end;

$$;


--
