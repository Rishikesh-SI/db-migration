-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_ins_upd_users_custom_registrastion(jsonb)
-- Type: FUNCTION

-- Name: labgt01_v1_ins_upd_users_custom_registrastion(jsonb); Type: FUNCTION; Schema: labgt01_v1; Owner: -
--

CREATE FUNCTION labgt01_v1.labgt01_v1_ins_upd_users_custom_registrastion(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
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
   v_subject text;
   v_first_name character varying;
	v_last_name character varying;
	v_waf_user_guid character varying;
	v_ext_info jsonb;
	v_is_shared_data numeric;
   v_is_used_data numeric;
   v_membership_code character varying;
   v_jersey_number numeric;
   v_favourite_player_id character varying;
   v_pincode character varying;
   v_jersey_name character varying;
   v_subscribe_for_email boolean;
   v_country_code character varying;
   v_platform_version character varying;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
   v_internal_referral_code character varying;
   v_referal_user_guid character varying;
   v_is_referred numeric;
   v_email_verified numeric;
   v_email_otp numeric;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'user_guid',
           p_user_json->'data'->>'token',
           p_user_json->'data'->>'epoch_timestamp',
           p_user_json->'data'->>'social_id',
           p_user_json->'data'->>'client_id', 
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
		  p_user_json->'data'->>'waf_user_guid',
		  p_user_json->'data'->'ext_info',
		  p_user_json->'data'->>'is_shared_data',
		   p_user_json->'data'->>'is_used_data',
		    p_user_json->'data'->'user'->>'membership_code',
		    p_user_json->'data'->'user'->>'jersey_number',
			p_user_json->'data'->'user'->>'favourite_player_id',
			p_user_json->'data'->'user'->>'pincode',
			p_user_json->'data'->'user'->>'jersey_name',
			p_user_json->'data'->'user'->>'subscribe_for_email',
			p_user_json->'data'->'user'->>'country_code',
			  p_user_json->'data'->>'platform_version',
			p_user_json->'data'->>'device_name',
			p_user_json->'data'->>'platform_type',
			p_user_json->'data'->>'option_type',
			p_user_json->'data'->>'otp',
		   p_user_json->'data'->'user'->>'internal_referral_code'--45 
           
    into   v_user_guid,
           v_token,
           v_epoch_timestamp,
           v_social_id,
           v_client_id,
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
			v_waf_user_guid,
			v_ext_info,
			v_is_shared_data,
			v_is_used_data,
			v_membership_code,
			v_jersey_number,
			v_favourite_player_id,
			v_pincode,
			v_jersey_name,
			v_subscribe_for_email,
			v_country_code,
			v_platform_version,
			v_device_name,
			v_platform_type,
			v_option_type,
			v_email_otp,
			v_internal_referral_code --45
			;
			
       --select 1/0;    
   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
		
    /* ****************************************
      Client_id     Client 
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */
			v_option_type:=2;
			v_client_id:=5;
    
    		if exists(select 1 from labgt01_v1.labgt01_v1_web_user where email_id = v_email_id or mobile_no = v_mobile_no )
            then 
						v_status = 0 ; 
						v_message := 'Email/Mobile is in use.';
						v_is_first_login := 0;   
						v_is_login = 0 ;
				
				else
				
						v_web_user_id := nextval('labgt01_v1.seq_labgt01_v1_web_users_id');
						v_user_guid := uuid_generate_v4();
						v_is_new_reg:=1;
						v_is_active := 1;
						v_is_deleted := 0; 
						v_is_verified = 0 ; 				
						v_created_date := v_current_timestamp;
						v_updated_date := v_current_timestamp;  				
						v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
						v_is_login := 0;

					if exists(select 1 from labgt01_v1.labgt01_v1_otp_details 
							 where mobile_no =v_email_id and otp=v_email_otp and is_verified=1)
									then
							 v_email_verified:=1;
							 --raise notice 'v_otp %',v_otp;
					else 
							 v_email_verified:=0;
					end if;
						
					if v_email_verified = 1 then		
					
					if (v_internal_referral_code is not null) then
					
						if exists(select 1 from labgt01_v1.labgt01_v1_web_user where membership_code=v_internal_referral_code) then
						
							select user_guid into v_referal_user_guid
							from labgt01_v1.labgt01_v1_web_user
							where membership_code=v_internal_referral_code;
													
							v_is_referred:=1;						

						else 
							v_internal_referral_code:=null;
						
						end if;
							
						insert into labgt01_v1.labgt01_v1_web_user
						(user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
						is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by, 
						 favourite_club, edition, profile_picture_url , is_custom_image,user_full_name,mobile_no,city_id,state_id,country_id,gender,dob,first_name,
						 last_name,ext_info,is_shared_data,is_used_data,membership_code,jersey_number,favourite_player_id,pincode,city,jersey_name,subscribe_for_email,
						 country_code,sync_status,internal_referral_code,is_referred,email_verified,referal_user_guid)
						select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
						v_created_date, v_updated_date, 1, 1, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
						v_favourite_club, v_edition, v_profile_picture_url, 1,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id,v_gender,v_dob,
						v_first_name,v_last_name,v_ext_info,v_is_shared_data,v_is_used_data,v_membership_code,v_jersey_number,v_favourite_player_id,v_pincode,
						v_city,v_jersey_name,v_subscribe_for_email,v_country_code,0,v_internal_referral_code,v_is_referred,v_email_verified,v_referal_user_guid;
										 
						v_is_first_login := 1;
						
						v_status := 3 ;						
						v_message := 'Registration successful' ;
	

						
					elsif v_internal_referral_code is null then
						
						insert into labgt01_v1.labgt01_v1_web_user
						(user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
						is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by, 
						 favourite_club, edition, profile_picture_url , is_custom_image,user_full_name,mobile_no,city_id,state_id,country_id,gender,dob,first_name,
						 last_name,ext_info,is_shared_data,is_used_data,membership_code,jersey_number,favourite_player_id,pincode,city,jersey_name,subscribe_for_email,
						 country_code,sync_status,internal_referral_code,is_referred,email_verified,referal_user_guid)
						select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
						v_created_date, v_updated_date, 1, 1, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
						v_favourite_club, v_edition, v_profile_picture_url, 1,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id,v_gender,v_dob,
						v_first_name,v_last_name,v_ext_info,v_is_shared_data,v_is_used_data,v_membership_code,v_jersey_number,v_favourite_player_id,v_pincode,
						v_city,v_jersey_name,v_subscribe_for_email,v_country_code,0,v_internal_referral_code,v_is_referred,v_email_verified,v_referal_user_guid;
										 
						v_is_first_login := 1;
						
						v_status := 3 ;						
						v_message := 'Registration successful' ;

						
					end if;	
						 
						--v_subject := 'Verify your Email' ;
						
						insert into labgt01_v1.labgt01_v1_web_user_audit
						(audit_id, user_id, user_guid, ipaddress,option_type, audit_date, is_app,platform_version,device_name,platform_type)
					   select nextval('labgt01_v1.seq_labgt01_v1_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress,v_option_type, v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_device_name,v_platform_type;
					
						
					else
						v_status = 0; 
						v_message := 'Email Id is not verified';

				    end if;
						
			end if ;
			
		p_ures_json = '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"user_id": "'||coalesce(v_web_user_id,0)||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"ext_info": "'|| coalesce(v_ext_info::varchar,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"subject": "'|| coalesce(v_subject,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'||coalesce(v_option_type,0)||'",
                        "created_date": "'|| v_created_date ||'",
						"user": {
                          "first_name": "'||coalesce(v_first_name,'') ||'",
                          "last_name": "'||coalesce(v_last_name,'') ||'",
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "membership_code": "'|| coalesce(v_membership_code,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
                          "email_verified": "'|| coalesce(v_email_verified,0) ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",			  
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "internal_referral_code": "'|| coalesce(v_internal_referral_code,'')||'",
						  "referal_user_guid": "'||coalesce(v_referal_user_guid,'') ||'",
						  "is_referred": "'|| coalesce(v_is_referred,0)||'",						  
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "jersey_number": "'||coalesce(v_jersey_number,0) ||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "pincode": "'||coalesce(v_pincode,'') ||'",
						  "jersey_name": "'||coalesce(v_jersey_name,'') ||'",
						  "membership_code": "'||coalesce(v_membership_code,'') ||'",
						  "country_code": "'||coalesce(v_country_code,'') ||'"
						},
						"is_first_login": 0,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ;  
end;
$$;


--
