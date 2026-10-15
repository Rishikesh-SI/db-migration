-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: dd_generate_otp(jsonb); Type: FUNCTION; Schema: dd; Owner: -
--

CREATE FUNCTION dd.dd_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_user_id numeric;
	v_user_name text;
    v_user_guid text;
begin
	select p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'otp' ,
		   p_inputjson->'data'->>'user_guid' 
	into   v_email_id,
		   v_otp,
		   v_user_guid;
		   
		  select user_id,user_full_name
		  from dd.dd_web_user
		  where user_guid=v_user_guid
		  into v_user_id,v_user_name;
		  
		---  raise notice '%',v_user_id;
		  
		  
		  if v_user_id is not null then 
	insert into dd.dd_otp_details(email_id,otp,created_date,expiry_date,is_verified)	   
	values(v_email_id,v_otp,current_timestamp at time zone 'utc',current_timestamp at time zone 'utc' + '30 MINUTE'::interval
		  ,0);
		
		 p_data	:= '{"status": "1",
		 "message": "Success"}';
		   v_user_name:='"'||v_user_name||'"';
		   v_email_id:='"'||v_email_id||'"';
	 
	  p_data	:= 	jsonb_set(p_data, '{otp}', v_otp::text::jsonb,true);
	  if v_user_name is not null then
	   p_data	:= 	jsonb_set(p_data, '{user_full_name}',v_user_name::jsonb,true);
		 end if; 
 
		   p_data	:= 	jsonb_set(p_data, '{email_id}', v_email_id::jsonb, true);
		 
	end if;	 
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;

$$;


--
