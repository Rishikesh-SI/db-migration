-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labw88
-- Object: labw88_get_user(jsonb)
-- Type: FUNCTION

-- Name: labw88_get_user(jsonb); Type: FUNCTION; Schema: labw88; Owner: -
--

CREATE FUNCTION labw88.labw88_get_user(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
    --v_created_date timestamp without time zone;
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
   v_ext_info jsonb;
   v_created_date character varying;
   v_membership_code character varying;
begin
 v_current_timestamp := current_timestamp at time zone 'utc';
    select p_user_json->'data'->>'user_guid'
          /* p_user_json->'data'->>'token',
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
		   p_user_json->'data'->'user'->>'city_id'*/
		  
    into   v_user_guid
           /*v_token,
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
			v_city_id*/
           ;
   		
        --v_upper_email_id := v_email_id;
        v_updated_date := v_current_timestamp;
    	if exists (select 1 from labw88.labw88_web_user where user_guid = v_user_guid )
        then
        	v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
            raise notice 'P1 : %' , v_epoch_timestamp;
        	select  user_id, email_id, mobile_no, user_full_name, social_user_name, dob, favourite_club, edition, gender, city , is_deleted,
					profile_picture_url , is_custom_image, is_active ,created_date,client_id,mobile_no
            into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted,
				 v_profile_picture_url, v_is_custom_image,
				v_is_active,v_created_date,v_client_id,v_mobile_no
            from labw88.labw88_web_user a
            where user_guid = v_user_guid ;
			
			/*if  v_is_deleted = 1 and v_is_active = 0  then
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
				
				update labw88.labw88_web_user set token = v_token, epoch_timestamp = v_epoch_timestamp
				where user_guid = v_user_guid
				-- and is_active = 1	
				;
			
				if ((v_first_name is null) or (v_last_name is null) or (v_email_id is null) or (v_mobile_no is null)) then
					v_message := 'Incomplete Profile';		
					v_status := 2 ;
				else
					v_message :=  'Success';   		
					v_status := 1 ;
				end if;
				
			end if;	*/
			--if ( (v_email_id is not null) or (v_mobile_no is null)) then 
			/*
					v_message := 'Incomplete Profile';		
					v_status := 2 ;
				--else
				*/
					v_message :=  'Success';   		
					v_status := 1 ;
				--end if;
        else
        	v_status := 0;
            v_message := 'Unable to locate user information.';  	
        end if;
	
p_ures_json = '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"created_date": "'|| coalesce(v_created_date,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"client_id": "'||coalesce(v_client_id,0)||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'"
						},
						"is_first_login": 0,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ;
					
					p_ures_json:=jsonb_set(p_ures_json, '{data,user,ext_info}',coalesce(v_ext_info,'null'), true);
end;
$$;


--
