-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_ins_upd_users_custom_registrastion(jsonb)
-- Type: FUNCTION

-- Name: labsaw_ins_upd_users_custom_registrastion(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_ins_upd_users_custom_registrastion(p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
    v_client_id numeric;
    v_social_user_name character varying;
    v_user_full_name character varying;
	v_first_name character varying;
	v_last_name character varying;
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
   v_substricption_json jsonb;
   v_sub_guid text;
   v_subscribe_for_email boolean;
   v_subscribe_id numeric;
   v_additional_user_data text;
   v_email_count numeric;
   v_otp numeric;
   v_tempotp varchar(20);
   v_sportsbet_username character varying;
   v_previous_subscription_key varchar(100);
   v_user_id1 numeric;
   v_subject text;
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
		   p_user_json->'data'->'user'->>'first_name',
		   p_user_json->'data'->'user'->>'last_name',
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
		   p_user_json->'data'->'user'->>'subscribe_for_email',
		   p_user_json->'data'->'user'->>'additional_user_data',
		   p_user_json->'data'->>'otp',
		    p_user_json->'data'->'user'->>'sportsbet_username'
          
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
		   v_first_name,
		   v_last_name,
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
			v_subscribe_for_email,
			v_additional_user_data,
			v_tempotp,
			v_sportsbet_username;
			
			
		raise notice 'val%',v_email_id;
		if coalesce(v_tempotp,'') != '' then
		v_otp:=v_tempotp::int;
		end if;
   		
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
			if not exists(select 1 from labsaw.labsaw_web_user 
			where upper_email_id = v_upper_email_id and is_active = 1
						--  client_id = v_client_id and 
						 )
            then 
                v_web_user_id := nextval('labsaw.seq_labsaw_web_users_id');
                v_user_guid := uuid_generate_v4();
				v_is_new_reg:=1;
                v_is_active := 1;
                v_is_deleted := 0; 
				v_is_verified = 0 ; 				
                v_created_date := v_current_timestamp;
                v_updated_date := v_current_timestamp;  				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                v_is_login := 0;			                
             
	--		 v_user_id1:=v_web_user_id;
			 
                insert into labsaw.labsaw_web_user
                (user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
				is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by, 
                 favourite_club, edition, profile_picture_url , is_custom_image,user_full_name,first_name,last_name,mobile_no,city_id,state_id,country_id,gender,dob,additional_user_data,subscribe_for_email,sportsbet_username)
                select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, 1, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
                v_favourite_club, v_edition, v_profile_picture_url, 1,v_user_full_name,v_first_name,v_last_name,v_mobile_no,v_city_id,v_state_id,v_country_id,v_gender,v_dob,v_additional_user_data,v_subscribe_for_email,v_sportsbet_username;
				                 
                v_is_first_login := 1;
				
				v_status := 3 ;						
				v_message := 'A verification email has been sent to your registered email. Please check your inbox to complete the registration.' ;
                   
				v_subject := 'Verify your Email' ;
            else
            
				select is_verified, profile_picture_url , is_custom_image
				into v_is_verified,  v_profile_picture_url, v_is_custom_image
				from labsaw.labsaw_web_user 
				where client_id = v_client_id and upper_email_id = v_upper_email_id 
				-- and is_active = 1 
				;
				
                v_status = 0 ; 
				v_message := 'Email is in use.';
                    
				/*if v_is_verified = 0 then 					
					v_status = 0 ; 
					v_message := 'Fail : Please Verify Email_id ';	
				else                
					v_status = 0 ; 
					v_message := 'Fail : Already Verified, Login';					
				end if ;		
				 */ 
				v_is_first_login := 0;   
				v_is_login = 0 ;
				
            end if ;
			
            insert into labsaw.labsaw_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labsaw.seq_labsaw_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, 2, v_current_timestamp, coalesce(v_is_app,0) ;
        
			
		p_result := 1;
	
   		p_ures_json := '{
					  "data": {
					    "user_id": "'||coalesce(v_web_user_id,0)||'",
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"subject": "'|| coalesce(v_subject,'')||'",
						"error": {
							"code": '||coalesce(v_status,0) ||',
							"message":  "'||coalesce(v_message,'')||'"
						},
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'|| coalesce(v_user_full_name,'') ||'" ,
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city_name,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'",
						  "additional_user_data":"'|| coalesce(v_additional_user_data::varchar,'') ||'",
						  "sportsbet_username": "'||coalesce(v_sportsbet_username::varchar,'') ||'",
						  "previous_subscription_key": "'||coalesce(v_previous_subscription_key::varchar,'false') ||'"
						},
						"is_first_login": "'|| coalesce(v_is_first_login,0) || '",
						"client_id": "'|| coalesce(v_client_id,0) || '",
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						  "old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ;  
end;
$$;


--
