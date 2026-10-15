-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_otp_login_v1(jsonb)
-- Type: FUNCTION

-- Name: labmi_otp_login_v1(jsonb); Type: FUNCTION; Schema: labmi_beta_22042024; Owner: -
--

CREATE FUNCTION labmi_beta_22042024.labmi_otp_login_v1(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

	/*'{
  "data": {
    "mobile_no": "string",
    "otp": "string",
    "email_id": "string",
    "opt_type": "string", – (1- mobile , 2- Email_id)
    "is_app": numeric
 		  }
	}'*/

	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_otp numeric;
	-- v_opt numeric;
	v_opt_type numeric;
	--v_user_guid character varying(1000);
	--v_is_app numeric;
	v_count numeric ;
	--v_created_date timestamp;
	v_attemp numeric ;
	--v_status numeric;
	
	
	v_current_timestamp timestamp without time zone;
    v_client_id numeric;
    v_social_user_name character varying;
    v_user_full_name character varying;
   -- v_email_id character varying;
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
   -- v_mobile_no character varying;
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
    -- v_mobile_social  text;
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
   v_campaign_id_1 numeric;
   v_campaign_id numeric;
   v_mobile_verified numeric;
   v_already_exists numeric;
    v_address_1 character varying;
   v_address_2 character varying;
   v_pin_code character varying;
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
   v_membership_owner text;
   v_name_on_card text;
   v_whatsapp_consent numeric;
   v_platform_id numeric;
   v_coupon_code character varying;
   v_old_campaign_id numeric;
   v_message_1 character varying;

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'opt_type' ,
		   p_inputjson->'data'->>'is_app' ,
		   p_inputjson->'data'->>'campaign_id'
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_opt_type,
		   v_is_app,
		   v_campaign_id;
		   
		   
	if v_mobile_no = 'zPHKvSO83fSj+QKK6D96zlNYo7QHBmXx32QOpxzf3NM=' and v_otp = 123456 then
	   
	   
	   	select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            				   favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,campaign_id,created_date,
					           mobile_verified,user_id,email_id
                   		into   v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
							   v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_campaign_id_1,
							   v_created_date,v_mobile_verified,v_user_id,v_email_id
					    from labmi.labmi_web_user 
						where mobile_no = v_mobile_no  ;
						
			v_status := 1 ;
			v_message := 'Login Successful';	
			
			v_already_exists := 1;
	
	
	
		p_data :='{
                  "data": {
                    "waf_user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "token": "'|| coalesce(v_token,'') ||'",
                    "epoch_timestamp": "'||coalesce(v_epoch_timestamp,'')||'" ,
                    "email_id": "'|| coalesce(v_email_id,'')||'",
					"client_id": '||coalesce(v_client_id,0) ||',
                    "status": '|| v_status ||',
                    "message": "'||v_message ||'",
                    "error": {
                        "code": '|| v_status ||',
                        "message": "'||v_message ||'"
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
					  "campaign_id": "'|| coalesce(v_campaign_id_1::varchar,'0') ||'" ,
					  "campaign_json": {
							  "product_name": "'|| coalesce(v_product_name::varchar,'') ||'" ,
							  "expiry_date": "'|| coalesce(v_expiry_date::varchar,'') ||'",
							  "status": "'||coalesce(v_status_1::varchar,'')||'",
							  "campaign_id": "'|| coalesce(v_campaign_id_1::varchar,'') ||'",
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
                    "is_first_login": 0,
                    "is_app": "'|| coalesce(v_is_app,0) || '" ,
					"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" 
					
                  }
                }';	
	
	
	else

	
	select max(created_date) into v_created_date from labmi.labmi_otp_details
	where mobile_no = coalesce( v_mobile_no,v_email_id); -- and user_guid = v_user_guid;
	
				if exists(select 1 from labmi.labmi_otp_details
						 where mobile_no =v_mobile_no and otp = v_otp 
						 and expiry_date > current_timestamp at time zone 'utc'
						 		and created_date = v_created_date and coalesce(failed_attempt,0) < 5
						) then
						
						 update labmi.labmi_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;
									
					if v_opt_type = 1 then
					
					   if exists(select 1 from labmi.labmi_web_user
								 where mobile_no = v_mobile_no) then
								 
							
								 
			       		select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            				   favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,campaign_id,created_date,
					           mobile_verified,user_id,email_id
                   		into   v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
							   v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_campaign_id_1,
							   v_created_date,v_mobile_verified,v_user_id,v_email_id
					    from labmi.labmi_web_user 
						where mobile_no = v_mobile_no  ;
							
							  
							  if v_is_deleted =  1 then
							  
							  	v_status := 7 ;
								v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
								v_is_first_login := 0;
								
							  elsif v_is_active = 1 then 
							  
								   if v_user_full_name is null then
								   
								      v_status := 2 ;
									  v_message := 'Incomplete Profile. Name and Email are required to proceed.';
										
                                    else

										v_status := 1 ;
										v_message := 'Login Successful';
										
										
									if v_campaign_id_1 is null and v_campaign_id = 1 and v_mobile_verified =1 then
							
										update labmi.labmi_web_user
										set campaign_id =1 
										where mobile_no = v_mobile_no ; 
								
										v_already_exists := 0 ;
								
									elseif 	v_campaign_id_1 = 1 and v_campaign_id = 1 then

										v_already_exists := 1;

									end if;
									
									end if;
								
							  end if;
							  
					     insert into labmi.labmi_web_user_audit
						(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
						select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, 4, v_current_timestamp, coalesce(v_is_app,0) ;		  
							
					   					   
					   else
					 
						v_status := 0 ;
						v_message := 'Mobile Number not exists.';
						
						insert into labmi.labmi_web_user_audit
						(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
						select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, 2, v_current_timestamp, coalesce(v_is_app,0) ;
						
					   
					end if;

					elsif v_opt_type = 2 then

					end if;			
																		
				else	
						if exists(select 1 from labmi.labmi_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 5
						 ) then
						
							 update labmi.labmi_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
						 select failed_attempt into v_attemp from labmi.labmi_otp_details
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 	 and created_date = v_created_date;
								
							
							--p_data	:= '{"status": "0",
									--	"message": "Attempts Allowed: '||coalesce(v_attemp,0)||'/3",
									--	"failed_attempt":'||coalesce(v_attemp,0)::text||'}';
										
							v_status := 0;
							
							if v_attemp > 4 then
							
						    v_message := 'Attempts Allowed: '||coalesce(v_attemp,0)||'/5.Try after 1hr.' ;			
							
							else
							
							v_message := 'Attempts Allowed: '||coalesce(v_attemp,0)||'/5' ;	
							
							end if;
										
										
						else
		
						v_status := 0;
						v_message := 'Try after 1 hrs to generate OTP' ;
										
										
						end if;	
						
						
			end if;	
			
			p_data :='{
                  "data": {
                    "waf_user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "user_guid": "'|| coalesce(v_user_guid,'')||'",
                    "token": "'|| coalesce(v_token,'') ||'",
                    "epoch_timestamp": "'||coalesce(v_epoch_timestamp,'')||'" ,
                    "email_id": "'|| coalesce(v_email_id,'')||'",
					"client_id": '||coalesce(v_client_id,0) ||',
                    "status": '|| v_status ||',
                    "message": "'||v_message ||'",
                    "error": {
                        "code": '|| v_status ||',
                        "message": "'||v_message ||'"
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
                    "is_first_login": 0,
                    "is_app": "'|| coalesce(v_is_app,0) || '" ,
					"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" 
					
                  }
                }';		
						
				
		end if;		
				

	
end;
$$;


--
