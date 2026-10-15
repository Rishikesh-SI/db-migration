-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labfih_generate_otp(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_otp_1 numeric;
	v_failed_attempt numeric;
	v_client_id numeric;
	
begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'		  
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_opt,
		   v_type,
		   v_user_guid,
		   v_is_app;
     insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-generate_otp','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labfih','logs');            
           
			 -- v_otp:= 12318006;	  
	if not exists(select 1 from labfih.labfih_web_user where (email_id = v_email_id and email_verified = 1) ) then
				  --or (email_id = v_email_id and is_verified =1  )
			select failed_attempt,otp into v_failed_attempt,v_otp_1 from labfih.labfih_otp_details
			where mobile_no = coalesce( v_mobile_no,v_email_id)	 and created_date + '1 day'::interval > current_timestamp at time zone 'utc'
			order by created_date desc
			limit 1;
			
		 
			if 	v_opt in (1,2) then
            
             if (v_failed_attempt < 3) or (v_failed_attempt is null)  then

				if v_type = 1 then
--				if v_failed_attempt is null then

							if not exists(select 1 from labfih.labfih_otp_details
										where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '300 seconds'::interval > current_timestamp at time zone 'utc') then
								select count(1) into v_count  from labfih.labfih_otp_details
								where  mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type ;	
								
								select max(created_date) into v_created_date from labfih.labfih_otp_details
								where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
								
								
								if (v_count <= 2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
																 or v_created_date is null )then
									insert into labfih.labfih_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	  
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
                                         "subject": "Email Verification - FIH Family Account",
										 "otp_duration": "300"}';

								elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

									delete from labfih.labfih_otp_details
									where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
									insert into labfih.labfih_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
                                         "subject": "Email Verification - FIH Family Account",
										 "otp_duration": "300"}';
								else
										p_data	:= '{"status": "2",
													"message": "Too many requests for OTP"
													}';
								end if;		
							else
										 p_data := '{"status": "0",
										"message": "Previous OTP is still valid"}';
										
							end if;			
	                   
				elsif v_type = 3 then
	
								if not exists(select 1 from labfih.labfih_otp_details
										where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '300 seconds'::interval > current_timestamp at time zone 'utc') then

								select count(1) into v_count  from labfih.labfih_otp_details
								where  mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid ;	
								
								select max(created_date) into v_created_date from labfih.labfih_otp_details
								where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid;
								
								--raise notice 'v_count %',v_count;
								--raise notice 'v_created_date %',v_created_date;
								if (v_count <= 2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
																 or v_created_date is null )then
									insert into labfih.labfih_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	  
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
                                         "subject": "Email Verification - FIH Family Account",
										 "otp_duration": "300"}';

								elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

									delete from labfih.labfih_otp_details where user_guid = v_user_guid and
									mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
                                    
									insert into labfih.labfih_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
                                         "subject": "Email Verification - FIH Family Account",
										 "otp_duration": "300"}';
								else
										p_data	:= '{"status": "2",
													"message": "Too many requests for OTP"
													}';
								end if;		
							else
										 p_data := '{"status": "0",
										"message": "Previous OTP is still valid"}';
							end if;

			end if;	
            
			else
                p_data	:= '{"status": "2",
				"message": "Try after 24 hours to generate a new OTP"
				}';
                end if;
                

							
			elseif v_opt = 3 then
			
			
				select max(created_date) into v_created_date from labfih.labfih_otp_details
				where user_guid = v_user_guid -- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type ;
				
				select coalesce(failed_attempt,0) into v_failed_attempt from labfih.labfih_otp_details
				where user_guid = v_user_guid and created_date = v_created_date-- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type;
			
				select count(1) into v_count  from labfih.labfih_otp_details
				where user_guid = v_user_guid 
				and type = v_type and current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval ;	
				
				
				
				
				
				if v_count is null or v_count = 0 then 
				
					insert into labfih.labfih_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	  
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '300 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
					p_data	:= '{"status": "1",
								"message": "OTP sent successfully",
								"otp_duration": "300"}';
								
				elseif v_count >= 1 and v_failed_attempt < 3 then
				
					update labfih.labfih_otp_details
					set mobile_no = coalesce( v_mobile_no,v_email_id),
						otp = v_otp,
						is_verified = 0,
						created_date = current_timestamp at time zone 'utc',
						expiry_date = current_timestamp at time zone 'utc' + '300 seconds'::interval			
				   where user_guid = v_user_guid and type = v_type;
				   
				   
						p_data	:= '{"status": "1",
								"message": "OTP sent successfully",
								"otp_duration": "300"}';
				   
				 elseif  v_failed_attempt >= 3 then 
				 
				 	p_data	:= '{"status": "2",
										"message": "Try after 24 hours to generate a new OTP"}';	
				   
			     end if;  
				   
				
				
			end if;
			
		select first_name into v_user_full_name  from labfih.labfih_web_user
		where user_guid = v_user_guid;
		
	
		p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true);
			
	else
	
	select client_id into v_client_id from labfih.labfih_web_user where email_id = v_email_id ;
	
	if(v_client_id = 2) then
		p_data := '{"status": "0",
						"message": "Log in using Facebook social login; custom email was not used to create your account."}';
	elsif(v_client_id = 4) then
		p_data := '{"status": "0",
						"message": "Log in using Google social login; custom email was not used to create your account."}';
	else
			p_data	:= '{"status": "0",
						"message": "Already Verified"}';
	end if;	
	
	end if;
    
--     insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'output-generate_otp','logs',uuid_generate_v4(),p_data,current_timestamp,'labfih','logs');     
	
	
	
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true);
	
end;
$$;


--
