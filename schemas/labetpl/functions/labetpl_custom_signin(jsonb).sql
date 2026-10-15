-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_custom_signin(jsonb)
-- Type: FUNCTION

-- Name: labetpl_custom_signin(jsonb); Type: FUNCTION; Schema: labetpl; Owner: -
--

CREATE FUNCTION labetpl.labetpl_custom_signin(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
	v_membership_code character varying;
   v_favourite_player_id character varying;
   v_platform_version numeric;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
   v_accept_tnc boolean;
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
		   p_user_json->'data'->>'platform_version',
			p_user_json->'data'->>'device_name',
			p_user_json->'data'->>'platform_type',
			p_user_json->'data'->>'option_type',
            p_user_json->'data'->>'accept_tnc'
            
    /*  
      "mobile_no": null,
      "name": "abc",
      "social_user_name": null,
      "dob": null,
      "gender": null,
      "city": null,
      "favourate_club": null,
      "edition": null
    }
    */
           
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
			 v_platform_version,
			v_device_name,
			v_platform_type,
			v_option_type,
            v_accept_tnc
           ;
   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
		v_option_type:=4;
    /* ****************************************
      Client_id     Client 
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */
    
v_client_id:=5;
	
	if exists(select 1 from labetpl.labetpl_web_user
			  where client_id = v_client_id and upper_email_id = v_upper_email_id 
			  and user_password = v_user_password and is_deleted=1) then
			
		
			select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            		favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,first_name,last_name,mobile_no,membership_code,email_id,dob,gender,country_id,city,favourite_player_id,user_guid,accept_tnc
            into v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
            		v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_first_name,v_last_name,v_mobile_no,v_membership_code,v_email_id,v_dob,v_gender,v_country_id,v_city,v_favourite_player_id,v_user_guid,v_accept_tnc
			from labetpl.labetpl_web_user 
			where upper_email_id = v_upper_email_id
		    and client_id = v_client_id  ;

			v_status := 500 ;
			v_message := 'Login Successful.';
   else
		
		if exists(select 1 from labetpl.labetpl_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id 
				  and user_password = v_user_password)
		then
		
			select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            		favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,first_name,last_name,mobile_no,membership_code,email_id,dob,gender,country_id,city,favourite_player_id,user_guid,accept_tnc
            into v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
            		v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_first_name,v_last_name,v_mobile_no,v_membership_code,v_email_id,v_dob,v_gender,v_country_id,v_city,v_favourite_player_id,v_user_guid,v_accept_tnc
			from labetpl.labetpl_web_user 
			where upper_email_id = v_upper_email_id
		    and client_id = v_client_id  ;
			
			if coalesce(v_is_deleted,0) = 1 and v_is_active = 0 then
				v_status := 7 ;
				v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
				v_is_first_login := 0;
				
			else 
			
			   if ( v_is_verified != 1) then -- check user is verified or not       
						v_status := 3 ;
						v_message :=  'Verification Required. A verification email has been sent to your registered email. Please check your inbox to complete the registration.';
						v_user_guid := v_verification_key;
						
			   else
					if v_first_name is null or v_last_name is null or v_email_id is null
					then 
						v_status := 2 ;
						v_message := 'Incomplete Profile.';
						
					else
						if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then 
						
							update labetpl.labetpl_web_user  
							set  failed_attempts = 0, unlock_date = null, updated_date = v_current_timestamp,
								 ipaddress = v_ipaddress
							where upper_email_id = v_upper_email_id and client_id = v_client_id 
							-- and is_active = 1
							;

							v_status := 1 ;
							v_message := 'Login Successful';
						else				
							v_status := 0 ;
							v_message := 'This account has been locked. Please try again after 24 hrs.';
							v_user_guid := '';
							v_user_full_name := '';
						end if;
					end if ;
				end if;
			end if;
		else
			
			if not exists(select 1 from labetpl.labetpl_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id )
		    then 
				 v_email_id:='';
				 v_status := 0 ;
                 v_message := 'User doesn''t exists.';
			else
			
				select coalesce(failed_attempts,0) +1 into v_failed_attempts 
				from labetpl.labetpl_web_user 
				where upper_email_id = v_upper_email_id
				and client_id = v_client_id  ;			
				
				if v_failed_attempts >= 3 then             
				
					v_unlock_date = v_current_timestamp + interval '24 hours' ;
					update labetpl.labetpl_web_user  
					set  failed_attempts = failed_attempts + 1, 
						 unlock_date = v_unlock_date ,
						 updated_date = v_current_timestamp,
						 ipaddress = v_ipaddress
					where upper_email_id = v_upper_email_id and client_id = v_client_id;
					
					v_status := 0 ;
					v_message := 'Too many failed attempts. The account has been locked. Please try again after 24 hrs.';
				else
					update labetpl.labetpl_web_user 
					set  failed_attempts = failed_attempts + 1, updated_date = v_current_timestamp ,
						 ipaddress = v_ipaddress
					where upper_email_id = v_upper_email_id and client_id = v_client_id;
					
					v_status := 0 ;
					v_message := 'Incorrect credentials. Please check the credentials and try again.';
				
				end if ;
				v_email_id:='';
			end if;
		end if ; 
		
       insert into labetpl.labetpl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress,audit_date, is_app,platform_version,device_name,platform_type,option_type)
		select nextval('labetpl.seq_labetpl_web_user_audit_id'), v_user_id, v_user_guid, v_ipaddress,v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_device_name,v_platform_type,v_option_type;
         
	end if;

	
p_ures_json = '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
                        "accept_tnc": '||coalesce(v_accept_tnc,'false')||',
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
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
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "membership_code": "'||coalesce(v_membership_code,'') ||'"
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
