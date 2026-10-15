-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_verified_otp_04032024(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_verified_otp_04032024(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_verified_otp_04032024(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_user_email_count numeric;
	v_email_verified numeric;
    v_mobile_verified numeric;
    v_old_user_guid character varying;
	v_old_first_name character varying;
	v_old_last_name character varying;
	v_old_user_full_name character varying;
	v_old_dob character varying;
	v_old_gender character varying;
	v_old_pincode character varying;
	v_old_city character varying;
	v_old_country_id numeric;
	v_old_country character varying;
	v_old_jersey_number numeric;
	v_old_jersey_name character varying;
	v_old_favourite_player_id numeric;
    v_first_name character varying;
	v_last_name character varying;
	v_client_id numeric;
	v_social_user_image character varying;
	v_user_full_name character varying;
	v_is_custom_image numeric;
	v_edition character varying;
	v_favourite_club character varying;
	v_attemp numeric;
	v_attempts character varying;
	v_web_user_id NUMERIC;
	v_message character varying;
	v_user_guid_type numeric;
	v_new_user_guid character varying;
begin
	select p_inputjson->'data'->>'mobile_no',
	       p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'		   
	into  v_mobile_no,
		  v_otp,
		  v_email_id,
		  v_opt,
		  v_type,
		  v_user_guid,
		  v_is_app;
		  
		  
-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'verify_otp','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labgt01_v1','logs');

	if 	v_opt = 1 then	
	

	
	select max(created_date) into v_created_date from labgt01_v1.labgt01_v1_otp_details
	where mobile_no =v_mobile_no
	and type = v_type;
   
   	raise notice'v_created_date:%',v_created_date;
   
				if exists(select 1 from labgt01_v1.labgt01_v1_otp_details
						 where mobile_no =v_mobile_no and otp=v_otp and 
						       expiry_date > current_timestamp at time zone 'utc'
						       and created_date = v_created_date and coalesce(failed_attempt,0) < 3
						) then
	--raise notice'v_created_date:%',v_created_date;

						 update labgt01_v1.labgt01_v1_otp_details
						 set is_verified= 1
						 where mobile_no =v_mobile_no
						 and otp=v_otp and created_date = v_created_date;

						p_data	:= '{"status": "1",
									"message": "Success"}';

				else	
						if exists(select 1 from labgt01_v1.labgt01_v1_otp_details 
								  where mobile_no =v_mobile_no 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labgt01_v1.labgt01_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = v_mobile_no
							 and created_date = v_created_date;
						
							
							p_data	:= '{"status": "0",
									"message": "Failed"}';
										
										
						else

									
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';		
						end if;			
									
				end if;	
				
		elseif v_opt = 2 and v_user_guid is not null then

			select max(created_date) into v_created_date from labgt01_v1.labgt01_v1_otp_details
			where mobile_no = v_email_id
			and type = v_type;
   			raise notice 'v_created_date %',v_created_date;
			
		----------------------------------if cond for status -300 --------------------------------------------
		
		if exists(select 1 from labgt01_v1.labgt01_v1_otp_details
						 where 	mobile_no = v_email_id 
				 		and otp = v_otp 
				 		and expiry_date > current_timestamp at time zone 'utc'
		       			and created_date = v_created_date 
						and coalesce(failed_attempt,0) < 3
						)  and 
				 not exists(select 1 from labgt01_v1.labgt01_v1_web_user where email_id=v_email_id)
				and exists(select 1 from labgt01_v1.labgt01_v1_web_user_old_data where email_id=v_email_id) 
				
			then 
			raise notice 'hi';
						
				select user_guid,first_name,last_name,user_full_name,dob,gender,pincode,city,country_id,
				jersey_number,jersey_name,favourite_player_id
				from labgt01_v1.labgt01_v1_web_user_old_data
				where email_id=v_email_id
				order by updated_date desc limit 1 
				into v_old_user_guid,v_old_first_name,v_old_last_name,v_old_user_full_name,v_old_dob,
				v_old_gender,v_old_pincode,v_old_city,v_old_country_id,v_old_jersey_number,v_old_jersey_name,
				v_old_favourite_player_id;
				
				select name into v_old_country from waf_master.waf_countries where country_id=v_old_country_id;
				
				
				--In v_user_guid_type 1 if user_guid is present in old web user table but not in current web user table (Here user_guid is old table user guid and new user guid is in ref user_guid)
				--In v_user_guid_type 2 if user_guid is present in old web user table as well as in current web user table (Here user_guid is new user guid  and old table user guid is in ref user_guid)
				
			if not exists (select 1 from labgt01_v1.labgt01_v1_web_user where user_guid=v_old_user_guid) then
			
			raise notice 'v_old_user_guid %',v_old_user_guid;
			raise notice 'v_email_id %',v_email_id;
			v_user_guid_type:=1;
			
				update labgt01_v1.labgt01_v1_web_user
				set user_guid=v_old_user_guid,
				email_id=v_email_id,
				upper_email_id=v_email_id,
				email_verified=1,
				ref_user_guid=v_user_guid,
				first_name=v_old_first_name,
				last_name=v_old_last_name,
				user_full_name=v_old_user_full_name,
				dob=v_old_dob,
				gender=v_old_gender,
				pincode=v_old_pincode,
				city=v_old_city,
				country=v_old_country,
				country_id=v_old_country_id,
				jersey_number=v_old_jersey_number,
				jersey_name=v_old_jersey_name,
				favourite_player_id=v_old_favourite_player_id,
				user_guid_type=v_user_guid_type
				where user_guid=v_user_guid;
				
				
				
				select first_name,last_name,client_id,profile_picture_url,user_full_name,is_custom_image,user_id
				into v_first_name,v_last_name,v_client_id,v_social_user_image,v_user_full_name,v_is_custom_image,v_web_user_id
				from labgt01_v1.labgt01_v1_web_user
				where user_guid=v_old_user_guid;
				
				
				
				ELSE
				
				v_user_guid_type:=2;
				v_new_user_guid:=uuid_generate_v4();				
				
				update labgt01_v1.labgt01_v1_web_user
				set user_guid=v_new_user_guid,
				ref_user_guid=v_old_user_guid,
				user_guid_type=2
				where user_guid=v_old_user_guid;
				
				update labgt01_v1.labgt01_v1_web_user
				set user_guid=v_old_user_guid,
				email_id=v_email_id,
				upper_email_id=v_email_id,
				email_verified=1,
				ref_user_guid=v_user_guid,
				first_name=v_old_first_name,
				last_name=v_old_last_name,
				user_full_name=v_old_user_full_name,
				dob=v_old_dob,
				gender=v_old_gender,
				pincode=v_old_pincode,
				city=v_old_city,
				country=v_old_country,
				country_id=v_old_country_id,
				jersey_number=v_old_jersey_number,
				jersey_name=v_old_jersey_name,
				favourite_player_id=v_old_favourite_player_id,
				user_guid_type=1
				where user_guid=v_user_guid;
				
				
				
				select first_name,last_name,client_id,profile_picture_url,user_full_name,is_custom_image,user_id
				into v_first_name,v_last_name,v_client_id,v_social_user_image,v_user_full_name,v_is_custom_image,v_web_user_id
				from labgt01_v1.labgt01_v1_web_user
				where user_guid=v_old_user_guid;
				
				end if;
							
-- 			p_data:= '{
-- 					  "data": {
-- 						"user_guid": "'||coalesce(v_user_guid,'')||'",
-- 						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
-- 						"token": "",
-- 						"epoch_timestamp": "",
-- 						"failed_attempt":"'||coalesce(v_attemp,0)::text||'",
-- 						"email_id": "'|| coalesce(v_email_id,'') ||'",
-- 						"status": "-300",
-- 						"message": "Failed",
-- 						"attempts": "'|| coalesce(v_attempts,'')||'",
-- 						"max_attempts": "5",						
-- 						"platform_version": "",
-- 						"device_name": "",
-- 						"platform_type": "",
-- 						"option_type": "",
-- 						"user_id":"'|| coalesce(v_web_user_id,0)||'",				
-- 						"subscribe_for_email":"",
-- 						"mobile_verified": "",
-- 						"email_verified": "",
-- 						"created_date": "",
-- 						"client_id": "'|| coalesce(v_client_id,0) ||'" ,
-- 						"user": {
-- 						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
-- 						  "name": "'||coalesce(v_user_full_name,'') ||'",
-- 						   "first_name": "'||coalesce(v_first_name,'') ||'",
-- 						   "last_name": "'||coalesce(v_last_name,'') ||'",
-- 						  "social_user_name": "",
-- 						  "dob": "",
-- 						  "gender": "",
-- 						  "city": "",
--                           "city_id": "",
-- 					      "state_name": "",
--                           "state_id": "",
-- 					      "country_name": "",
--                           "country_id": "",
-- 						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
-- 						  "country_code": "",						  												  
-- 						  "favourite_player_id": "",
-- 						  "edition": "'|| coalesce(v_edition,'') ||'",
-- 						  "jersey_number": "",
-- 						  "jersey_name": "",
--                           "social_user_image": "'|| coalesce(v_social_user_image,'') ||'" ,
-- 						  "membership_code": "",
-- 						  "favourite_player_name":"",
-- 						  "pincode":"",
-- 						  "accept_disclaimer":"",
-- 						   "accept_tnc":""
-- 						},
-- 						"is_first_login": "0" ,
-- 						"is_app": "0" ,
-- 						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
-- 						"old_profile_img_url" : ""						
-- 					  }
-- 					}';

					p_data:= '{
					  "data": {
						"user_guid": "'||coalesce(v_old_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_old_user_guid,'')||'",
						"failed_attempt":"'||coalesce(v_attemp,0)::text||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": "-300",
						"message": "Email Id verified sucessfully.",
						"attempts": "'|| coalesce(v_attempts,'')||'",
						"max_attempts": "3",
						"user_id":"'|| coalesce(v_web_user_id,0)||'",
						"client_id": "'|| coalesce(v_client_id,0) ||'" ,
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						   "first_name": "'||coalesce(v_first_name,'') ||'",
						   "last_name": "'||coalesce(v_last_name,'') ||'",
						   "dob": "'|| coalesce(v_old_dob::varchar,'') ||'",
						   "gender": "'|| coalesce(v_old_gender,'') ||'",
						   "city": "'|| coalesce(v_old_city,'')||'",
						   "pincode": "'||coalesce(v_old_pincode,'') ||'",
						   "country_name": "'|| coalesce(v_old_country,'')||'",
                          "country_id": "'|| coalesce(v_old_country_id::varchar,'')||'",
						  "jersey_number": "'||coalesce(v_old_jersey_number,0) ||'",
						  "jersey_name": "'||coalesce(v_old_jersey_name,'') ||'",
						  "favourite_player_id": "'||coalesce(v_old_favourite_player_id::varchar,'') ||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_social_user_image,'') ||'"
						},
						"is_first_login": "0" ,
						"is_app": "0" ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" 					
					  }
					}';

			
		else 	
		
   			if exists	(select 1 from labgt01_v1.labgt01_v1_otp_details
								 where 	mobile_no = v_email_id 
								 		and otp = v_otp 
								 		and expiry_date > current_timestamp at time zone 'utc'
						       			and created_date = v_created_date 
										and coalesce(failed_attempt,0) < 3
								) then
				raise notice '1';		
					 update labgt01_v1.labgt01_v1_otp_details
					 set is_verified= 1
					 where mobile_no = v_email_id 
					 and otp=v_otp and created_date = v_created_date;

					--Check for other users having same email id with mobile verified should be 1 
					select 	count(1)  from labgt01_v1.labgt01_v1_web_user
					into 	v_user_email_count
					where 	email_id = v_email_id 
					and 	mobile_verified <> 0;

					--If there are other verified user with same email
					if v_user_email_count > 0 then
						--raise notice 'Cannot verify email.Email already exists. ';
						p_data	:= '{"status" : "0",
									"message" : "Cannot verify email Id .Email Id already exists."}';
					else
						--- Verify email for current user and set other users with same email = NULL
						select email_verified,mobile_verified 
						into v_email_verified,v_mobile_verified 
						from labgt01_v1.labgt01_v1_web_user
						where user_guid = v_user_guid and is_active = 1 and  is_deleted = 0;
						raise notice 'v_email_verified %',v_email_verified;

--If there is two account is present in web user and current account mobile is verified and 
--email is not verified and then existing account email id and email verified will be set is null 
--and current account email id will verified and updated with the existing email id

						if (v_email_verified is null or v_email_verified =0) and v_mobile_verified<>0 then

							update 	labgt01_v1.labgt01_v1_web_user
							set		email_id = NULL,
									upper_email_id = NULL,
									email_verified = 0
							where 	email_id = v_email_id;

							update 	labgt01_v1.labgt01_v1_web_user
							set		email_id = v_email_id,
									upper_email_id = v_email_id,
									email_verified = 1
							where 	user_guid = v_user_guid 
									and is_active = 1 and  is_deleted = 0;

							--raise notice 'Email verified sucessfully.';
							p_data	:= '{"status" : "1",
									"message" : "Email Id verified sucessfully."}';
		
						else 
							
							p_data	:= '{"status" : "0",
									"message" : "Email Id already verified."}';
						end if;
					end if;
					else
						if exists(select 1 from labgt01_v1.labgt01_v1_otp_details 
								  where mobile_no =v_email_id
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labgt01_v1.labgt01_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = v_email_id
							 and created_date = v_created_date;
						
						
						 select failed_attempt into v_attemp from labgt01_v1.labgt01_v1_otp_details
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 	 and created_date = v_created_date;
							 
							 v_attempts := 'Attempts ' || coalesce(v_attemp,0)||'/3';
							 v_message := 'Attempts ' || coalesce(v_attemp,0)||'/3';		
							
							p_data	:= '{"status": "0",
									"message": "'|| coalesce(v_message,'')||'",
									"attempts": "'|| coalesce(v_attempts,'')||'"}';
										
										
						else

									
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';		
						end if;		
				end if;
				
		end if; -- status -300		
				
		elseif 	v_opt = 3  then
				   
		    select max(created_date) into v_created_date from labgt01_v1.labgt01_v1_otp_details
			where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid and type = v_type ;
			
			if exists(select 1 from labgt01_v1.labgt01_v1_otp_details
					  where mobile_no =coalesce( v_mobile_no,v_email_id) 
					  and otp=v_otp
					  and expiry_date > current_timestamp at time zone 'utc'
					  and created_date = v_created_date and user_guid = v_user_guid
					  and type = v_type and coalesce(failed_attempt,0) < 3
						) then

						 update labgt01_v1.labgt01_v1_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type;
/*						 
						 if exists(select 1 from labgt01_v1.labgt01_v1_web_user where email_id=v_email_id and (is_verified=0 or is_verified is null))then
						 				--incase 
						 				 update labgt01_v1.labgt01_v1_web_user
										 set email_id=null
										 where email_id=v_email_id;
						 
								         update labgt01_v1.labgt01_v1_web_user
										 set email_id=v_email_id,is_verified=1
										 where user_guid=v_user_guid;
										 
						ELSE
						
										 update labgt01_v1.labgt01_v1_web_user
										 set email_id=v_email_id,is_verified=1
										 where user_guid=v_user_guid;
						end if;				 
*/
						p_data	:= '{"status": "1",
									"message": "Success"}';

					else
						
						if exists(select 1 from labgt01_v1.labgt01_v1_otp_details 
								  where mobile_no =coalesce( v_mobile_no,v_email_id) 
								  and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labgt01_v1.labgt01_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;						
								
							p_data	:= '{"status": "0",
										"message": "Failed"}';			
						else
							
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';
							
						end if;
								
					end if;	

		end if;	
	
end;

$$;


--
