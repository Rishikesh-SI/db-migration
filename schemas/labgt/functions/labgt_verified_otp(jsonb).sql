-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_verified_otp(jsonb)
-- Type: FUNCTION

-- Name: labgt_verified_otp(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_verified_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_old_favourite_player_id character varying;
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
	v_current_timestamp timestamp without time zone := current_timestamp;
	v_ipaddress   character varying;
	v_is_app numeric;
	v_platform_version character varying;
    v_device_name character varying;
    v_platform_type numeric;
	v_user_id numeric;
	v_state_name text ;
	v_membership_code character varying;
	v_accept_disclaimer boolean;
	v_accept_tnc boolean;
	v_token character varying;
	v_epoch_timestamp character varying;
	v_referal_user_guid character varying;
	v_is_referred numeric;
	v_internal_referral_code character varying;
	v_subscribe_for_email boolean;
	v_profile_picture_url character varying;
	v_favourite_player_name character varying;
	v_state_id numeric;
	v_city_id numeric;
	v_pass_type numeric;
    v_mobile_with_countrycode character varying;
	v_country_code numeric;
begin
	select p_inputjson->'data'->>'mobile_no',
           p_inputjson->'data'->>'mobile_with_countrycode',
	       p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'opt',
		   p_inputjson->'data'->>'type',
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app',
		   p_inputjson->'data'->>'country_code'
		   
	into  v_mobile_no,
          v_mobile_with_countrycode,
		  v_otp,
		  v_email_id,
		  v_opt,
		  v_type,
		  v_user_guid,
		  v_is_app,
		  v_country_code;
		  
		  
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labgt-inputverify_otp','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labgt','logs');

	if (v_user_guid is not null) then
	select user_id into v_user_id from labgt.labgt_web_user where user_guid=v_user_guid;
	end if;
raise notice'1';
	if 	v_opt = 1 then	
	
raise notice'2';
	raise notice'v_mobile_with_countrycode:%',v_mobile_with_countrycode;
	select max(created_date) into v_created_date from labgt.labgt_otp_details
	where mobile_no =v_mobile_no
	and type = v_type and country_code=v_country_code;
   
   	raise notice'v_created_date1234:%',v_created_date;
   
				if exists(select 1 from labgt.labgt_otp_details
						 where mobile_no = v_mobile_no and otp=v_otp and country_code=v_country_code 
						       and expiry_date > current_timestamp at time zone 'utc'
						       and created_date = v_created_date and coalesce(failed_attempt,0) < 3
						) then
	--raise notice'v_created_date:%',v_created_date;

						 update labgt.labgt_otp_details
						 set is_verified= 1
						 where mobile_no =v_mobile_no
						 and otp=v_otp and created_date = v_created_date 
						 and country_code=v_country_code;

						p_data	:= '{"status": "1",
									"message": "Success"}';

				else	
						if exists(select 1 from labgt.labgt_otp_details 
								  where mobile_no =v_mobile_no 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3 
						 and country_code=v_country_code) then
						
							 update labgt.labgt_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = v_mobile_no
							 and created_date = v_created_date 
							 and country_code=v_country_code;
						
							
							p_data	:= '{"status": "0",
									"message": "Failed"}';
										
										
						else

									
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';		
						end if;			
									
				end if;	
				
		elseif v_opt = 2 and v_user_guid is not null then
		
			

			select max(created_date) into v_created_date from labgt.labgt_otp_details
			where mobile_no = v_email_id
			and type = v_type;
   			raise notice 'v_created_date %',v_created_date;
			
		----------------------------------if cond for status -300 --------------------------------------------
		
		if exists(select 1 from labgt.labgt_otp_details
						 where 	mobile_no = v_email_id 
				 		and otp = v_otp 
				 		and expiry_date > current_timestamp at time zone 'utc'
		       			and created_date = v_created_date 
						and coalesce(failed_attempt,0) < 3
						)  and 
				 not exists(select 1 from labgt.labgt_web_user where email_id=v_email_id)
				and exists(select 1 from labgt.labgt_web_user_old_data where email_id=v_email_id) 
				
			then 
			raise notice 'hi';
						
				select user_guid,first_name,last_name,user_full_name,dob,gender,pincode,city,country_id,
				jersey_number,jersey_name,favourite_player_id,token,epoch_timestamp,referal_user_guid,is_referred,internal_referral_code,mobile_no,edition,favourite_club,
				subscribe_for_email,profile_picture_url,is_custom_image,country_code
				from labgt.labgt_web_user_old_data
				where email_id=v_email_id
				order by updated_date desc limit 1 
				into v_old_user_guid,v_old_first_name,v_old_last_name,v_old_user_full_name,v_old_dob,
				v_old_gender,v_old_pincode,v_old_city,v_old_country_id,v_old_jersey_number,v_old_jersey_name,
				v_old_favourite_player_id,v_token,v_epoch_timestamp,
				v_referal_user_guid,v_is_referred,v_internal_referral_code,v_mobile_no,v_edition,v_favourite_club,
				v_subscribe_for_email,v_profile_picture_url,v_is_custom_image,v_country_code;
				
 						select em.entity_name into v_favourite_player_name
 						from labgt.labgt_entity_role_map erm 
 						join labgt.labgt_entity_master em using (entity_master_id)
 						where source_object_id = COALESCE(v_old_favourite_player_id::text,'0');
				
				select membership_code,accept_disclaimer,accept_tnc,mobile_verified,
				(case when first_name is not null and last_name is not null then 1 else 2 end)
				into v_membership_code,v_accept_disclaimer,v_accept_tnc,v_mobile_verified,v_pass_type
				from labgt.labgt_web_user
				where user_guid=v_user_guid;
				
				select name into v_old_country from waf_master.waf_countries where country_id=v_old_country_id;
				
				
				--In v_user_guid_type 1 if user_guid is present in old web user table but not in current web user table (Here user_guid is old table user guid and new user guid is in ref user_guid)
				--In v_user_guid_type 2 if user_guid is present in old web user table as well as in current web user table (Here user_guid is new user guid  and old table user guid is in ref user_guid)
				
		if not exists (select 1 from labgt.labgt_web_user where user_guid=v_old_user_guid) then
			
			raise notice 'v_old_user_guid %',v_old_user_guid;
			raise notice 'v_email_id %',v_email_id;
			v_user_guid_type:=1;
			
				update labgt.labgt_web_user
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
				
				
				
				select user_guid,first_name,last_name,user_full_name,dob,gender,pincode,city,country_id,
				jersey_number,jersey_name,favourite_player_id,token,epoch_timestamp,mobile_verified,referal_user_guid,is_referred,internal_referral_code,mobile_no,edition,favourite_club,
				subscribe_for_email,profile_picture_url,is_custom_image,membership_code,accept_disclaimer,accept_tnc,country_code,
				(case when first_name is not null and last_name is not null then 1 else 2 end)
				from labgt.labgt_web_user
				where user_guid=v_old_user_guid 
				into v_old_user_guid,v_old_first_name,v_old_last_name,v_old_user_full_name,v_old_dob,
				v_old_gender,v_old_pincode,v_old_city,v_old_country_id,v_old_jersey_number,v_old_jersey_name,
				v_old_favourite_player_id,v_token,v_epoch_timestamp,v_mobile_verified,
				v_referal_user_guid,v_is_referred,v_internal_referral_code,v_mobile_no,v_edition,v_favourite_club,
				v_subscribe_for_email,v_profile_picture_url,v_is_custom_image,v_membership_code,v_accept_disclaimer,v_accept_tnc,v_country_code,v_pass_type;
				
				ELSE
				
				v_user_guid_type:=2;
				v_new_user_guid:=uuid_generate_v4();				
				
				update labgt.labgt_web_user
				set user_guid=v_new_user_guid,
				ref_user_guid=v_old_user_guid,
				user_guid_type=2
				where user_guid=v_old_user_guid;
				
				update labgt.labgt_web_user
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
				
				
				
				select user_guid,first_name,last_name,user_full_name,dob,gender,pincode,city,country_id,
				jersey_number,jersey_name,favourite_player_id,token,epoch_timestamp,mobile_verified,referal_user_guid,is_referred,internal_referral_code,mobile_no,edition,favourite_club,
				subscribe_for_email,profile_picture_url,is_custom_image,membership_code,accept_disclaimer,accept_tnc,country_code,
				(case when first_name is not null and last_name is not null then 1 else 2 end)
				from labgt.labgt_web_user
				where user_guid=v_old_user_guid 
				into v_old_user_guid,v_old_first_name,v_old_last_name,v_old_user_full_name,v_old_dob,
				v_old_gender,v_old_pincode,v_old_city,v_old_country_id,v_old_jersey_number,v_old_jersey_name,
				v_old_favourite_player_id,v_token,v_epoch_timestamp,v_mobile_verified,
				v_referal_user_guid,v_is_referred,v_internal_referral_code,v_mobile_no,v_edition,v_favourite_club,
				v_subscribe_for_email,v_profile_picture_url,v_is_custom_image,v_membership_code,v_accept_disclaimer,v_accept_tnc,v_country_code,v_pass_type;
				
				end if;
				

					p_data:= '{
					  "data": {
						"user_guid": "'||coalesce(v_old_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_old_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						 "user_id": "'|| coalesce(v_user_id,0) ||'" ,
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": "-300",
						"message": "Email Id verified sucessfully.",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"mobile_verified": "'|| coalesce(v_mobile_verified,0)||'",
						"email_verified": "1",
						"option_type": "23",
						"updated_date": "'|| v_current_timestamp||'",
						"created_date": "'|| v_current_timestamp||'",
						"user": {
						  "referal_user_guid": "'||coalesce(v_referal_user_guid,'') ||'",
						  "is_referred": "'|| coalesce(v_is_referred,0)||'",	
						  "internal_referral_code": "'|| coalesce(v_internal_referral_code,'') ||'" ,
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_old_first_name,'') ||'",
						  "last_name": "'||coalesce(v_old_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_old_user_full_name,'') ||'",
						  "dob": "'|| coalesce(v_old_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_old_gender,'') ||'",
						  "city": "'|| coalesce(v_old_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_old_country,'')||'",
                          "country_id": "'|| coalesce(v_old_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "favourite_player_id": "'||coalesce(v_old_favourite_player_id,'0') ||'",
						  "jersey_name": "'|| coalesce(v_old_jersey_name,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'" ,
						  "jersey_number": "'||coalesce(v_old_jersey_number,0) ||'",
						  "membership_code": "'||coalesce(v_membership_code,'') ||'",
						  "country_code": "'||coalesce(v_country_code,91) ||'",
						  "favourite_player_name":"'|| coalesce(v_favourite_player_name,'')||'",
						  "pincode":"'|| coalesce(v_old_pincode,'')||'",
						  "accept_disclaimer":"'|| coalesce(v_accept_disclaimer,'false')||'",
						   "accept_tnc":"'|| coalesce(v_accept_tnc,'false')||'"
						},
						"is_first_login": 0,
						"is_app": 0 ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "",
						"pass_type":"'|| coalesce(v_pass_type,'0') ||'"

					  }
					}';
					
					

			
		else 	
		
   			if exists	(select 1 from labgt.labgt_otp_details
								 where 	mobile_no = v_email_id 
								 		and otp = v_otp 
								 		and expiry_date > current_timestamp at time zone 'utc'
						       			and created_date = v_created_date 
										and coalesce(failed_attempt,0) < 3
								) then
				raise notice '1';		
				
				select user_guid,first_name,last_name,user_full_name,dob,gender,pincode,city,country_id,
				jersey_number,jersey_name,favourite_player_id,token,epoch_timestamp,mobile_verified,referal_user_guid,is_referred,internal_referral_code,mobile_no,edition,favourite_club,
				subscribe_for_email,profile_picture_url,is_custom_image,membership_code,accept_disclaimer,accept_tnc,country_code,
				(case when first_name is not null and last_name is not null then 1 else 2 end)
				from labgt.labgt_web_user
				where user_guid=v_user_guid 
				into v_old_user_guid,v_old_first_name,v_old_last_name,v_old_user_full_name,v_old_dob,
				v_old_gender,v_old_pincode,v_old_city,v_old_country_id,v_old_jersey_number,v_old_jersey_name,
				v_old_favourite_player_id,v_token,v_epoch_timestamp,v_mobile_verified,
				v_referal_user_guid,v_is_referred,v_internal_referral_code,v_mobile_no,v_edition,v_favourite_club,
				v_subscribe_for_email,v_profile_picture_url,v_is_custom_image,v_membership_code,v_accept_disclaimer,v_accept_tnc,v_country_code,v_pass_type;

				select name into v_old_country from waf_master.waf_countries where country_id=v_old_country_id;
				
 						select em.entity_name into v_favourite_player_name
 						from labgt.labgt_entity_role_map erm 
 						join labgt.labgt_entity_master em using (entity_master_id)
 						where source_object_id = COALESCE(v_old_favourite_player_id::text,'0');
											
					 update labgt.labgt_otp_details
					 set is_verified= 1
					 where mobile_no = v_email_id 
					 and otp=v_otp and created_date = v_created_date;

					--Check for other users having same email id with mobile verified should be 1 
					select 	count(1)  from labgt.labgt_web_user
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
						from labgt.labgt_web_user
						where user_guid = v_user_guid and is_active = 1 and  is_deleted = 0;
						raise notice 'v_email_verified %',v_email_verified;

--If there is two account is present in web user and current account mobile is verified and 
--email is not verified and then existing account email id and email verified will be set is null 
--and current account email id will verified and updated with the existing email id

						if (v_email_verified is null or v_email_verified =0) and v_mobile_verified<>0 then

							update 	labgt.labgt_web_user
							set		email_id = NULL,
									upper_email_id = NULL,
									email_verified = 0
							where 	email_id = v_email_id;

							update 	labgt.labgt_web_user
							set		email_id = v_email_id,
									upper_email_id = v_email_id,
									email_verified = 1
							where 	user_guid = v_user_guid 
									and is_active = 1 and  is_deleted = 0;

							--raise notice 'Email verified sucessfully.';
									
					p_data:= '{
					  "data": {
						"user_guid": "'||coalesce(v_old_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_old_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						 "user_id": "'|| coalesce(v_user_id,0) ||'" ,
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": "1",
						"message": "Email Id verified sucessfully.",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"mobile_verified": "'|| coalesce(v_mobile_verified,0)||'",
						"email_verified": "1",
						"option_type": "23",
						"updated_date": "'|| v_current_timestamp||'",
						"created_date": "'|| v_current_timestamp||'",
						"user": {
						  "referal_user_guid": "'||coalesce(v_referal_user_guid,'') ||'",
						  "is_referred": "'|| coalesce(v_is_referred,0)||'",	
						  "internal_referral_code": "'|| coalesce(v_internal_referral_code,'') ||'" ,
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_old_first_name,'') ||'",
						  "last_name": "'||coalesce(v_old_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_old_user_full_name,'') ||'",
						  "dob": "'|| coalesce(v_old_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_old_gender,'') ||'",
						  "city": "'|| coalesce(v_old_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_old_country,'')||'",
                          "country_id": "'|| coalesce(v_old_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "favourite_player_id": "'||coalesce(v_old_favourite_player_id,'') ||'",
						  "jersey_name": "'|| coalesce(v_old_jersey_name,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'" ,
						  "jersey_number": "'||coalesce(v_old_jersey_number,0) ||'",
						  "membership_code": "'||coalesce(v_membership_code,'') ||'",
						  "country_code": "'||coalesce(v_country_code,91) ||'",
						  "favourite_player_name":"'|| coalesce(v_favourite_player_name,'')||'",
						  "pincode":"'|| coalesce(v_old_pincode,'')||'",
						  "accept_disclaimer":"'|| coalesce(v_accept_disclaimer,'false')||'",
						   "accept_tnc":"'|| coalesce(v_accept_tnc,'false')||'"
						},
						"is_first_login": 0,
						"is_app": 0 ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "",
						"pass_type":"'|| coalesce(v_pass_type,'0') ||'"
						}
					}';
					
					
									
		
						else 
							
							p_data	:= '{"status" : "0",
									"message" : "Email Id already verified."}';
						end if;
						
				
					end if;
					else
						if exists(select 1 from labgt.labgt_otp_details 
								  where mobile_no =v_email_id
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labgt.labgt_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = v_email_id
							 and created_date = v_created_date;
						
						
						 select failed_attempt into v_attemp from labgt.labgt_otp_details
							 where mobile_no =coalesce( v_mobile_with_countrycode,v_email_id) 
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
				   
		    select max(created_date) into v_created_date from labgt.labgt_otp_details
			where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid and type = v_type
			and country_code=v_country_code;
			
			if exists(select 1 from labgt.labgt_otp_details
					  where mobile_no =coalesce( v_mobile_no,v_email_id) 
					  and otp=v_otp
					  and expiry_date > current_timestamp at time zone 'utc'
					  and created_date = v_created_date and user_guid = v_user_guid
					  and type = v_type and coalesce(failed_attempt,0) < 3
					  and country_code=v_country_code
						) then

						 update labgt.labgt_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type
						 and country_code=v_country_code;
/*						 
						 if exists(select 1 from labgt.labgt_web_user where email_id=v_email_id and (is_verified=0 or is_verified is null))then
						 				--incase 
						 				 update labgt.labgt_web_user
										 set email_id=null
										 where email_id=v_email_id;
						 
								         update labgt.labgt_web_user
										 set email_id=v_email_id,is_verified=1
										 where user_guid=v_user_guid;
										 
						ELSE
						
										 update labgt.labgt_web_user
										 set email_id=v_email_id,is_verified=1
										 where user_guid=v_user_guid;
						end if;				 
*/
						p_data	:= '{"status": "1",
									"message": "Success"}';

					else
						
						if exists(select 1 from labgt.labgt_otp_details 
								  where mobile_no =coalesce( v_mobile_no,v_email_id) 
								  and created_date = v_created_date and coalesce(failed_attempt,0) < 3
								  and country_code=v_country_code) then
						
							 update labgt.labgt_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date
							 and country_code=v_country_code;						
								
							p_data	:= '{"status": "0",
										"message": "Failed"}';			
						else
							
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';
							
						end if;
								
					end if;	

		end if;	
		
		if (v_user_id is not null) then
		
		select user_guid into v_user_guid from labgt.labgt_web_user where user_id=v_user_id;
		
		insert into labgt.labgt_web_user_audit
				(audit_id, user_id, user_guid, ipaddress, audit_date, is_app,platform_version,platform_type,device_name,option_type,client_code)
				select nextval('labgt.seq_labgt_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress,v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_platform_type,v_device_name,
				23,'labgt';
				
		end if;
	
end;

$$;


--
