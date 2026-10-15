-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labkkr_generate_otp(jsonb); Type: FUNCTION; Schema: labkkr; Owner: -
--

CREATE FUNCTION labkkr.labkkr_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
		   
	if 	v_opt in (1,2) then    
		   
	SELECT COUNT(*) INTO v_otp_request_count FROM labkc_v1.labkc_v1_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) 
        	AND (created_date)::date = (current_timestamp at time zone 'utc')::date;
	
	if v_otp_request_count < 5 then
		   
	insert into labkc_v1.labkc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
	values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		   current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labkkr');
		
		 p_data	:= '{"status": "1",
		 "message": "Success",
		 "otp_duration": "120"}';
		 
	else
		
		 p_data	:= '{"status": "0",
					"message": "OTP request count exceeded, account is locked. Please try again after 1 day."}';
	
	
	end if;
		 
	
	elseif v_opt = 3 then
			
		
		select count(1) into v_count  from labkc_v1.labkc_v1_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type ;	
		
		select max(created_date) into v_created_date from labkc_v1.labkc_v1_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type;
		
		
		
		if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		
			
			insert into labkc_v1.labkc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labkkr');
			
			p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "120"}';
			
		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
			insert into labkc_v1.labkc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,request_ip,country_code,client_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,v_request_ip,v_country_code,'labkkr');
			
					p_data	:= '{"status": "1",
		 						"message": "Success",
								"otp_duration": "120"}';
		else						
					p_data	:= '{"status": "2",
		 						"message": "attempt exceeded."}';
		end if;
	
	
	end if;
	
	
	select user_full_name into v_user_full_name  from labkc_v1.labkc_v1_web_user
	where user_guid = v_user_guid;
	
		   p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
