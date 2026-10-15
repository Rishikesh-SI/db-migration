-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_generate_otp(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_failed_attempt numeric;
    v_updated_date timestamp;
	v_user_lock numeric;
	v_otp_request_count numeric;
	v_mobile_with_countrycode character varying;
	v_request_ip character varying;
	v_country_code numeric;
begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'	,
		   p_inputjson->'data'->>'mobile_with_countrycode',
		   p_inputjson->'data'->>'ip',
		   p_inputjson->'data'->>'country_code'
		   
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_type,
		   v_opt,
		   v_user_guid,
		   v_is_app,
		   v_mobile_with_countrycode,
		   v_request_ip,
		   v_country_code
		   ;
		   
-- 		   insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- 			log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- 			values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-labgt01_v1.labgt01_v1_generate_otp','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labgt01_v1','logs');

		   
---
-- if v_country_code is not null 
--    and v_country_code <> '91' 
--    and not exists (select 1 from siwaf.siwaf_records_static_otp where mobile_no = v_mobile_no) then 

--    insert into siwaf.siwaf_records_static_otp 
--    (mobile_no, otp, client_name, is_active, first_login, created_date, updated_date,country_code) 
--    values 
--    (v_mobile_no, 123456, 'labgt01_v1', 1, 1, current_timestamp at time zone 'utc', current_timestamp at time zone 'utc',v_country_code);
-- end if;

---
		   	   
	if exists (select 1 from siwaf.siwaf_records_static_otp 
				   where mobile_no=v_mobile_no and client_name='labgt01_v1' and is_active=1) then
-- 		if not exists (select 1 from labgt01_v1.labgt01_v1_otp_details where mobile_no=v_mobile_no) then
 raise notice 'afterrr insert %',v_mobile_no;
            insert into labgt01_v1.labgt01_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date,mobile_no_cc,request_ip,country_code)	   
			values(coalesce(v_mobile_no,v_email_id),123456,current_timestamp at time zone 'utc',
				   current_timestamp at time zone 'utc' + '18000 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc',v_mobile_with_countrycode,v_request_ip,v_country_code);

				p_data	:= '{"status": "1",
						"otp_duration": "900",
                        "message":"Static otp"
                        }';

else 		   
	if 	v_opt in (1,2) then 
	
	    if not exists (select 1 from labgt01_v1.labgt01_v1_otp_lockout_log
					   where mobile_no = coalesce( v_mobile_no,v_email_id)
						and country_code = v_country_code
					   and lock_time > now() - interval '1 day' ) then
					   
		 	SELECT COUNT(*) INTO v_otp_request_count FROM labgt01_v1.labgt01_v1_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) and type = v_type
			and country_code = v_country_code
        	AND created_date > now() - interval '1 day';
			
			IF v_otp_request_count >= 200 THEN
               INSERT INTO labgt01_v1.labgt01_v1_otp_lockout_log (mobile_no, lock_time, country_code)
               VALUES (coalesce( v_mobile_with_countrycode,v_email_id), now(),v_country_code);
			END IF;
			
			v_user_lock := 0 ;
		
		else
		 
		    v_user_lock := 1 ;
		 
		 end if;
	
	 if v_user_lock = 0 then
	
	    select coalesce(failed_attempt,0),updated_date 
		into v_failed_attempt , v_updated_date
		from labgt01_v1.labgt01_v1_otp_details
		where mobile_no = coalesce( v_mobile_no,v_email_id) and type = v_type and country_code = v_country_code
		order by created_date desc
		limit 1;
		
			if v_failed_attempt <= 10 or (v_failed_attempt > 10 and v_updated_date + '5 minutes'::interval< current_timestamp at time zone 'utc') 
			or v_updated_date is null then	

			insert into labgt01_v1.labgt01_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date,mobile_no_cc,request_ip,country_code)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
				   current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc',v_mobile_with_countrycode,v_request_ip,v_country_code);

				 p_data	:= '{"status": "1",
				 "message": "Success",
				 "otp_duration": "1800"}';--1800

			else

			   p_data	:= '{"status": "2",
							"message": "Incorrect OTP entered, account is locked. Please try again after 60 minutes."}';

			end if;
	
	else
	     
		 p_data	:= '{"status": "2",
					"message": "OTP request count exceeded, account is locked. Please try again after 24 hours."}';
			
	end if;
	
	
	
	elseif v_opt = 3 then
	
	
		 if not exists (select 1 from labgt01_v1.labgt01_v1_otp_lockout_log
					   where mobile_no = coalesce( v_mobile_no,v_email_id)
					   and country_code = v_country_code			   
					   and lock_time > now() - interval '5 minutes' ) then
					   
		 	SELECT COUNT(*) INTO v_otp_request_count FROM labgt01_v1.labgt01_v1_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) and type = v_type and country_code = v_country_code
        	AND created_date > now() - interval '1 day';
			
			IF v_otp_request_count >= 200 THEN
               INSERT INTO labgt01_v1.labgt01_v1_otp_lockout_log (mobile_no, lock_time, country_code)
               VALUES (coalesce( v_mobile_no,v_email_id), now(), v_country_code);
			END IF;
			
			v_user_lock := 0 ;
		
		else
		 
		    v_user_lock := 1 ;
		 
		 end if;
		
		if v_user_lock = 0 then
		
				select count(1) into v_count  from labgt01_v1.labgt01_v1_otp_details
				where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type and country_code = v_country_code;	

				select max(created_date) into v_created_date from labgt01_v1.labgt01_v1_otp_details
				where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type and country_code = v_country_code;

				if (v_count <= 4 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
														 or v_created_date is null )then

					insert into labgt01_v1.labgt01_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date,mobile_no_cc,request_ip,country_code)	   
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc',v_mobile_with_countrycode,v_request_ip,v_country_code);

					p_data	:= '{"status": "1",
								"message": "Success",
								"otp_duration": "1800"}';--1800

				elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then

					insert into labgt01_v1.labgt01_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date,mobile_no_cc,request_ip,country_code)	   
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc',v_mobile_with_countrycode,v_request_ip,v_country_code);

							p_data	:= '{"status": "1",
										"message": "Success",
										"otp_duration": "1800"}';--1800
				else						
							p_data	:= '{"status": "2",
										"message": "Incorrect OTP entered, account is locked. Please try again after 60 minutes."}';
				end if;
		
		else 
		
			p_data	:= '{"status": "2",
		 				"message": "OTP request count exceeded, account is locked. Please try again after 24 hours."}';
	    
		end if ;
	
	end if;
end if;
	
	select user_full_name into v_user_full_name  from labgt01_v1.labgt01_v1_web_user
	where user_guid = v_user_guid;
	
		--   p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
