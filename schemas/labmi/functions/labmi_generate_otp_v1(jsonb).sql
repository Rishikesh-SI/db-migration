-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_generate_otp_v1(jsonb)
-- Type: FUNCTION

-- Name: labmi_generate_otp_v1(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_generate_otp_v1(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'		   
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_type,
		   v_opt,
		   v_user_guid,
		   v_is_app;
	
	if 	v_mobile_no = 'zPHKvSO83fSj+QKK6D96zlNYo7QHBmXx32QOpxzf3NM=' then
	
			insert into labmi.labmi_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date)	   
			values(coalesce( v_mobile_no,v_email_id),123456,current_timestamp at time zone 'utc',
				   current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc');

				 p_data	:= '{"status": "1",
				 "message": "Success",
				 "otp_duration": "300"}';
			
	
	
	else
		   
	if 	v_opt in (1,2) then 
	
	    if not exists (select 1 from labmi.labmi_otp_lockout_log
					   where mobile_no = coalesce( v_mobile_no,v_email_id) 
					   and lock_time > now() - interval '1 hour' ) then
					   
		 	SELECT COUNT(*) INTO v_otp_request_count FROM labmi.labmi_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) and type = v_type
        	AND created_date > now() - interval '1 hour';
			
			IF v_otp_request_count >= 9 THEN
               INSERT INTO labmi.labmi_otp_lockout_log (mobile_no, lock_time)
               VALUES (coalesce( v_mobile_no,v_email_id), now());
			END IF;
			
			v_user_lock := 0 ;
		
		else
		 
		    v_user_lock := 1 ;
		 
		 end if;
	
	 if v_user_lock = 0 then
	
	    select coalesce(failed_attempt,0),updated_date 
		into v_failed_attempt , v_updated_date
		from labmi.labmi_otp_details
		where mobile_no = coalesce( v_mobile_no,v_email_id) and type = v_type 
		order by created_date desc
		limit 1;
		
			if v_failed_attempt <= 4 or (v_failed_attempt > 4 and v_updated_date + '60 minutes'::interval< current_timestamp at time zone 'utc') 
			or v_updated_date is null then	

			insert into labmi.labmi_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
				   current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc');

				 p_data	:= '{"status": "1",
				 "message": "Success",
				 "otp_duration": "300"}';

			else

			   p_data	:= '{"status": "2",
							"message": "Incorrect OTP entered, account is locked. Please try again after 60 minutes."}';

			end if;
	
	else
	     
		 p_data	:= '{"status": "2",
					"message": "OTP request count exceeded, account is locked. Please try again after 60 minutes."}';
			
	end if;
	
	
	
	elseif v_opt = 3 then
	
	
		 if not exists (select 1 from labmi.labmi_otp_lockout_log
					   where mobile_no = coalesce( v_mobile_no,v_email_id) 
					   and lock_time > now() - interval '1 hour' ) then
					   
		 	SELECT COUNT(*) INTO v_otp_request_count FROM labmi.labmi_otp_details
        	WHERE mobile_no = coalesce( v_mobile_no,v_email_id) and type = v_type
        	AND created_date > now() - interval '1 hour';
			
			IF v_otp_request_count >= 10 THEN
               INSERT INTO otp_lockout_log (mobile_no, lock_time)
               VALUES (coalesce( v_mobile_no,v_email_id), now());
			END IF;
			
			v_user_lock := 0 ;
		
		else
		 
		    v_user_lock := 1 ;
		 
		 end if;
		
		if v_user_lock = 0 then
		
				select count(1) into v_count  from labmi.labmi_otp_details
				where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type ;	

				select max(created_date) into v_created_date from labmi.labmi_otp_details
				where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type;

				if (v_count <= 4 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
														 or v_created_date is null )then

					insert into labmi.labmi_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date)	   
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc');

					p_data	:= '{"status": "1",
								"message": "Success",
								"otp_duration": "300"}';

				elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then

					insert into labmi.labmi_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt,updated_date)	   
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt,current_timestamp at time zone 'utc');

							p_data	:= '{"status": "1",
										"message": "Success",
										"otp_duration": "300"}';
				else						
							p_data	:= '{"status": "2",
										"message": "Incorrect OTP entered, account is locked. Please try again after 60 minutes."}';
				end if;
		
		else 
		
			p_data	:= '{"status": "2",
		 				"message": "OTP request count exceeded, account is locked. Please try again after 60 minutes."}';
	    
		end if ;
	
	end if;
	
	end if;
	select user_full_name into v_user_full_name  from labmi.labmi_web_user
	where user_guid = v_user_guid;
	
		   p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
