-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_update_user_and_return_user_data(jsonb)
-- Type: FUNCTION

-- Name: labdv_update_user_and_return_user_data(jsonb); Type: FUNCTION; Schema: labdv; Owner: -
--

CREATE FUNCTION labdv.labdv_update_user_and_return_user_data(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
	 v_country_code character varying;
	 v_platform_version character varying;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
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
			p_user_json->'data'->>'option_type'
			
    
           
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
			v_option_type
           ;
   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
		v_option_type:=9;
		
		  if coalesce(v_tempotp,'') != '' then
		v_otp:=v_tempotp::int;
		end if;
    /* ****************************************
      Client_id     Client 
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */
    
--if p_opttype = 9 then   -- p_opttype = 9 Update User  and return user data     
 
		if exists ( select 1 from labdv.labdv_web_user where user_guid = v_user_guid )
		then 
		   
        
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labdv.labdv_web_user where user_guid = v_user_guid ; 
			
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
           
				if exists (select 1 from labdv.labdv_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0)
							 --and epoch_timestamp = v_epoch_timestamp ) --and token =  v_token
				then 
             -- raise notice 'opttype 9 test 1 ';     
              			   	                   
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
										
								
					select email_id, is_custom_image, profile_picture_url,d.name , s.name,c.name,a.user_id,
					client_id
					into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url,v_country_name,v_state_name,v_city_name,v_waf_user_id,
					v_client_id					
					from labdv.labdv_web_user a
					left join waf_master.waf_cities c on a.city_id=c.city_id
					left join waf_master.waf_states s on a.state_id=s.state_id
					left join waf_master.waf_countries d on a.country_id=d.country_id
					where user_guid = v_user_guid
					and is_active = 1 and is_deleted = 0 ; 
					
                 
					if (v_is_custom_image_tab = 0  or v_profile_picture_url is null) then 		
						
						v_old_profile_image_url := ''; 
					
					end if; 
				
				
						update labdv.labdv_web_user 
						set     social_user_name = v_social_user_name,
								user_full_name = v_user_full_name,
								--email_id = v_email_id,
								upper_email_id = v_upper_email_id,									
								dob =  v_dob,
								profile_picture_url = (case when v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),   
								city = v_city,
								mobile_no = v_mobile_no,	
								-- user_bio = ,	
								updated_date = v_current_timestamp,
								gender = v_gender ,					
								favourite_club = v_favourite_club,
								token =  v_token,
								epoch_timestamp = v_epoch_timestamp ,
								ipaddress = v_ipaddress,
								edition =  v_edition, 
								is_custom_image = (case when v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
								city_id=v_city_id,
								state_id=v_state_id,
								country_id=v_country_id,
								first_name=v_first_name,
								last_name=v_last_name,
								ext_info=v_ext_info,
								favourite_player_id=v_favourite_player_id,
								jersey_name=v_jersey_name,
								jersey_number=v_jersey_number,
								subscribe_for_email=v_subscribe_for_email,
								country_code=v_country_code,
								pincode=v_pincode,
								sync_status=0
								--membership_code=v_membership_code
							   -- , is_verified = 1
						where user_guid = v_user_guid 
						and is_active = 1 and  is_deleted = 0 
						returning user_id into v_user_id ; 
						
						v_status := 1;
						v_message := 'Profile updated successfully.';
/*						
					else
						if v_upper_email_id !=  v_emailid_ex then  		
							v_status := 0;
							v_message := 'Unrecognized user.';
							
						else
		                  
							update labdv.labdv_web_user 
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
									token =  v_token,
									epoch_timestamp = v_epoch_timestamp ,
									ipaddress = v_ipaddress,
									edition =  v_edition,
									is_custom_image = (case when v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
									city_id=v_city_id,
									state_id=v_state_id,
									country_id=v_country_id,
									first_name=v_first_name,
									last_name=v_last_name,
									ext_info=v_ext_info,
									favourite_player_id=v_favourite_player_id,
    								jersey_name=v_jersey_name,
									jersey_number=v_jersey_number,
									subscribe_for_email=v_subscribe_for_email,
									country_code=v_country_code,
									pincode=v_pincode,
									sync_status=0
									--membership_code=v_membership_code
				   -- , is_verified = 1
							where user_guid = v_user_guid 
							and is_active = 1
							returning user_id into v_user_id ; 
							
							v_status := 1;
							v_message := 'Success'; 	
						end if;
					end if ;	
*/				
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
		insert into labdv.labdv_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, audit_date, is_app,platform_version,platform_type,device_name,option_type)
		select nextval('labdv.seq_labdv_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress,v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_platform_type,v_device_name,v_option_type;
		

	
p_ures_json = '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						 "user_id": "'|| coalesce(v_waf_user_id,0) ||'" ,
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"client_id": '||coalesce(v_client_id,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
                        "updated_date": "'||v_updated_date||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_first_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
						  "favourite_player_id": "'||coalesce(v_favourite_player_id,'') ||'",
						  "jersey_name": "'|| coalesce(v_jersey_name,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" ,
						  "jersey_number": "'||coalesce(v_jersey_number,0) ||'",
						  "membership_code": "'||coalesce(v_membership_code,'') ||'",
						  "country_code": "'||coalesce(v_country_code,'') ||'"
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
