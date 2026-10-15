-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_ins_upd_users_custom_registrastion_v1(jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_users_custom_registrastion_v1(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_ins_upd_users_custom_registrastion_v1(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
    v_reg_cnt numeric:=0;
   v_gift_id numeric:=0;
   v_gift_name varchar(500):='NO GIFT';
   v_gratification_value numeric;
   v_profile_complete numeric;
   v_better_luck_value numeric;
   v_first_name character varying;
   v_last_name character varying;
   v_address_1 character varying;
   v_address_2 character varying;
   v_pin_code character varying;
   v_campaign_id numeric;
   v_otp numeric;
   v_count numeric;
   -- v_campaign_json json;
   v_product_name character varying;
   v_expiry_date timestamp;
   v_status_1 numeric;
   v_product_cart_id numeric;
   v_shipment_data jsonb;
   v_remarks text;
   v_received_by character varying;
   v_courier_status character varying;
   v_aw_bill_number character varying;
   v_service_provider character varying;
   v_date_of_dispatch timestamp;
   v_invoice_link character varying;
   v_payment_guid character varying;
   v_attempt numeric;
   v_attempt_date timestamp;
   v_campaign_id_1 numeric;
   v_already_exists numeric;
   v_mobile_verified numeric;
   v_membership_owner text;
   v_name_on_card text;
   v_whatsapp_consent numeric;
   v_platform_id numeric;
   v_coupon_code character varying;
   v_old_campaign_id numeric;
   v_message_1 character varying;
   v_email_otp numeric;
   v_email_verified numeric;
  
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 
		select p_user_json->'data'->>'user_guid',
           p_user_json->'data'->>'token',
           p_user_json->'data'->>'epoch_timestamp',
           p_user_json->'data'->>'social_id',
           p_user_json->'data'->>'client_id', 
    	   p_user_json->'data'->>'email_id',
		   p_user_json->'data'->>'email_otp',
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
		   p_user_json->'data'->'user'->>'address_1',
		   p_user_json->'data'->'user'->>'address_2',
		   p_user_json->'data'->'user'->>'pincode',
		   p_user_json->'data'->>'otp',
		   p_user_json->'data'->>'campaign_id',
		   p_user_json->'data'->>'whatsapp_consent',
		   p_user_json->'data'->>'platform_id',
		   p_user_json->'data'->>'message'          
    into   v_user_guid,
           v_token,
           v_epoch_timestamp,
           v_social_id,
           v_client_id,
           v_email_id,
		   v_email_otp,
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
			v_address_1,
			v_address_2,
			v_pin_code,
			v_otp,
			v_campaign_id,
			v_whatsapp_consent,
			v_platform_id,
			v_message_1
			;
			
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
	
    v_client_id:=5;
    raise notice 'v_upper_email_id=%',v_upper_email_id;
	raise notice 'v_mobile_no=%',v_mobile_no;
    		if not exists(select 1 from labmi.labmi_web_user 
						  where client_id = v_client_id and ( upper_email_id = v_upper_email_id
						  or mobile_no = v_mobile_no)
						-- and is_active = 1
						 ) then 
				
				select is_verified into v_mobile_verified from labmi.labmi_otp_details
				where mobile_no = v_mobile_no and otp = v_otp and is_verified = 1;
				
				select is_verified into v_email_verified from labmi.labmi_otp_details
				where mobile_no = v_upper_email_id and otp = v_email_otp and is_verified = 1;
						 
				if v_mobile_verified = 1 and v_email_verified = 1  then		 
						 
                v_web_user_id := nextval('labmi.seq_labmi_web_users_id');
                v_user_guid := uuid_generate_v4();
                v_is_active := 1;
                v_is_deleted := 0; 
				v_is_verified = 0 ; 				
                v_created_date := v_current_timestamp;
                v_updated_date := v_current_timestamp;  				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                v_is_login := 0;			                
                  
                insert into labmi.labmi_web_user
                (user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
				is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by, 
                 favourite_club, edition, profile_picture_url , is_custom_image,user_full_name,mobile_no,city_id,state_id,country_id,gender,dob,
				 campaign_id,mobile_verified,membership_start_date,trans_guid,whatsapp_consent,platform_id,pin_code)
                select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, 1,1, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
                v_favourite_club, v_edition, 'Uiwo6dOG90psCEd7TmLLU3IbGQwEse7L9prbqEKa3fw=', 1,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id,v_gender,v_dob,
				v_campaign_id,1,v_current_timestamp,uuid_generate_v4(),v_whatsapp_consent,v_platform_id,v_pin_code ;
				                 
                v_is_first_login := 1;
				
				v_status := 1 ;	
				v_message := 'user Registered successfully.';
				
			  else
				
				v_status := 0 ;						
				v_message := 'mobile number or Email Id not verified.' ;
				
               end if;
			   
            else
            
				select is_verified, profile_picture_url , is_custom_image
				into v_is_verified,  v_profile_picture_url, v_is_custom_image
				from labmi.labmi_web_user 
				where client_id = v_client_id and ( upper_email_id = v_upper_email_id
						  or mobile_no = v_mobile_no)
				-- and is_active = 1 
				;
				
                v_status = 0 ; 
				v_message := 'Email or mobile number is in use.';
                    
				v_is_first_login := 0;   
				v_is_login = 0 ;
				
            end if ;
			
            insert into labmi.labmi_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, 2, v_current_timestamp, coalesce(v_is_app,0) ;
  
       -- p_result := 1  ;
   		p_ures_json :='{
                  "data": {
                    "waf_user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "token": "'|| coalesce(v_token,'') ||'",
                    "epoch_timestamp": "'||coalesce(v_epoch_timestamp,'')||'" ,
                    "email_id": "'|| coalesce(v_email_id,'')||'",
					"client_id": '||coalesce(v_client_id,0) ||',
                    "status": '|| coalesce(v_status,0) ||',
                    "message": "'||coalesce(v_message,'') ||'",
                    "error": {
                        "code": '|| coalesce(v_status,0) ||',
                        "message": "'||coalesce(v_message,'') ||'"
                    },
					"failed_attempts": '|| coalesce(v_failed_attempts,0) || ',
					"unlock_date":   "'||coalesce(v_unlock_date::varchar,'null')||'",
                    "user": {
                      "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
                      "name": "'||coalesce(v_user_full_name,'') ||'",
                      "social_user_name": "'|| coalesce(v_social_user_name,'') ||'",
					  "first_name": "'|| coalesce(v_first_name,'') ||'",
					  "last_name": "'|| coalesce(v_last_name,'') ||'",
					  "address_1": "'|| coalesce(v_address_1,'') ||'",
					  "address_2": "'|| coalesce(v_address_2,'') ||'",
					  "pin_code": "'|| coalesce(v_pin_code,'') ||'",
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
                      "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'" ,
					  "campaign_id": "'|| coalesce(v_campaign_id::varchar,'0') ||'" ,
					  "campaign_json": {
							  "product_name": "'|| coalesce(v_product_name::varchar,'') ||'" ,
							  "expiry_date": "'|| coalesce(v_expiry_date::varchar,'') ||'",
							  "status": "'||coalesce(v_status_1::varchar,'')||'",
							  "campaign_id": "'|| coalesce(v_campaign_id::varchar,'') ||'",
							  "old_campaign_id" : "'||coalesce(v_old_campaign_id::varchar,'') ||'",
							  "already_exists": "'|| coalesce(v_already_exists::varchar,'') ||'"
							  ,"remarks": "'||coalesce(v_remarks,'')||'"
							  ,"received_by": "'||coalesce(v_received_by,'')||'"
							  ,"aw_bill_number": "'||coalesce(v_aw_bill_number,'')||'"
							  ,"service_provider": "'||coalesce(v_service_provider,'')||'"
							  ,"date_of_dispatch": "'||coalesce(v_date_of_dispatch::varchar,'')||'"
							  ,"courier_status": "'||coalesce(v_courier_status,'')||'",
							  "invoice_link": "'||coalesce(v_invoice_link,'')||'",
							  "membership_owner": "'||coalesce(v_membership_owner,'')||'",
							  "name_on_card": "'||coalesce(v_name_on_card,'')||'",
							  "coupon_code": "'||coalesce(v_coupon_code,'')||'"
							  
							  
					}
                    },
                    "is_first_login": "'||coalesce(v_is_first_login,0)||'" ,
                    "is_app": "'|| coalesce(v_is_app,0) || '" ,
					"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" 
					
                  }
                }';
end;
$$;


--
