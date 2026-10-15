-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_custom_login_email_verification(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_v1_custom_login_email_verification(jsonb); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_custom_login_email_verification(p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
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
	v_address text;
	v_profile_completion_percentage numeric;
    v_reg_cnt numeric:=0;
   	v_gift_id numeric:=0;
   	v_gift_name varchar(500):='NO GIFT';
   	v_gratification_value numeric;
   	v_profile_complete numeric;
   	v_better_luck_value numeric;
	v_gift_url text;
	v_other_gift_count numeric;
	v_other_gift_percentage numeric;
	v_total_gift_count numeric;
	v_profile_completion numeric;
	v_first_name character varying;
	v_last_name character varying;
	v_jersey_number numeric;
	v_subscribe_for_email boolean;
	v_otp numeric;
    v_tempotp varchar(20);
	v_social_connectjson jsonb;
	v_country_id numeric;
	v_previous_subscription_key varchar(100);
	v_membership_code text;
	v_pincode character varying;
	v_state_id  numeric;
	
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
		  p_user_json->'data'->'user'->>'favourite_player_id',
		  p_user_json->'data'->'user'->>'address',
		  p_user_json->'data'->'user'->>'profile_completion_percentage',
		  p_user_json->'data'->'user'->>'first_name',
		  p_user_json->'data'->'user'->>'last_name',
		  p_user_json->'data'->'user'->>'jersey_number',
		  p_user_json->'data'->'user'->>'subscribe_for_email',
	--	  p_user_json->'data'->>'otp',
		  p_user_json->'data'->>'mobile_otp',
		  p_user_json->'data'->'user'->>'country_id',
		  p_user_json->'data'->'user'->>'membership_code',
		  p_user_json->'data'->'user'->>'state_id',
		  p_user_json->'data'->'user'->>'pincode'
 
 
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
		  v_favourite_player_id,
		  v_address,
		  v_profile_completion_percentage,
		  v_first_name,
		  v_last_name,
		  v_jersey_number,
		  v_subscribe_for_email,
	--	 v_otp,
		  v_tempotp,
		  v_country_id,
		  v_membership_code,
		  v_state_id,
		  v_pincode
		  ;

		/*  if v_otp = '' then
		  if v_otp is null then
		  v_otp = coalesce(v_otp,0);
		  end if;
		  coalesce(v_otp,0)*/
		
		  if coalesce(v_tempotp,'') != '' then
		v_otp:=v_tempotp::int;
		end if;
   	
   	v_opt_type:=3;
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
    /* ****************************************
      Client_id     Client 
      1             Facebook
      2             Twitter
      4             Google+
      5	            Custom
    ****************************************  */
   insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'custom_email','logs',uuid_generate_v4(),p_user_json,current_timestamp,'labmcfc_v1','logs');
   
	
    
        /* if v_client_id = 4 then 
           if exists( select 1 from labmcfc_v1.labmcfc_v1_web_user where email_id = v_email_id
                          and client_id = v_client_id) then 
            update labmcfc_v1.labmcfc_v1_web_user
           set social_id = v_social_id
           where email_id = v_email_id and client_id = 4 ;
           
           end if;
          escipnd if;*/

    if exists(select 1 from labmcfc_v1.labmcfc_v1_web_user where client_id = 5 and verification_key = v_verification_key and is_active = 1 and is_deleted = 0 )
            then 
            select user_guid, is_verified, favourite_club, edition,  profile_picture_url , is_custom_image,
					email_id,user_full_name,mobile_no,subscribe_for_email
             into v_user_guid, v_is_verified, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image,
				 	v_email_id,v_user_full_name,v_mobile_no,v_subscribe_for_email
             from labmcfc_v1.labmcfc_v1_web_user
              where client_id = 5 and verification_key = v_verification_key 
              and is_active = 1 and is_deleted = 0;
                 
				 
            /*if v_is_verified = 1 then
                     v_status := 2 ;
                     v_message := 'Kindly proceed to update your profile.';
                else*/
                           
                     update labmcfc_v1.labmcfc_v1_web_user 
                     set is_verified = 1, is_login = 0, ipaddress = v_ipaddress,
					 updated_date = v_current_timestamp,
					 verification_key=null
                     where client_id = 5 and verification_key = v_verification_key 
                     and is_active = 1  and is_deleted = 0;

                     /*v_status := 2 ;
                     v_message := 'Verification Successful. Kindly proceed to update your profile.';
                end if;*/
				
				 v_status := 1;
				 --v_message := 'Verification Successful.';
				 v_message := 'Email Sent Successfully';
				 v_is_first_login := 1;
				 
else
v_status := 0 ;	
v_is_first_login := 0;
v_is_login := 0 ;
--v_message := 'Verification failed. Please check the link or try again later.'; 
v_message := 'Email Sent Successfully';
end if ; 
/*v_is_first_login := 0;
v_is_login := 0 ;*/	

             insert into labmcfc_v1.labmcfc_v1_web_user_audit
(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
select nextval('labmcfc_v1.seq_labmcfc_v1_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, v_opt_type, v_current_timestamp, coalesce(v_is_app,0) ;

                      
    

    p_result := 1  ;
	
	p_ures_json = '{
						 "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"created_date": "'|| coalesce(v_created_date::varchar,'') ||'",
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
								 "first_name": "'|| coalesce(v_first_name,'') ||'",
								 "last_name": "'|| coalesce(v_last_name,'') ||'",
								 "dob": "'|| coalesce(v_dob::varchar,'') ||'",
								 "gender": "'|| coalesce(v_gender,'') ||'",
								 "city": "'|| coalesce(v_city,'')||'",
								 "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
								  "favourite_player_id": "'||coalesce(v_favourite_player_id::varchar,'0') ||'",
								  "jersey_number": "'||coalesce(v_jersey_number::varchar,'0') ||'",
								  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
								   "membership_code": "'|| coalesce(v_membership_code,'') ||'",
								 "edition": "'|| coalesce(v_edition,'') ||'",
								 "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'" ,
								  "country_id": "'||coalesce(v_country_id::varchar,'') ||'",
								  "previous_subscription_key": "'||coalesce(v_previous_subscription_key::varchar,'false') ||'",
								 "profile_completion_percentage": "'|| coalesce(v_profile_completion_percentage::varchar,'') ||'",
								 "pincode": "'|| coalesce(v_pincode,'') ||'",
								 "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
								 
								  "campaign_json":{}
								
								},
						"is_first_login":' ||coalesce(v_is_first_login,0)||',
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						 "old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"	,
						 "client_id": '||coalesce(v_client_id,0) ||'
						
						 }
					}' ;
					
					p_ures_json:=jsonb_set(p_ures_json, '{data,user,campaign_json,social_connet}',coalesce(v_social_connectjson,'[]'), true);

-----------------	
/*
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
      --  v_json :=  jsonb_set(to_jsonb(v_json), '{data,error,code}', ('"'||v_1||'"')::jsonb, true);
       -- return	; 
   */   
end;
$$;


--
