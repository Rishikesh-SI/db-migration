-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_update_user_and_return_user_data(jsonb)
-- Type: FUNCTION

-- Name: labgt_update_user_and_return_user_data(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_update_user_and_return_user_data(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_client_id numeric;
    v_social_user_name character varying;
    v_user_full_name character varying;
    v_email_id character varying;
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
    v_mobile_no character varying;
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
	v_country_id numeric;
	v_state_id  numeric;
	v_city_id   numeric;
	v_country_name text;
	v_state_name text ;
	v_city_name  text;
    v_email_social  text;
    --v_mobile_social  text;
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
   v_ext_info jsonb;
   v_waf_user_id numeric;
    v_favourite_player_id character varying;
   v_pincode character varying;
   v_jersey_name character varying;
   v_jersey_number numeric;
   v_membership_code character varying;
   v_subscribe_for_email boolean;
	v_otp numeric;
	v_tempotp varchar(20);
	 v_country_code numeric;
	 v_platform_version character varying;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
   v_address character varying;
   v_internal_referral_code character varying;
   v_table_internal_referral_code character varying;
   v_mobile_verified numeric;
   v_email_verified numeric;
   v_accept_tnc boolean;
   v_accept_disclaimer boolean;
   v_favourite_player_name character varying;
   
   v_referal_user_guid character varying;
   v_table_referal_user_guid character varying;
   v_is_referred numeric;
   v_table_is_referred numeric;
   
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
	v_pass_type numeric;
	v_user_guid_type numeric;
	v_new_user_guid character varying;
	v_user_email_count numeric;
	v_identifier numeric;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'user_guid',
           p_user_json->'data'->>'token',
           p_user_json->'data'->>'epoch_timestamp',
           p_user_json->'data'->>'social_id',
           --p_user_json->'data'->>'client_id', 
    	   p_user_json->'data'->>'email_id',
   		   p_user_json->'data'->>'status',
           p_user_json->'data'->>'reset_key',
           p_user_json->'data'->>'key_expiry_date',
           p_user_json->'data'->>'password',
           p_user_json->'data'->>'confirm_password',
           p_user_json->'data'->>'old_password',
    	   p_user_json->'data'->>'failed_attempts',
    	   p_user_json->'data'->>'unlock_date',
    	   p_user_json->'data'->>'is_registered',
    	   p_user_json->'data'->>'is_verified',
    	   p_user_json->'data'->>'ipaddress',
          -- p_user_json->'data'->>'created_date',
          -- p_user_json->'data'->>'updated_date',
           -- p_user_json->'data'->'is_deleted',    
       	   p_user_json->'data'->'user'->>'mobile_no',
           p_user_json->'data'->'user'->>'name',
           p_user_json->'data'->'user'->>'social_user_name',
           p_user_json->'data'->'user'->>'dob',
           p_user_json->'data'->'user'->>'gender',
           p_user_json->'data'->'user'->>'city',
           p_user_json->'data'->'user'->>'favourite_club',
           p_user_json->'data'->'user'->>'edition',
           p_user_json->'data'->'user'->>'social_user_image',
           p_user_json->'data'->>'is_app',
           p_user_json->'data'->>'verification_key',
           p_user_json->'data'->>'is_deleted',
           p_user_json->'data'->>'is_active',
        --   p_user_json->'data'->>'social_user_image',
		   p_user_json->'data'->>'is_custom_image',
           p_user_json->'data'->'user'->>'country_id',
		   p_user_json->'data'->'user'->>'state_id',
		   p_user_json->'data'->'user'->>'city_id',
		   p_user_json->'data'->'user'->>'first_name',
		   p_user_json->'data'->'user'->>'last_name',
		   p_user_json->'data'->'user'->>'ext_info',
   		   p_user_json->'data'->'user'->>'favourite_player_id',
		   p_user_json->'data'->'user'->>'jersey_name',
			p_user_json->'data'->'user'->>'jersey_number',
			p_user_json->'data'->'user'->>'membership_code',
			p_user_json->'data'->'user'->>'subscribe_for_email',
			p_user_json->'data'->>'otp',
			p_user_json->'data'->'user'->>'country_code',
			p_user_json->'data'->'user'->>'pincode',
			p_user_json->'data'->>'platform_version',
			p_user_json->'data'->>'device_name',
			p_user_json->'data'->>'platform_type',
			p_user_json->'data'->>'option_type',
			p_user_json->'data'->'user'->>'internal_referral_code'
			
    
           
    into   v_user_guid,
           v_token,
           v_epoch_timestamp,
           v_social_id,
          -- v_client_id,
           v_email_id,
           v_is_active,
           v_reset_key,
           v_key_expiry_date,
           v_user_password,
           v_confirm_password,
           v_old_password,
           v_failed_attempts,
           v_unlock_date,
           v_is_registered,
           v_is_verified,
           v_ipaddress,
           v_mobile_no,
           v_user_full_name,
           v_social_user_name,
           v_dob,
           v_gender, 
           v_city,
           v_favourite_club,
           v_edition,
           v_profile_picture_url,
           v_is_app, 
           v_verification_key,
           v_is_deleted,
           v_is_active,
          -- v_profile_picture_url,
		   v_is_custom_image,
		   v_country_id,
			v_state_id,
			v_city_id,
			v_first_name,
			v_last_name,
			v_ext_info,
			v_favourite_player_id,
			v_jersey_name,
			v_jersey_number,
			v_membership_code,
			v_subscribe_for_email,
			v_tempotp,
			v_country_code,
			v_pincode,
			v_platform_version,
			v_device_name,
			v_platform_type,
			v_option_type,
			v_internal_referral_code
           ;

-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-labgt_test_update_profile','logs',uuid_generate_v4(),p_user_json,current_timestamp,'labgt','logs');

		if v_email_id='' THEN
			v_email_id:=null;
		end if;

   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
		v_option_type:=9;
		
		  if coalesce(v_tempotp,'') != '' then
		v_otp:=v_tempotp::int;
		end if;
		
		if not exists(select 1 from labgt.labgt_web_user where email_id=v_email_id)
				and exists(select 1 from labgt.labgt_web_user_old_data where email_id=v_email_id) THEN
				
				v_identifier:=-300;
		end if;
        
         --raise notice 'v_identifier:%',v_identifier;
		
		
    /* ****************************************
      Client_id     Client 
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */
    
--if p_opttype = 9 then   -- p_opttype = 9 Update User  and return user data   

-- raise notice '%',v_jersey_name;
--1.First time update profile where email id is null in web user TABLE
--2.Email id is present in one account and should not be present in another account.
/*if (exists (select 1 from labgt.labgt_web_user where user_guid = v_user_guid and (email_id=v_email_id or email_id is null or v_email_id is null))) AND
(not exists(select 1 from labgt.labgt_web_user where user_guid <> v_user_guid and email_id=v_email_id and v_email_id is not null)) and 
v_identifier is null then*/
if (exists (select 1 from labgt.labgt_web_user where user_guid = v_user_guid)) AND
(not exists(select 1 from labgt.labgt_web_user where user_guid <> v_user_guid and v_email_id is not null and email_id=v_email_id )) and 
v_identifier is null then 

 		--raise notice 'update Profile:1';
		if exists (select 1 from labgt.labgt_web_user where user_guid = v_user_guid)
		then 

	--Internal referral Code
		if (v_internal_referral_code is not null or v_internal_referral_code<>'') AND
		exists(select 1 from labgt.labgt_web_user where membership_code=v_internal_referral_code)  then
						
							select user_guid into v_referal_user_guid
							from labgt.labgt_web_user
							where membership_code=v_internal_referral_code;
													
							v_is_referred:=1;
							
		ELSE
		v_internal_referral_code:=null;
		v_is_referred:=null;
		v_referal_user_guid:=null;
						
		end if;
		   
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labgt.labgt_web_user where user_guid = v_user_guid ; 
			
			if  v_is_deleted = 1 and v_is_active = 0  then 
						
					 v_status = 500 ;
					 
					v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
					v_is_first_login := 0 ;
					v_email_id := '' ;
					v_mobile_no := '';
					v_user_full_name := '' ;
					v_social_user_name:= '';
					v_dob := null;
					v_favourite_club := '' ;
					v_edition := '';                
					v_gender := '';
					v_city :='' ;
					v_token :=  '';
					v_epoch_timestamp :=  '';
					
			else
          
				if exists (select 1 from labgt.labgt_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0)
							 --and epoch_timestamp = v_epoch_timestamp ) --and token =  v_token
				then 
             -- raise notice 'opttype 9 test 1 ';   
             
             --raise notice '1';
              			   	                   
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
					--raise notice '1';					
								
					select email_id, is_custom_image, profile_picture_url,a.user_id,country_code,mobile_no,mobile_verified,email_verified,accept_tnc,accept_disclaimer,internal_referral_code,is_referred,referal_user_guid,membership_code
					into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url,v_waf_user_id,v_country_code,v_mobile_no,v_mobile_verified,v_email_verified,v_accept_tnc,v_accept_disclaimer,v_table_internal_referral_code,v_table_is_referred,v_table_referal_user_guid,v_membership_code      
					from labgt.labgt_web_user a
					where user_guid = v_user_guid
					and a.is_active = 1 and a.is_deleted = 0 ; 
					--
					if (v_table_internal_referral_code is not null and v_table_is_referred is not null and v_table_referal_user_guid is not null) THEN
					v_internal_referral_code:=v_table_internal_referral_code;
					v_is_referred:=v_table_is_referred;
					v_referal_user_guid:=v_table_referal_user_guid;
					end if;
					
 						select em.entity_name into v_favourite_player_name
 						from labgt.labgt_entity_role_map erm 
 						join labgt.labgt_entity_master em using (entity_master_id)
 						where source_object_id = COALESCE(v_old_favourite_player_id::text,'0');
-- raise notice '2';
                        --select entity_name into v_favourite_player_name 
                        --from waf_master.waf_players where 
                        --source_object_id=COALESCE(v_favourite_player_id,'0');
						
						select name into v_country_name 
						from labgt.labgt_web_user wu
						left join waf_master.waf_Countries c
						on wu.country_id = c.country_id
						where wu.user_guid=v_user_guid
					    and is_active = 1 and is_deleted = 0;
					
				--raise notice 'v_subscribe_for_email %',v_subscribe_for_email;
				
				
                --Update the email id only if email is not present 
--                 if (v_emailid_ex is null and coalesce(v_email_verified,0)=0 and v_email_id is not null) then
                
--                     update labgt.labgt_web_user 
--                     set email_id = v_email_id,
--                         upper_email_id = v_upper_email_id,
--                         email_verified=1
--                     where user_guid = v_user_guid 
--                     and is_active = 1 and  is_deleted = 0;
                
--                 end if;
                
	--raise notice '3';			
						update labgt.labgt_web_user 
						set     social_user_name = v_social_user_name,
							user_full_name = v_user_full_name,
 							email_id = v_email_id,
    						upper_email_id = v_upper_email_id,	
							dob =  v_dob,
							--profile_picture_url = (case when v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),   
							city = v_city,
							--mobile_no = v_mobile_no,
							updated_date = v_current_timestamp,
							gender = v_gender ,	
							favourite_club = v_favourite_club,
							token =  v_token,
							epoch_timestamp = v_epoch_timestamp ,
							ipaddress = v_ipaddress,
							edition =  v_edition, 
							is_custom_image = (case when v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
							favourite_player_id= v_favourite_player_id,
							address= v_address,
							first_name = v_first_name,
							last_name = v_last_name,
							jersey_number = v_jersey_number,
							subscribe_for_email = v_subscribe_for_email,
							country_id = v_country_id,														
							jersey_name = v_jersey_name,
							pincode = v_pincode,
							state_id = v_state_id,
							internal_referral_code=v_internal_referral_code,
							is_referred=v_is_referred,
							referal_user_guid=v_referal_user_guid
						where user_guid = v_user_guid 
						and is_active = 1 and  is_deleted = 0 
						returning user_id into v_user_id ; 
						
						v_status := 1;
						v_message := 'Profile updated successfully.';
				
				

				
				else 
            
					-- raise notice 'opttype 9 test 2 ';   
					v_status := 0;
					v_message := 'Token mismatch.';
                    v_user_full_name := '';
					v_dob := '';
					v_email_id:= '';

				end if ;
				
			end if ;
			
		else 
					
				-- raise notice 'opttype 9 test 2 ';   
				v_status := 0;
				v_message := 'Unable to locate user information.';  
		
		end if ;
			
       -- raise notice 'opttype 9 test 3 ';   

					
elsif (select 1 from labgt.labgt_web_user where user_guid <> v_user_guid and email_id=v_email_id) then 
	
		--raise notice 'Email id already exist:2';
				
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
											
					 --update labgt.labgt_otp_details
					 --set is_verified= 1
					 --where mobile_no = v_email_id 
					 --and otp=v_otp and created_date = v_created_date;

					--Check for other users having same email id with mobile verified should be 1 
					select 	count(1)  from labgt.labgt_web_user
					into 	v_user_email_count
					where 	email_id = v_email_id 
					and 	mobile_verified =1;

					--If there are other verified user with same email
					if v_user_email_count > 0 then
						--raise notice 'Cannot verify email.Email already exists. ';
						--p_ures_json	:= '{"status" : "0",
									--"message" : "Cannot verify email Id .Email Id already exists."}';		
							v_status:=0;
							v_message:='Cannot verify email Id .Email Id already exists.';
					else
						--- Verify email for current user and set other users with same email = NULL
						select mobile_verified 
						into v_mobile_verified 
						from labgt.labgt_web_user
						where user_guid = v_user_guid and is_active = 1 and  is_deleted = 0;
						--raise notice 'v_email_verified %',v_email_verified;

--If there is two account is present in web user and current account mobile is verified and 
--email is not verified and then existing account email id and email verified will be set is null 
--and current account email id will verified and updated with the existing email id

						if  v_mobile_verified=1 then --(v_email_verified is null or v_email_verified =0) and

							update 	labgt.labgt_web_user
							set		email_id = NULL,
									upper_email_id = NULL--,
									--email_verified = 0
							where 	email_id = v_email_id;

							update 	labgt.labgt_web_user
							set		social_user_name = v_social_user_name,
							user_full_name = v_user_full_name,
 							email_id = v_email_id,
    						upper_email_id = v_email_id,	
							dob =  v_dob,  
							city = v_city,
							updated_date = v_current_timestamp,
							gender = v_gender ,	
							favourite_club = v_favourite_club,
							token =  v_token,
							epoch_timestamp = v_epoch_timestamp ,
							ipaddress = v_ipaddress,
							edition =  v_edition, 
							is_custom_image = (case when v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
							favourite_player_id= v_favourite_player_id,
							address= v_address,
							first_name = v_first_name,
							last_name = v_last_name,
							jersey_number = v_jersey_number,
							subscribe_for_email = v_subscribe_for_email,
							country_id = v_country_id,														
							jersey_name = v_jersey_name,
							pincode = v_pincode,
							state_id = v_state_id,
							internal_referral_code=v_internal_referral_code,
							is_referred=v_is_referred,
							referal_user_guid=v_referal_user_guid
							where 	user_guid = v_user_guid 
									and is_active = 1 and  is_deleted = 0;

							--raise notice 'Email verified sucessfully.';
									
							v_status:=1;
							v_message:='Email Id verified sucessfully.';
							--v_email_verified:=1;
					
									
		
						else 
							
							--p_ures_json	:= '{"status" : "0",
									--"message" : "Email Id already verified."}';
									
									v_status:=0;
									v_message:='Email Id already verified.';
						end if;
						
				
					end if;
					
					
					
elsif exists(select 1 from labgt.labgt_web_user where user_guid = v_user_guid) then
					
		 --raise notice '-300 case:3';			
					
		if not exists(select 1 from labgt.labgt_web_user where email_id=v_email_id)
				and exists(select 1 from labgt.labgt_web_user_old_data where email_id=v_email_id) 
				
			then 
			--raise notice 'hi';
						
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
				
        --If old web user table user_guid is not same as current table user guid
		if 	v_old_user_guid<>v_user_guid then

				--In v_user_guid_type 1 if user_guid is present in old web user table but not in current web user table (Here user_guid is old table user guid and new user guid is in ref user_guid)
				--In v_user_guid_type 2 if user_guid is present in old web user table as well as in current web user table (Here user_guid is new user guid  and old table user guid is in ref user_guid)		
		    if not exists (select 1 from labgt.labgt_web_user where user_guid=v_old_user_guid) then

                    v_user_guid_type:=1;

                    update labgt.labgt_web_user
                    set user_guid=v_old_user_guid,
                    email_id=v_email_id,
                    upper_email_id=v_email_id,
                    --email_verified=1,
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
                    --email_verified=1,
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
				end if;

		ELSE		
				update labgt.labgt_web_user
				set user_guid=v_old_user_guid,
				email_id=v_email_id,
				upper_email_id=v_email_id,
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
				favourite_player_id=v_old_favourite_player_id
				where user_guid=v_user_guid;				
		end if;
		
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
		
				v_status:=-300;
				v_message:='Profile updated successfully.';
					
				
		end if; -- status -300		
					
else

				v_status:=-1;
				v_message:='Invalid Data Provided.';

end if;
					
		select user_id,user_guid from labgt.labgt_web_user where mobile_no=v_mobile_no into v_user_id,v_user_guid;			
					
		insert into labgt.labgt_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, audit_date, is_app,platform_version,platform_type,device_name,option_type,client_code)
		select nextval('labgt.seq_labgt_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress,v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_platform_type,v_device_name,v_option_type,'labgt';
		
p_ures_json:= '{
					  "data": {
						"user_guid": "'||coalesce(v_old_user_guid,v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_old_user_guid,v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						 "user_id": "'|| coalesce(v_user_id,0) ||'" ,
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"mobile_verified": "'|| coalesce(v_mobile_verified,0)||'",
						"email_verified": "'|| coalesce(v_email_verified,0)||'",
						"option_type": "9",
						"updated_date": "'|| v_current_timestamp||'",
						"created_date": "'|| v_current_timestamp||'",
						"user": {
						  "referal_user_guid": "'||coalesce(v_referal_user_guid,'') ||'",
						  "is_referred": "'|| coalesce(v_is_referred,0)||'",	
						  "internal_referral_code": "'|| coalesce(v_internal_referral_code,'') ||'" ,
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_old_first_name,v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_old_last_name,v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_old_user_full_name,v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_old_dob::varchar,v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_old_gender,v_gender,'') ||'",
						  "city": "'|| coalesce(v_old_city,v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_old_country,v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_old_country_id::varchar,v_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "favourite_player_id": "'||coalesce(v_old_favourite_player_id,v_favourite_player_id,'') ||'",
						  "jersey_name": "'|| coalesce(v_old_jersey_name,v_jersey_name,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "jersey_number": "'||coalesce(v_old_jersey_number,v_jersey_number,0) ||'",
						  "membership_code": "'||coalesce(v_membership_code,'') ||'",
						  "country_code": "'||coalesce(v_country_code,91) ||'",
						  "favourite_player_name":"'|| coalesce(v_favourite_player_name,'')||'",
						  "pincode":"'|| coalesce(v_old_pincode,v_pincode,'')||'",
						  "accept_disclaimer":"'|| coalesce(v_accept_disclaimer,'false')||'",
						   "accept_tnc":"'|| coalesce(v_accept_tnc,'false')||'"
						},
						"is_first_login": 0,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'",
						"pass_type":"'|| coalesce(v_pass_type,'0') ||'"
						}
					}';
					
					p_ures_json:=jsonb_set(p_ures_json, '{data,ext_info}',coalesce(v_ext_info,'null'), true);
					
					
					
					
end;
$$;


--
