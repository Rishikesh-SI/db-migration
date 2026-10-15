-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_upd_get_web_users_login_24_12_2019(numeric, jsonb)
-- Type: FUNCTION

-- Name: isl_ins_upd_get_web_users_login_24_12_2019(numeric, jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_upd_get_web_users_login_24_12_2019(p_opttype numeric, p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
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
    v_favourite_player_id character varying;
	v_cnt numeric;
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
           p_user_json->'data'->'user'->>'favourite_player_id'        
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
           v_favourite_player_id
           ;
   
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;  
    /* ****************************************
      Client_id     Client
      1   Facebook
      2             Twitter
      3 Google+
      5 Custom
    ****************************************  */
if p_opttype = 1  then 

		begin
			 select email_id , user_full_name, user_id, user_guid, is_deleted, favourite_club, edition,  profile_picture_url , is_custom_image, is_active
             into strict v_email_id , v_user_full_name, v_user_id, v_user_guid, v_is_deleted, v_favourite_club, v_edition,  v_profile_picture_url, v_is_custom_image, v_is_active
             from isl.isl_web_user
             where social_id = v_social_id
             and client_id   = v_client_id;
         
	
		   	 if coalesce(v_is_deleted,0) = 1 and v_is_active = 0 then
			 	v_status = 7 ;
				v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
				v_is_first_login := 0 ;
					  
			 else 
			 		
					if (v_email_id ='' or v_user_full_name ='') or (v_email_id is null or v_user_full_name is null)
					then                                  
						  raise notice '%',v_email_id ;
				          -- select 1/0;
						v_status = 2 ;
						v_message := 'Incomplete Profile. Name and Email are required to proceed.';
						v_is_first_login := 1;  
					else                
						v_status = 1 ;
						v_message := 'Login Successful';
					end if ;
			  end if;
		      p_result := v_user_id  ;	  
		      --raise notice '%',v_email_id;
			  --select 1/0;
			  --select * from isl.isl_web_user
		exception when NO_DATA_FOUND then
		     --raise notice '%',2;
			 --select 1/0;
		  		v_web_user_id := nextval('isl.seq_isl_web_users_id');              
                v_user_guid := uuid_generate_v4();                
                v_is_active := 1;
                v_is_deleted := 0;
                v_created_by := 1;
                v_updated_by := 1;              
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
				 if (v_email_id is null or v_user_full_name is null)  then
					v_status = 2 ;
                    v_message := 'Incomplete Profile. Name and Email are required to proceed.';
                    v_is_verified = 0 ;
				 else
				 	v_is_verified = 1;
               		v_status = 1 ;
                    v_message := 'Login Successful';
                 end if ; 
				 insert into isl.isl_web_user
                (user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
                 social_id, profile_picture_url, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
                 is_verified, gender, epoch_timestamp, ipaddress, favourite_club, edition, is_custom_image)
                select v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password,
                v_social_id, v_profile_picture_url, v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,
                        1, v_is_verified,v_gender, v_epoch_timestamp, v_ipaddress, v_favourite_club, v_edition, v_is_custom_image ;
           		v_is_first_login := 1;               
               
				
		end;
		insert into isl.isl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
    
		p_result := coalesce(v_user_id,v_web_user_id);
		p_ures_json := ' {
                          "data": {
                            "user_guid": "'|| v_user_guid ||'",
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,  
                            "error": { "code": null,
                                       "message": null
                             },
                            "user": { "name": "'|| coalesce(v_user_full_name,'') ||'",
                                      "favourite_club" : "'||coalesce(v_favourite_club,'') ||'",
                                      "edition" : "'||coalesce(v_edition,'') ||'"  ,
  									  "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"
                                    },
                            "is_first_login": '|| v_is_first_login ||'
                            ,"is_app": '|| coalesce(v_is_app,0) ||',
                           "is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"

                           }
                       }' ;
end if ;
--- p_option type=2 --
/* custom registration code start */
if p_opttype = 2 then 
   
   	begin
   			select is_verified, profile_picture_url , is_custom_image
			into strict v_is_verified,  v_profile_picture_url, v_is_custom_image
			from isl.isl_web_user
			where client_id = v_client_id 
			and upper_email_id = v_upper_email_id;
			v_status = 0 ;
			v_message := 'Email is in use.';
			v_is_first_login := 0;  
			v_is_login = 0 ;
	exception when no_data_found then 
			v_web_user_id := nextval('isl.seq_isl_web_users_id');
            v_user_guid := uuid_generate_v4();
			v_is_active := 1;
			v_is_deleted := 0;
			v_is_verified = 0 ;
			v_created_date := v_current_timestamp;
			v_updated_date := v_current_timestamp;  
			v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
			v_is_login := 0;  
			
			insert into isl.isl_web_user(user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
										 is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by,
                 						 favourite_club, edition, profile_picture_url , is_custom_image)
            select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, 1, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
                v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image;
               
                v_is_first_login := 1;
			v_status := 3 ;
            v_message := 'A verification email has been sent to your registered email address. Please check your inbox to complete the registration.' ;

			
    end ;
	insert into isl.isl_web_user_audit
	(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
	select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

	p_result := 1  ;
	p_ures_json := '{
					 "data": {
					 "user_guid": "",
					 "status": "'|| v_status ||'",
					 "message": "'||v_message || '",
					 "error": {
					 "code": null,
					 "message": null
					 },
					 "user": {
					 "name": "" ,
					 "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"
					 },
					 "is_first_login": "'|| v_is_first_login || '",
					 "is_app": '|| v_is_app ||' ,
					 "is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"
					 }
					}' ;
end if; 

/*Custom Login Email Verification code start */
if p_opttype = 3 then
	 	begin 		
				 select user_guid, is_verified, favourite_club, edition,  profile_picture_url , is_custom_image
                 into strict v_user_guid, v_is_verified, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image
                 from isl.isl_web_user
                 where client_id = 5 and verification_key = v_verification_key
                 and is_active = 1 and is_deleted = 0;
						
						if v_is_verified = 1 then
                     	   v_status := 2 ;
                     	   v_message := 'Kindly proceed to update your profile.';
                		else
                           
                     		update isl.isl_web_user
                     		set is_verified = 1, is_login = 0, ipaddress = v_ipaddress, updated_date = v_current_timestamp
                     		where client_id = 5 and verification_key = v_verification_key
                     		and is_active = 1  and is_deleted = 0
;

                     		v_status := 2 ;
                     		v_message := 'Verification Successful. Kindly proceed to update your profile.';
                		end if;
		exception when no_data_found then 
		--p_result :=11111;
				v_status := 0 ;
				v_message := 'Verification failed. Please check the link or try again later.';  
		end ;
	v_is_first_login := 0;
	v_is_login := 0 ;
	insert into isl.isl_web_user_audit
	(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
	select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

	p_result := 1  ;
	p_ures_json := '{
				 "data": {
				 "user_guid": "'||coalesce(v_user_guid,'')||'",
				 "status": "'|| v_status ||'",
				 "message": "'||v_message || '",
				 "error": {
				 	"code": null,
				 	"message": null
				 },
				 "user": {
				   "name": "",
					"favourite_club" : "'||coalesce(v_favourite_club,'') ||'",
					"edition" : "'||coalesce(v_edition,'') ||'",
				 	"social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"},
				 	"is_first_login": "'|| v_is_first_login || '",
				 	"is_app": '|| coalesce(v_is_app,0) ||',
				 	"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"
				 }}' ;
end if ;

/* Custom Login Email Verification */
if p_opttype = 4 then
 		begin
			select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image
            into strict v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
            v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image
			from isl.isl_web_user
			where upper_email_id = v_upper_email_id
   			and client_id = v_client_id 
			and user_password = v_user_password;
					
					if coalesce(v_is_deleted,0) = 1 and v_is_active = 0 then
						v_status := 7 ;
						v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
						v_is_first_login := 0;
					else -- check user is verified or not 
					
						if ( v_is_verified != 1) then
							v_status := 3 ;
							v_message :=  'Verification Required. A verification email has been sent to your registered email address. Please check your inbox to complete the registration.';
							v_user_guid := v_verification_key;
						else
						    if v_user_full_name is null then
								v_status := 2 ;
								v_message := 'Incomplete Profile. Name and Email are required to proceed.';
							else
								if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then
									update isl.isl_web_user  
									set  failed_attempts = 0, unlock_date = null, updated_date = v_current_timestamp,
										 ipaddress = v_ipaddress
									where upper_email_id = v_upper_email_id and client_id = v_client_id;
									
									v_status := 1 ;
									v_message := 'Login Successful';
								else
									
									v_status := 0 ;
									v_message := 'This account has been locked. Please try again after 24 hrs.';
									
									v_user_guid := '';
									v_user_full_name := '';
									
								end if;
							end if;	
						end if;
					end if;
			
		exception when no_data_found then 
			begin 
				select 1 into strict v_cnt
				from isl.isl_web_user
 				where client_id =v_client_id
				and upper_email_id =v_upper_email_id ;
			
				select coalesce(failed_attempts,0) +1 into v_failed_attempts
				from isl.isl_web_user
				where upper_email_id = v_upper_email_id
				and client_id = v_client_id  ;
					
					if v_failed_attempts >= 3 then            

						v_unlock_date = v_current_timestamp + interval '24 hours' ;
						update isl.isl_web_user  
						set  failed_attempts = failed_attempts + 1,
							 unlock_date = v_unlock_date ,
							 updated_date = v_current_timestamp,
							 ipaddress = v_ipaddress
						where upper_email_id = v_upper_email_id and client_id = v_client_id;

						v_status := 0 ;
						v_message := 'Too many failed attempts. The account has been locked. Please try again after 24 hrs.';
					else
						update isl.isl_web_user
						set  failed_attempts = failed_attempts + 1, updated_date = v_current_timestamp ,
							 ipaddress = v_ipaddress
						where upper_email_id = v_upper_email_id and client_id = v_client_id;

						v_status := 0 ;
						v_message := 'Incorrect credentials. Please check the credentials and try again.';
					end if ;
			exception when no_data_found then 
			     v_status := 0 ;
                 v_message := 'User doesn''t exists.';
			end ;
		end;
		insert into isl.isl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('isl.seq_isl_web_user_audit_id'), v_user_id, v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

		p_result := 1  ;
		p_ures_json := '{
 							"data": {
									"user_guid": "' || coalesce(v_user_guid,'')||'" ,
									"status": "'|| v_status ||'",
									"message": "'||v_message || '",
									"error": {
											"code": null,
											"message": null
											},
									"failed_attempts": '|| coalesce(v_failed_attempts,0) || ',
									"unlock_date":   "'||coalesce(v_unlock_date::varchar,'null')||'",
									"user": {
 											"name": "'|| coalesce(v_user_full_name,'')||'",
                                      		"favourite_club" : "'||coalesce(v_favourite_club,'') ||'",
                                      		"edition" : "'||coalesce(v_edition,'') ||'" ,
  											"social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"
											},
									"is_first_login": "'|| v_is_first_login || '",
									"is_app": '|| v_is_app ||',
									"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"
									}
									}' ;
end if ;

/*Custom Login Forget Password */
if p_opttype = 5 then 
  begin
  		select 1 into strict v_cnt
  		from isl.isl_web_user
  		where client_id = v_client_id and upper_email_id = v_upper_email_id ;
		
		v_status := 4 ;
		v_key_expiry_date := v_current_timestamp + interval '24 hours ' ;
		v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
		
		select is_verified, verification_key into v_is_verified, v_verification_key
        from isl.isl_web_user
        where client_id = v_client_id and upper_email_id = v_upper_email_id ;
			if v_is_verified = 1 then
				update isl.isl_web_user  
				set reset_key = v_reset_key,
					token = v_token,
					key_expiry_date = v_key_expiry_date,
					reset_key_status = 1,
					epoch_timestamp = v_epoch_timestamp,
					ipaddress = v_ipaddress,
					updated_date = v_current_timestamp
				where upper_email_id = v_upper_email_id and client_id = v_client_id;
				v_message := 'Password Reset link has been sent to your registered email address. Kindly check your inbox for further details. The link is valid up to 24 hrs.';
			else 
				v_status := 3 ;
                v_message :=  'Verification Required. A verification email has been sent to your registered email address. Please check your inbox to complete the registration.';
                v_user_guid := v_verification_key;
			
			end if;
  exception when no_data_found then 
   v_status := 0 ;
   v_message := 'Invalid email address. Please provide your registered email address and try again.';
  end ;
  insert into isl.isl_web_user_audit
(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
      
  p_result := 1  ;
  p_ures_json := '{
				 "data": {
						"user_guid": "",
						"status": "'|| v_status ||'",
						"message": "'||v_message || '",
						"error": {
								"code": null,
								"message": null
								},
						"user": {
				 				"name": ""
								},
						"is_first_login": "'|| v_is_first_login || '",
						"is_app": '|| v_is_app ||'
				 		}
					}' ;

end if;

/*p_opttype = 6 Custom Login Update Password */

if p_opttype = 6 then
		begin 
			  select user_guid, user_full_name, key_expiry_date , favourite_club, edition,  profile_picture_url, is_custom_image
              into strict v_user_guid, v_user_full_name, v_key_expiry_date, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image
              from isl.isl_web_user
			  where client_id = v_client_id            
              and reset_key = v_reset_key;
			  
			  if v_key_expiry_date > v_current_timestamp   then
                 v_status := 1;
				 
				update isl.isl_web_user  
				set old_password = user_password,
					user_password = v_user_password,
					failed_attempts = 0,
					updated_date = v_current_timestamp,
					reset_key = null,
					reset_key_status = 0,
					unlock_date = null,                    
					verification_key = null
				where client_id = v_client_id
				and reset_key = v_reset_key
				and key_expiry_date >= v_current_timestamp;

				v_message :=  'Password has been updated.';      
			   else 
			   v_status := 6 ;
			   v_message := 'Password reset token has expired. Please raise another request.';

			  end if;
		exception when no_data_found then 
		v_status := 6 ;
		v_message := 'Invalid token. Please check the link and try again.';
		end;
		insert into isl.isl_web_user_audit
 		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
		select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

		p_result := 1  ;
		p_ures_json := '{
						 "data": {
						"user_guid": "' ||coalesce(v_user_guid,'')||'",
						"status": "'|| v_status ||'",
						"message": "'||v_message || '",
						"error": {
						"code": null,
						"message": null
						},
						"user": {
						 			"name": "' || coalesce(v_user_full_name,'')||'",
									"favourite_club" : "'||coalesce(v_favourite_club,'') ||'",
									"edition" : "'||coalesce(v_edition,'') ||'",
						  			"social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"
						},
						"is_first_login": "'|| coalesce(v_is_first_login,0) || '",
						"is_app": '|| coalesce(v_is_app,0) ||',
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"
						 }
						}' ;

end if;

/* p_opttype = 7 Get User */
if p_opttype = 7 then
	begin
		 	select  user_id, email_id, mobile_no, user_full_name, social_user_name, dob, favourite_club, edition, gender, city , is_deleted,
				profile_picture_url , is_custom_image, is_active,favourite_player_id
            into strict  v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted,
				v_profile_picture_url, v_is_custom_image, v_is_active,v_favourite_player_id
            from isl.isl_web_user
            where user_guid = v_user_guid;
			
			v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
			
			if  v_is_deleted = 1 and v_is_active = 0  then
				 v_status = 7 ;
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
				update isl.isl_web_user set token = v_token, epoch_timestamp = v_epoch_timestamp
				where user_guid = v_user_guid;  
				
				if ((v_user_full_name is null) or (v_email_id is null)) then
					v_message := 'Incomplete Profile. Name and Email are required to proceed.';
					v_status := 2 ;
				else
					v_message :=  'Success';  
					v_status := 1 ;
				end if;
			end if;
	exception when no_data_found then 
	  v_status := 0;
      v_message := 'Unable to locate user information.'; 
	end ;
			insert into isl.isl_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

		p_result := v_user_id  ;
		p_ures_json :='{
                  "data": {
                    "user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "token": "'|| coalesce(v_token,'') ||'",
                    "epoch_timestamp": "'||coalesce(v_epoch_timestamp,'')||'" ,
                    "email_id": "'|| coalesce(v_email_id,'')||'",
                    "status": '|| v_status ||',
                    "message": "'||v_message ||'",
                    "error": {
                        "code": '|| v_status ||',
                        "message": "'||v_message ||'"
                    },
                    "user": {
                      "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
                      "name": "'||coalesce(v_user_full_name,'') ||'",
                      "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
                      "dob": "'|| coalesce(v_dob::varchar,'') ||'",
                      "gender": "'|| coalesce(v_gender,'') ||'",
                      "city": "'|| coalesce(v_city,'')||'",
                      "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
                      "favourite_player_id": "'||coalesce(v_favourite_player_id::varchar,'') ||'",
                      "edition": "'|| coalesce(v_edition,'') ||'",
                      "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"
                    },
                    "is_first_login": 0,
                    "is_app": "'|| coalesce(v_is_app,0) || '" ,
					"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"
                  }
                }';
end if;
/* p_opttype = 8 Update User  */
if p_opttype = 8 then
  begin 
  	select is_active, is_deleted into v_is_active, v_is_deleted
	from isl.isl_web_user where user_guid = v_user_guid ;
		if  v_is_deleted = 1 and v_is_active = 0  then
			v_status = 7 ;

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
		  begin 
		  	select 1 into strict v_cnt from isl.isl_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0
			and token =  v_token and epoch_timestamp = v_epoch_timestamp;
			
			v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
			select email_id, is_custom_image, profile_picture_url
			into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url
			from isl.isl_web_user
			where user_guid = v_user_guid
			and is_active = 1 and is_deleted = 0;
				if (v_is_custom_image_tab = 0  or v_profile_picture_url is null) then

				v_old_profile_image_url := '';

				end if;
				if coalesce(v_emailid_ex,'') = '' then

					update isl.isl_web_user
					set     social_user_name = v_social_user_name,
					user_full_name = v_user_full_name,
					email_id = v_email_id,
					upper_email_id = v_upper_email_id,
					dob =  v_dob,
					profile_picture_url = (case when  v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),
					city = v_city,
					mobile_no = v_mobile_no,
					-- user_bio = ,
					updated_date = v_current_timestamp,
					gender = v_gender ,
					favourite_club = v_favourite_club,
													favourite_player_id = v_favourite_player_id,
					token =  v_token,
					epoch_timestamp = v_epoch_timestamp ,
					ipaddress = v_ipaddress,
					edition =  v_edition,
					is_custom_image = (case when  v_is_custom_image = 1 then v_is_custom_image else is_custom_image end)
					  -- , is_verified = 1
					where user_guid = v_user_guid
					and is_active = 1 and is_deleted = 0
					returning user_id into v_user_id ;

					v_status := 1;
					v_message := 'Profile updated successfully.';
				else 
					if v_upper_email_id !=  v_emailid_ex then  

						v_status := 0;
						v_message := 'Unrecognized user.';

					else

						update isl.isl_web_user
						set     social_user_name = v_social_user_name,
								user_full_name = v_user_full_name,
								dob =  v_dob,
								profile_picture_url = (case when  v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),
								city = v_city,
								mobile_no = v_mobile_no,
								updated_date = v_current_timestamp,
								gender = v_gender ,
								favourite_club = v_favourite_club,
								favourite_player_id = v_favourite_player_id,
								token =  v_token,
								epoch_timestamp = v_epoch_timestamp ,
								ipaddress = v_ipaddress,
								edition =  v_edition,
								is_custom_image = (case when  v_is_custom_image = 1 then v_is_custom_image else is_custom_image end)
				  
						where user_guid = v_user_guid
						and is_active = 1 and is_deleted = 0
						returning user_id into v_user_id ;

						v_status := 1;
						v_message := 'Success';  
					end if;
				end if;

			exception when no_data_found then 
				v_status := 0;
				v_message := 'Token mismatch.';
				
		  end ;
		end if;
  exception when no_data_found then 
  		v_status := 0;
		v_message := 'Unable to locate user information.'; 
  end ;
  		         
       	  insert into isl.isl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

		  p_result := coalesce(v_user_id,1)  ;
		  p_ures_json = '{
		 					"data": {
									"user_guid": "'||coalesce(v_user_guid,'')||'",
									"status": '|| v_status ||',
									"message": "'|| v_message||'",
									"error": {
												"code": '|| v_status ||',
												"message":  "'|| v_message||'"
											  },
									"user": {
		 							"name": "'|| coalesce(v_user_full_name,'') ||'"
											},
									"is_first_login": 0,
									"is_app": "'|| coalesce(v_is_app,0) || '",
									"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"  ,
									"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"
									 }
									}' ;

end if;
/* Update User  and return user data  */
if p_opttype = 9 then
		begin
			select is_active, is_deleted into strict v_is_active, v_is_deleted
			from isl.isl_web_user where user_guid = v_user_guid ;
				if  v_is_deleted = 1 and v_is_active = 0  then
					v_status = 7 ;
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
				  begin
				
					select 1 into strict v_cnt 
					from isl.isl_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0
					and token =  v_token and epoch_timestamp = v_epoch_timestamp ;
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
					
					select email_id, is_custom_image, profile_picture_url
					into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url
					from isl.isl_web_user
					where user_guid = v_user_guid
					and is_active = 1 and is_deleted = 0 ;
					
					if (v_is_custom_image_tab = 0  or v_profile_picture_url is null) then

					v_old_profile_image_url := '';

					end if;
					
					if coalesce(v_emailid_ex,'') = '' then

						update isl.isl_web_user
						set     social_user_name = v_social_user_name,
						user_full_name = v_user_full_name,
						email_id = v_email_id,
						upper_email_id = v_upper_email_id,
						dob =  v_dob,
						profile_picture_url = (case when v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),  
						city = v_city,
						mobile_no = v_mobile_no,
						updated_date = v_current_timestamp,
						gender = v_gender ,
						favourite_club = v_favourite_club,
						favourite_player_id = v_favourite_player_id,
						token =  v_token,
						epoch_timestamp = v_epoch_timestamp ,
						ipaddress = v_ipaddress,
						edition =  v_edition,
						is_custom_image = (case when v_is_custom_image = 1 then v_is_custom_image else is_custom_image end)
						where user_guid = v_user_guid
						and is_active = 1 and  is_deleted = 0
						returning user_id into v_user_id ;

						v_status := 1;
						v_message := 'Profile updated successfully.';
					else
						if v_upper_email_id !=  v_emailid_ex then  

								v_status := 0;
								v_message := 'Unrecognized user.';

						else

								update isl.isl_web_user
								set     social_user_name = v_social_user_name,
								user_full_name = v_user_full_name,
								-- email_id = v_email_id,
								-- upper_email_id = v_upper_email_id,
								dob =  v_dob,
								profile_picture_url =  (case when v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),
								city = v_city,
								mobile_no = v_mobile_no,
								updated_date = v_current_timestamp,
								gender = v_gender ,
								favourite_club = v_favourite_club,
																	favourite_player_id = v_favourite_player_id,
								token =  v_token,
								epoch_timestamp = v_epoch_timestamp ,
								ipaddress = v_ipaddress,
								edition =  v_edition,
								is_custom_image = (case when v_is_custom_image = 1 then v_is_custom_image else is_custom_image end)
								  -- , is_verified = 1
								where user_guid = v_user_guid
								and is_active = 1
								returning user_id into v_user_id ;

								v_status := 1;
								v_message := 'Success';
						end if;
					
					end if;
				  exception when no_data_found then 
				  	v_status := 0;
					v_message := 'Token mismatch.';
				  end ;
				end if;
			
		exception when no_data_found then 
			v_status := 0;
			v_message := 'Unable to locate user information.';  
		end ;
		
		insert into isl.isl_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

		p_result := coalesce(v_user_id,1)  ;
		p_ures_json = '{
		 				"data": {
								"user_guid": "'||coalesce(v_user_guid,'')||'",
								"token": "'|| coalesce(v_token,'') ||'",
								"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
								"email_id": "'|| coalesce(v_email_id,'') ||'",
								"status": '|| v_status ||',
								"message": "'|| v_message||'",
								"error": {
										"code": '|| v_status ||',
										"message":  "'|| v_message||'"
										},
								"user": {
										 "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
		 								 "name": "'||coalesce(v_user_full_name,'') ||'",
		 								"social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
										 "dob": "'|| coalesce(v_dob::varchar,'') ||'",
										 "gender": "'|| coalesce(v_gender,'') ||'",
										 "city": "'|| coalesce(v_city,'')||'",
		 								"favourite_club": "'||coalesce(v_favourite_club,'') ||'",
								  		"favourite_player_id": "'||coalesce(v_favourite_player_id::varchar,'') ||'",
										 "edition": "'|| coalesce(v_edition,'') ||'",
								  			"social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"
										},
								"is_first_login": 0,
								"is_app": '|| coalesce(v_is_app,0) ||' ,
								"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
								"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"
								 }
								}' ;
end if;
/* p_opttype = 10 User deleted */
if p_opttype = 10 then
	begin 
		select 1 into strict v_cnt from isl.isl_web_user
		where user_guid = v_user_guid and is_active = 1 and is_deleted  = 0
        and token =  v_token and epoch_timestamp = v_epoch_timestamp;
		
		   select email_id into v_email_id
           from isl.isl_web_user
           where user_guid = v_user_guid
           and is_active = 1 ;
		   
		   	update isl.isl_web_user 
			set  is_active  = 0 ,
            	is_deleted =  1, updated_date = v_current_timestamp
            where user_guid = v_user_guid and is_active = 1
            and token =  v_token and epoch_timestamp = v_epoch_timestamp ;
            
			insert into isl.isl_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

			v_status := 1;
            v_message := 'We have initiated the request to delete your information from our system. The process may take up to 72 hours to remove all information from our systems.';  

	exception when no_data_found then 
		v_status := 0;
        v_message := 'Unknown request.';  
	end ;
	
		p_result := 1  ;        
        p_ures_json := ' {
                          "data": {
                            "user_guid": "",
                            "email_id" : "'|| coalesce(v_email_id,'') ||'" ,
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,
                            "error": {
									"code": "",
									"message":  ""
									},
                            "user": { "name": ""
                                    },
                              "is_first_login": '|| coalesce(v_is_first_login,0) ||'
                            , "is_app": '|| coalesce(v_is_app,0) ||'
                           }
                       }' ;

end if;

/* Do User Active and Login */

    if p_opttype = 11 then   -- p_opttype = 11 Do User Active and Login
       
if (v_user_guid is not null and v_is_active = 1 and v_is_deleted  = 0) then

if v_client_id = 5 then

select failed_attempts , unlock_date, is_verified, user_full_name , verification_key,
favourite_club, edition, email_id, profile_picture_url , is_custom_image
into v_failed_attempts,  v_unlock_date, v_is_verified,  v_user_full_name, v_verification_key,
v_favourite_club, v_edition, v_email_id , v_profile_picture_url, v_is_custom_image
from isl.isl_web_user
where user_guid = v_user_guid
-- and is_active = 1
and client_id = v_client_id  ;

update isl.isl_web_user set is_active = v_is_active, is_deleted = v_is_deleted, updated_date = v_current_timestamp
where user_guid = v_user_guid
-- and is_active = 1
and client_id = v_client_id ;

if ( v_is_verified != 1) then -- check user is verified or not      
v_status := 3 ;
v_message :=  'Verification Required. A verification email has been sent to your registered email address. Please check your inbox to complete the registration.';
v_user_guid := v_verification_key;

   else
if v_user_full_name is null then
v_status := 2 ;
v_message := 'Incomplete Profile. Name and Email are required to proceed.';

else
if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then

update isl.isl_web_user  
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
-- end if;

                 p_ures_json := '{
 "data": {
"user_guid": "' || coalesce(v_user_guid,'')||'" ,
                            "email_id" : "'|| coalesce(v_email_id,'') ||'" ,
"status": "'|| v_status ||'",
"message": "'||v_message || '",
"error": {
"code": null,
"message": null
},
"failed_attempts": '|| coalesce(v_failed_attempts,0) || ',
"unlock_date":   "'||coalesce(v_unlock_date::varchar,'null')||'",
"user": {
 "name": "'|| coalesce(v_user_full_name,'')||'",
                                      "favourite_club" : "'||coalesce(v_favourite_club,'') ||'",
                                      "edition" : "'||coalesce(v_edition,'') ||'",
 "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"  
},
"is_first_login": "'|| v_is_first_login || '",
"is_app": '|| coalesce(v_is_app,0) ||' ,
"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"

 }
}' ;

else

select email_id, user_full_name, user_id, favourite_club, edition,  profile_picture_url, is_custom_image
                into v_email_id, v_user_full_name, v_user_id , v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image
                from isl.isl_web_user
                where user_guid = v_user_guid
                -- and is_active = 1
;
               
update isl.isl_web_user set is_active = v_is_active, is_deleted = v_is_deleted, updated_date = v_current_timestamp
                where user_guid = v_user_guid
                -- and is_active = 1
;

if v_email_id is null or v_user_full_name is null
then                            
v_status = 2 ;
v_message := 'Incomplete Profile. Name and Email are required to proceed.';
v_is_first_login := 1;  
else                
v_status = 1 ;
v_message := 'Login Successful';
end if ;

                 p_ures_json := ' {
                          "data": {
                            "user_guid": "'|| v_user_guid ||'",
                            "email_id" : "'|| coalesce(v_email_id,'') ||'" ,
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,  
                            "error": { "code": null,
                                       "message": null
                             },
                            "user": { "name": "'|| coalesce(v_user_full_name,'') ||'",
                             "favourite_club" : "'||coalesce(v_favourite_club,'') ||'",
                                      "edition" : "'||coalesce(v_edition,'') ||'",
 "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'"  
                                    },
                            "is_first_login": '|| v_is_first_login ||',
"is_app": '|| coalesce(v_is_app,0) ||',
"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'"
                           }
                       }' ;
       
end if;
           

else

v_status := 0 ;
v_message := 'Fail' ;

             p_ures_json := ' {
                          "data": {
                            "user_guid": "",                            
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,
                            "error": {
							"code": "",
							"message":  ""
								},
                            "user": { "name": ""
                                    },
                            "is_first_login": '|| coalesce(v_is_first_login,0) ||'
                            , "is_app": '|| coalesce(v_is_app,0) ||'
                           }
                       }' ;
end if ;

        insert into isl.isl_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

  p_result := 1  ;            

end if;
-- for User Logout

if p_opttype = 12 then 
	begin 
	select 1 into strict v_cnt 
	from isl.isl_web_user where user_guid = v_user_guid;
	
	        insert into isl.isl_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
            select nextval('isl.seq_isl_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
           
            v_status := 1;
             v_message := 'Logout Successful';
	exception when no_data_found then 
			v_status := 0;
            v_message := 'Unknown request.';
	
	end ;

p_ures_json := ' {
                          "data": {
                            "user_guid": "",                            
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,
                            "error": {
"code": "",
"message":  ""
},
                            "user": { "name": ""
                                    },
                            "is_first_login": '|| coalesce(v_is_first_login,0) ||'
                            , "is_app": '|| coalesce(v_is_app,0) ||'
                           }
                       }' ;
                       
    p_result := 1  ;  
   
end if;

exception
    when others then
   v_err_code := SQLSTATE;
          v_err_msg := SQLERRM;
 p_result := -1;
 p_ures_json := '{
 "data": {
"user_guid": "",          
"status": "",
"message": "",
"error": {
"code": "'||coalesce(v_err_code,'')||'",
"message": "'|| coalesce(v_err_msg,'') ||'"
},
"user": {
 "name":""
},
"is_first_login": "'|| coalesce(v_is_first_login,0) || '",
"is_app": '|| coalesce(v_is_app,0) ||'
 }
}';
end;
$$;


--
