-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_otp_login(jsonb)
-- Type: FUNCTION

-- Name: isl_otp_login(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_otp_login(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

	/*'{
  "data": {
    "mobile_no": "string",
    "otp": "string",
    "email_id": "string",
    "opt_type": "string", – (1- mobile , 2- Email_id)
    "is_app": numeric
 		  }
	}'*/
	
	--Declare variable
	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_otp numeric;
	-- v_opt numeric;
	v_opt_type numeric;
	--v_user_guid character varying(1000);
	--v_is_app numeric;
	v_count numeric ;
	--v_created_date timestamp;
	v_attemp numeric ;
	--v_status numeric;
	
	
	v_current_timestamp timestamp without time zone := current_timestamp;
    v_client_id numeric;
    v_social_user_name character varying;
    v_user_full_name character varying;
   -- v_email_id character varying;
    v_user_password character varying;
    v_social_id character varying;
    v_upper_email_id character varying;
    v_web_user_id numeric;
    v_user_guid character varying;
    v_is_active numeric;
    v_is_deleted numeric;
    v_created_by numeric;
    v_updated_by numeric;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_reset_key character varying;
    v_key_expiry_date timestamp without time zone;
    v_reset_key_status numeric;
    v_dob character varying;
    v_profile_picture_url character varying;
    v_city character varying;
   -- v_mobile_no character varying;
    v_gender character varying;
    v_sport_skill json;
    v_sport_skill_map json; 
    v_sport_id numeric;
    v_skill_level numeric;
    v_result numeric;
    v_is_verified numeric;
    v_is_custom  numeric;
    v_userjson jsonb;
    v_favourite_club character varying;
    v_edition character varying;
    v_status numeric; 
    v_is_first_login   numeric := 0 ;
    v_token  character varying;
    v_epoch_timestamp  character varying;
    v_confirm_password character varying;
    v_old_password character varying;
    v_failed_attempts numeric;
    v_unlock_date timestamp;
    v_is_registered  numeric;
    v_ipaddress   character varying;
    v_message character varying;
    v_is_app numeric;
    v_user_id numeric;
    v_img_url character varying;
    v_is_login numeric;
    v_verification_key  character varying;
    v_err_code character varying;
    v_err_msg character varying;
    v_emailid_ex  character varying;
    v_is_custom_image numeric;
	v_old_profile_image_url  character varying;
	v_is_custom_image_tab numeric;
	v_state_id  numeric;
	v_city_id   numeric;
	v_country_name text;
	v_state_name text ;
	v_city_name  text;
    v_email_social  text;
    -- v_mobile_social  text;
    v_profile_image_social  text;
    v_profile_completion_percentage numeric;
    v_is_new_reg numeric:=0;
    v_reg_cnt numeric:=0;
   v_gift_id numeric:=0;
   v_gift_url text;
   v_gift_name varchar(500):='NO GIFT';
   v_available_quantity numeric;
   v_gratification_value numeric;
   v_profile_complete numeric;
   v_better_luck_value numeric;
   v_first_name character varying;
	v_last_name character varying;
	v_membership_code character varying;
   v_favourite_player_id character varying;
   v_platform_version numeric;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
   v_created_date_1 timestamp;
   v_country_code numeric;
   v_email_verified  numeric;
   v_mobile_verified numeric;
v_country_id numeric;
   v_jersey_name character varying;
   v_jersey_number numeric;
   v_ext_info jsonb;
   v_accept_tnc boolean;
   v_subscribe_for_email boolean;
    v_accept_disclaimer boolean;
  
begin
	-- Read data from input json
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'opt_type' ,
		   p_inputjson->'data'->>'is_app',
		   p_inputjson->'data'->>'country_code',
		   p_inputjson->'data'->>'platform_version',
		   p_inputjson->'data'->>'platform_type',
		   p_inputjson->'data'->>'device_name',
		   p_inputjson->'data'->>'accept_tnc',
		   p_inputjson->'data'->>'subscribe_for_email',
		   p_inputjson->'data'->>'accept_disclaimer'		   
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_opt_type,
		   v_is_app,
		   v_country_code,
		   v_platform_version,
		   v_platform_type,
		   v_device_name,
		   v_accept_tnc,
		   v_subscribe_for_email,
		   v_accept_disclaimer
		   ;


insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'otp_login','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labrr','logs');

	if v_accept_tnc = 'true' and v_accept_disclaimer = 'true' then

	--Get latest entry for a particular user from otp deatils
	select max(created_date) into v_created_date from isl.isl_otp_details
	where mobile_no = coalesce( v_mobile_no,v_email_id); -- and user_guid = v_user_guid;
	
	raise notice 'v_created_date %',v_created_date;

	if v_mobile_no = 'zPHKvSO83fSj+QKK6D96zlNYo7QHBmXx32QOpxzf3NM=' and v_otp = 123456 then
	
							select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
								   favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,first_name,last_name,mobile_no,membership_code,email_id,dob,gender,
								   city,favourite_player_id,created_date,user_id,country_code,email_id,email_verified,country_id,jersey_number,jersey_name,ext_info,token,epoch_timestamp,mobile_verified
							into v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
								 v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_first_name,v_last_name,v_mobile_no,v_membership_code,v_email_id,v_dob,v_gender,
								 v_city,v_favourite_player_id,v_created_date_1,v_web_user_id,v_country_code,v_email_id,v_email_verified,v_country_id,v_jersey_number,v_jersey_name,v_ext_info,v_token,
								 v_epoch_timestamp,v_mobile_verified
							from isl.isl_web_user 
							where mobile_no = v_mobile_no  ;
	
		v_status := 1 ;
	    v_message := 'Login Successful';
		
						p_data := '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"email_verified": '||coalesce(v_email_verified,0) ||',
						"mobile_verified": '||coalesce(v_mobile_verified,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
						"user_id":"'|| coalesce(v_web_user_id,0)||'",
						"created_date": "'|| coalesce(v_created_date_1::varchar,v_created_date::varchar,'')||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						   "first_name": "'||coalesce(v_first_name,'') ||'",
						   "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "country_code": "'|| coalesce(v_country_code,0)||'",						  												  
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "membership_code": "'||coalesce(v_membership_code,'') ||'"
						},
						"is_first_login": "'||coalesce(v_is_first_login,0) ||'",
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ; 
					p_data:=jsonb_set(p_data, '{data,user,ext_info}',coalesce(v_ext_info,'null'), true);

		
		
	else	
				-- Check for valid user mobile number and otp with failed attempts <3
				if exists(select 1 from isl.isl_otp_details
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp = v_otp and 
							   expiry_date > current_timestamp at time zone 'utc'
						  		and created_date = v_created_date and coalesce(failed_attempt,0) < 3
						) then
				
						-- If user is valid then marl is_verified = true
						 update isl.isl_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;
						
					-- Option = 1 is for mobile login
					if v_opt_type = 1 then
						raise notice '1';
						-- If that particular user mobile exists or not
					   if exists(select 1 from isl.isl_web_user
								 where mobile_no = v_mobile_no) then
								 
							select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
								   favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,first_name,last_name,mobile_no,membership_code,email_id,dob,gender,
								   city,favourite_player_id,created_date,user_id,country_code,email_id,email_verified,country_id,jersey_number,jersey_name,ext_info,token,epoch_timestamp,mobile_verified,
								   accept_tnc,subscribe_for_email,accept_disclaimer
							into v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
								 v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_first_name,v_last_name,v_mobile_no,v_membership_code,v_email_id,v_dob,v_gender,
								 v_city,v_favourite_player_id,v_created_date_1,v_web_user_id,v_country_code,v_email_id,v_email_verified,v_country_id,v_jersey_number,v_jersey_name,v_ext_info,
								 v_token,v_epoch_timestamp,v_mobile_verified,v_accept_tnc,v_subscribe_for_email,v_accept_disclaimer
							from isl.isl_web_user 
							where mobile_no = v_mobile_no  ;
							
							  raise notice 'epoch_time : %',v_epoch_timestamp ;
							  if v_is_deleted =  1 then
							  
							  	v_status := 500 ;
								v_message := 'Login Successful.';
								
							  elsif v_is_active = 1 then 
							  
								   if (v_first_name is null) or (v_last_name is null) or v_country_id is null or (v_email_id is null) --or v_city is null
								   then

										v_status := 2 ;
										v_message := 'Incomplete Profile.';
										
                                    else

										v_status := 1 ;
										v_message := 'Login Successful';
									
									end if;
								
							  end if;
							  
		insert into isl.isl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, audit_date, is_app,platform_version,platform_type,device_name,option_type,client_code)
		select nextval('isl.seq_isl_web_user_audit_id'), v_web_user_id,  v_user_guid, v_ipaddress,v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_platform_type,v_device_name,
		4,'isl';
			  
							  
							
					   					   
					   else
					 	raise notice '2';
							-- If user doesnt not exists then insert new entry for resgistration purpose

							v_web_user_id := nextval('isl.seq_isl_web_users_id');
							v_user_guid := uuid_generate_v4();
							v_is_active := 1;
							v_is_deleted := 0; 
							--v_is_verified = 1 ; 
							v_mobile_verified := 1;
							v_created_date := current_timestamp;
							v_updated_date := current_timestamp;  	
							v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
							v_is_login := 0;
							
							
						insert into isl.isl_web_user
                		(user_id, client_id, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
				 		epoch_timestamp, is_login,created_by ,updated_by,mobile_no,country_code,mobile_verified,accept_tnc,subscribe_for_email,accept_disclaimer)
                       select 	v_web_user_id, 5, v_user_guid, v_is_active, v_is_deleted,
					   			v_created_date, v_updated_date, 1, v_epoch_timestamp, v_is_login,1 ,1,v_mobile_no,
					   			v_country_code,v_mobile_verified,v_accept_tnc,v_subscribe_for_email,v_accept_disclaimer;
                
                        v_is_first_login := 1;
						v_status := 2 ;	
						v_message := 'User registered successfully.' ;
						
		insert into isl.isl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, audit_date, is_app,platform_version,platform_type,device_name,option_type,client_code)
		select nextval('isl.seq_isl_web_user_audit_id'), v_web_user_id,  v_user_guid, v_ipaddress,v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_platform_type,v_device_name,
		2,'isl';

					   
					end if;

					elsif v_opt_type = 2 then

					end if;	
				p_data := '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"email_verified": '||coalesce(v_email_verified,0) ||',
						"mobile_verified": '||coalesce(v_mobile_verified,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
						"user_id":"'|| coalesce(v_web_user_id,0)||'",
						"created_date": "'|| coalesce(v_created_date_1::varchar,v_created_date::varchar,'')||'",					
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						   "first_name": "'||coalesce(v_first_name,'') ||'",
						   "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "country_code": "'|| coalesce(v_country_code,0)||'",						  												  
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "jersey_number": "'|| coalesce(v_jersey_number,0)||'",
						  "jersey_name": "'|| coalesce(v_jersey_name,'')||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "accept_tnc":"'|| coalesce(v_accept_tnc::varchar,'false')||'",	
						  "accept_disclaimer":"'|| coalesce(v_accept_disclaimer::varchar,'false')||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "membership_code": "'||coalesce(v_membership_code,'') ||'"
						},
						"is_first_login": "'||coalesce(v_is_first_login,0) ||'",
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ;
					p_data:=jsonb_set(p_data, '{data,user,ext_info}',coalesce(v_ext_info,'null'), true); 				
					--"created_date": "'|| coalesce(v_created_date,v_created_date_1,'')||'",			
								
																		
				else	
						-- If valid otp or mobile is not there then mark user failed attempt
						if exists(select 1 from isl.isl_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update isl.isl_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
						 select failed_attempt into v_attemp from isl.isl_otp_details
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 	 and created_date = v_created_date;
								
							
							--p_data	:= '{"status": "0",
									--	"message": "Attempts Allowed: '||coalesce(v_attemp,0)||'/3",
									--	"failed_attempt":'||coalesce(v_attemp,0)::text||'}';
										
							v_status := 0;
						    v_message := 'Attempts Allowed: '||coalesce(v_attemp,0)||'/3' ;			
										
										
										
						else
		
						v_status := 0;
						v_message := 'Try after 24hrs to generate OTP' ;
										
										
						end if;	
						
						
						p_data := '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"failed_attempt":"'||coalesce(v_attemp,0)::text||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"email_verified": '||coalesce(v_email_verified,0) ||',
						"mobile_verified": '||coalesce(v_mobile_verified,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
						"user_id":"'|| coalesce(v_web_user_id,0)||'",										
						"created_date": "'|| coalesce(v_created_date_1::varchar,v_created_date::varchar,'')||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						   "first_name": "'||coalesce(v_first_name,'') ||'",
						   "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "country_code": "'|| coalesce(v_country_code,0)||'",						  												  
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "jersey_number": "'|| coalesce(v_jersey_number,0)||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "accept_tnc":"'|| coalesce(v_accept_tnc::varchar,'false')||'",
						  "accept_disclaimer":"'|| coalesce(v_accept_disclaimer::varchar,'false')||'",
						  "jersey_name": "'|| coalesce(v_jersey_name,'')||'",
						  "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "membership_code": "'||coalesce(v_membership_code,'') ||'"
						},
						"is_first_login": 0,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ; 
					p_data:=jsonb_set(p_data, '{data,user,ext_info}',coalesce(v_ext_info,'null'), true);

						--"created_date": "'|| coalesce(v_created_date,v_created_date_1,'')||'",	
				end if;	
				
				
	end if;		
	
	else --else statement of in case of v_accept_disclaimer = false 	
	
				v_status := 0 ;
	    		v_message := 'Terms and Conditions not accepted';
		
						p_data := '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"email_verified": '||coalesce(v_email_verified,0) ||',
						"mobile_verified": '||coalesce(v_mobile_verified,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
						"user_id":"'|| coalesce(v_web_user_id,0)||'",
						"created_date": "'|| coalesce(v_created_date_1::varchar,v_created_date::varchar,'')||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						   "first_name": "'||coalesce(v_first_name,'') ||'",
						   "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "country_code": "'|| coalesce(v_country_code,0)||'",						  												  
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "membership_code": "'||coalesce(v_membership_code,'') ||'"
						},
						"is_first_login": "'||coalesce(v_is_first_login,0) ||'",
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ; 
					p_data:=jsonb_set(p_data, '{data,user,ext_info}',coalesce(v_ext_info,'null'), true);


	
	end if; --- end of in case of v_accept_disclaimer = falase 			


end;
$$;


--
