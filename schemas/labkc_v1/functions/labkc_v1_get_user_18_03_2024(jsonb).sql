-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_get_user_18_03_2024(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_get_user_18_03_2024(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_get_user_18_03_2024(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
   v_first_name character varying;
   v_last_name character varying;
   v_ext_info jsonb;
   v_created_date character varying;
   v_membership_code character varying;
   v_jersey_number numeric;
   v_favourite_player_id character varying;
   v_jersey_name character varying;
   v_subscribe_for_email boolean;
   v_country_code numeric;
   v_pincode character varying;
   v_email_verified numeric;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'user_guid'
    into   v_user_guid;
        v_updated_date := v_current_timestamp;   

	if exists(select 1 from labkc_v1.labkc_v1_web_user
				  where user_guid = v_user_guid and is_deleted=1) then
			  
			v_status := 500 ;
			v_message := 'Delete Profile Initiated.';
			
			  select  a.user_id, a.email_id, a.mobile_no, a.user_full_name, a.social_user_name, a.dob, a.favourite_club, 
				a.edition, a.gender, a.city , a.is_deleted, a.profile_picture_url , a.is_custom_image, 
				a.is_active ,a.favourite_player_id,a.client_id,
				a.first_name,a.last_name,a.jersey_number,subscribe_for_email ,a.created_date,membership_code,a.country_id,
                 s.name,a.state_id
				
            into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted, 
				v_profile_picture_url, v_is_custom_image, v_is_active,v_favourite_player_id
				,v_client_id,v_first_name,v_last_name,v_jersey_number,v_subscribe_for_email,v_created_date,v_membership_code,v_country_id,
                v_state_name,v_state_id
            from labkc_v1.labkc_v1_web_user a
            left join waf_master.waf_states s on s.state_id=a.state_id
            where user_guid = v_user_guid;

       
	 else
	
    	if exists (select 1 from labkc_v1.labkc_v1_web_user where user_guid = v_user_guid )
        then 
       
        	v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
           
           select  a.user_id, a.email_id, a.mobile_no, a.user_full_name, a.social_user_name, a.dob, a.favourite_club, 
				a.edition, a.gender, a.city , a.is_deleted, a.profile_picture_url , a.is_custom_image, 
				a.is_active ,a.favourite_player_id,a.client_id,
				a.first_name,a.last_name,a.jersey_number,subscribe_for_email ,a.created_date,membership_code,email_verified,jersey_name,country_code,a.country_id,
                s.name,a.state_id
				
            into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted, 
				v_profile_picture_url, v_is_custom_image, v_is_active,v_favourite_player_id
				,v_client_id,v_first_name,v_last_name,v_jersey_number,v_subscribe_for_email,v_created_date,v_membership_code,v_email_verified,v_jersey_name,
                v_country_code,v_country_id,v_state_name,v_state_id
            from labkc_v1.labkc_v1_web_user a
            left join waf_master.waf_states s on s.state_id=a.state_id
            where user_guid = v_user_guid;
			
			raise notice '%',v_city;
			 
		--	 raise notice 'v_country_code=%',v_country_code;

			if (v_first_name is null) or (v_last_name is null) or (v_email_id is null)--or v_country_id is null
			then
					v_message := 'Incomplete Profile';		
					v_status := 2 ;
				else
					v_message :=  'Success';   		
					v_status := 1 ;
				end if;
            
        else
        	v_status := 0;
            v_message := 'Unable to locate user information.';   		
                    
        end if; 
        
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
						"user_id": '||coalesce(v_user_id,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"email_verified": '|| coalesce(v_email_verified,0) ||',
						"mobile_verified": "1",	
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
						  "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
                          "city_id": "'|| coalesce(v_city_id::varchar,'')||'",
						  "membership_code": "'|| coalesce(v_membership_code,'')||'",
					      "state_name": "'|| coalesce(v_state_name,'')||'",
                          "state_id": "'|| coalesce(v_state_id::varchar,'')||'",
					      "country_name": "'|| coalesce(v_country_name,'')||'",
                          "country_id": "'|| coalesce(v_country_id::varchar,'')||'",
                          "country_code": "'|| coalesce(v_country_code,0)||'",						  
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
						  "subscribe_for_email": "'||coalesce(v_subscribe_for_email::varchar,'false') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'",
						  "jersey_number": "'|| coalesce(v_jersey_number,0)||'",
						  "favourite_player_id": "'|| coalesce(v_favourite_player_id,'')||'",
						  "jersey_name": "'||coalesce(v_jersey_name,'') ||'",
						  "pincode": "'||coalesce(v_pincode,'') ||'"
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
