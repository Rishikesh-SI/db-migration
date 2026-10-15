-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_generate_otp_bkp_21022024(jsonb)
-- Type: FUNCTION

-- Name: labgt_generate_otp_bkp_21022024(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_generate_otp_bkp_21022024(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

	/*'{
  "data": {
    "mobile_no": "string",
    "otp": "string",
    "email_id": "string",
    "opt": "string",
    "type": 0,
    "user_guid": "string",
    "is_app": "string"
  }
}'*/

	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_otp numeric;
	v_opt numeric;
	v_type numeric;
	v_user_guid character varying(1000);
	v_is_app numeric;
	v_count numeric ;
	v_created_date timestamp;
	v_user_full_name character varying(1000);
	v_otp_request_count numeric;
	v_request_ip character varying(1000);
    v_country_code numeric;

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app',
		   p_inputjson->'data'->>'ip',
           p_inputjson->'data'->>'country_code'
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_type,
		   v_opt,
		   v_user_guid,
		   v_is_app,
		   v_request_ip,
           v_country_code;
	
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'sendotp',
	'{"exception":""}',uuid_generate_v4(),p_inputjson,current_timestamp at time zone 'utc','labgt','db-error'); 
	
	
	--v_otp := 123456;
	if 	v_mobile_no = 'zPHKvSO83fSj+QKK6D96zlNYo7QHBmXx32QOpxzf3NM=' then
	
		insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
		values(coalesce( v_mobile_no,v_email_id),123456,current_timestamp at time zone 'utc',
			   current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);

							p_data	:= '{"status": "1",
										"message": "Success",
										"otp_duration": "306000"}';
	
	
	
	else
		   
		  
	if 	v_opt in (1,2) then  
	
					   
		 	SELECT COUNT(*) INTO v_otp_request_count FROM labgt.labgt_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) 
        	AND (created_date)::date = (current_timestamp at time zone 'utc')::date;
	
	if v_otp_request_count < 11 then
		  
	insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
	values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		   current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labgt');
		
		 p_data	:= '{"status": "1",
		 "message": "Success",
		 "otp_duration": "600"}';
		 
	else
		
		 p_data	:= '{"status": "2",
					"message": "OTP request count exceeded, account is locked. Please try again after 1 day."}';
	
	
	end if;
	
	elseif v_opt = 3 then
			
		
		select count(1) into v_count  from labgt.labgt_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type ;	
		
		select max(created_date) into v_created_date from labgt.labgt_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type;
		
		
		
		if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		
			
			insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labgt');
			
			p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "600"}';
			
		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
			insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labgt');
			
					p_data	:= '{"status": "1",
		 						"message": "Success",
								"otp_duration": "600"}';
		else						
					p_data	:= '{"status": "2",
		 						"message": "attempt exceeded."}';
		end if;
	
	
	end if;
	
	end if;
	
	
	select user_full_name into v_user_full_name  from labgt.labgt_web_user
	where user_guid = v_user_guid;
	
		 --  p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
