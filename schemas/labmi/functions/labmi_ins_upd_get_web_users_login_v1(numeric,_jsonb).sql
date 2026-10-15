-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_ins_upd_get_web_users_login_v1(numeric, jsonb)
-- Type: FUNCTION

-- Name: labmi_ins_upd_get_web_users_login_v1(numeric, jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_ins_upd_get_web_users_login_v1(p_opttype numeric, p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
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
   --v_mobile_verified numeric;
   v_membership_owner text;
   v_name_on_card text;
   v_whatsapp_consent numeric;
   v_platform_id numeric;
   v_coupon_code character varying;
   v_old_campaign_id numeric;
   v_message_1 character varying;
   v_email_verified boolean := true;
   v_mobile_verified boolean := true;
   v_subscribe_for_email boolean;
   v_accept_tnc boolean;
   v_platform_type numeric;
   v_paid_membership_start_date timestamp;
   
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
		   p_user_json->'data'->'user'->>'address_1',
		   p_user_json->'data'->'user'->>'address_2',
		   p_user_json->'data'->'user'->>'pincode',
		   p_user_json->'data'->>'otp',
		   p_user_json->'data'->>'campaign_id',
		   p_user_json->'data'->>'whatsapp_consent',
		   p_user_json->'data'->>'platform_id',--
		   p_user_json->'data'->>'message',
		   p_user_json->'data'->'user'->>'subscribe_for_email',
		   p_user_json->'data'->>'accept_tnc',
		   p_user_json->'data'->>'platform_type'
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
			v_first_name,
			v_last_name,
			v_address_1,
			v_address_2,
			v_pin_code,
			v_otp,
			v_campaign_id,
			v_whatsapp_consent,
			v_platform_id,
			v_message_1,
			v_subscribe_for_email,
			v_accept_tnc,
			v_platform_type
			;
   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
		
		--select 1/0;
    /* ****************************************
      Client_id     Client 
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */
    
   /* if p_opttype = 1 then   -- p_opttype = 1 Social Login
	

   
    		if not exists(select 1 from labmi.labmi_web_user where social_id = v_social_id
                          and client_id = v_client_id -- and is_active = 1
						  )then 

			
              /*  v_web_user_id := nextval('labmi.seq_labmi_web_users_id');               
                v_user_guid := uuid_generate_v4();                 
                v_is_active := 1;
                v_is_deleted := 0;
                v_created_by := 1;
                v_updated_by := 1;              
				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
                
               if  v_social_id is null then 
               		
                    v_status = 0 ;
                    v_message := 'Invalid Social ID';
                    v_is_first_login := 1;          

                    v_result := 0;
               else 
                    if v_email_id is null or v_user_full_name is null or v_mobile_no is null  
                    then
                       -- raise notice 'opttype 1 Test 1' ;
                        v_status = 2 ;
                        v_message := 'Incomplete Profile. Name and Email are required to proceed.';
                        v_is_verified = 0 ; 
                    else 
                        -- raise notice 'opttype 1 Test 2' ;
                        v_is_verified = 1; 
                        v_status = 1 ;
                        v_message := 'Login Successful';
                    end if ;              

                  -- select * from labmi.labmi_web_user limit 1;
                    insert into labmi.labmi_web_user
                    (user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
                     social_id, profile_picture_url, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
                     is_verified, gender, epoch_timestamp, ipaddress, favourite_club, edition, is_custom_image)
                    select v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password,
                            v_social_id, v_profile_picture_url, v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,
                            1, v_is_verified,v_gender, v_epoch_timestamp, v_ipaddress, v_favourite_club, v_edition, v_is_custom_image ;

                    v_is_first_login := 1;            

                    v_result := v_web_user_id;*/	
				
                    v_message := 'Invalid Login';
					v_status := 0;
					
			
					        
            else
            	-- raise notice 'opttype 1 else  Test 4' ;      
                	
                 v_email_social:= v_email_id;
    			 --v_mobile_social:= v_mobile_no;
    			 v_profile_image_social:= v_profile_picture_url;
                
                select email_id, user_full_name, user_id, user_guid, is_deleted, favourite_club, edition,  profile_picture_url , is_custom_image, is_active,
					   first_name,last_name,address_1,address_2,pin_code
                into v_email_id, v_user_full_name, v_user_id, v_user_guid, v_is_deleted, v_favourite_club, v_edition,  v_profile_picture_url, v_is_custom_image, v_is_active,
					  v_first_name,v_last_name,v_address_1,v_address_2,v_pin_code 
                from labmi.labmi_web_user 
                where social_id = v_social_id
                and client_id = v_client_id;
                
                v_email_id:=coalesce(v_email_social,v_email_id);
                
                if v_is_custom_image!=1
                then 
                v_profile_picture_url:=coalesce(v_profile_image_social,v_profile_picture_url);
                
                end if ;
                               
                update labmi.labmi_web_user  
					set  email_id =v_email_id, 
						 upper_email_id =v_email_id,
                         profile_picture_url=v_profile_picture_url
                         where social_id = v_social_id
                			and client_id = v_client_id;
                
                
                
               -- and is_active = 1
                
				if coalesce(v_is_deleted,0) = 1 and v_is_active = 0 then 
					
					v_status = 7 ;
					v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
					v_is_first_login := 0 ;
					
				else
				
					/*if v_email_id is null or v_user_full_name is null 
					then                	                   
						-- raise notice 'opttype 1 Test 5' ;
						v_status = 2 ;
						v_message := 'Incomplete Profile. Name and Email are required to proceed.';
						v_is_first_login := 1;  
					else            */     	
						v_status := 999;
						 v_message := 'Login Successful';
					/* end if ; */
				
				end if;
					p_result := v_user_id  ;
					
		end if;
            
    	 insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
         p_result := v_user_id  ;
      	       
                      
    end if;    -- end if :  p_opttype = 1 Social Login 
    */
    -- -----------------------------------------------------------------------------------------------------------------------------
   /*	if p_opttype = 2 then   -- p_opttype = 2 Custom Registration   
    
    		if not exists(select 1 from labmi.labmi_web_user 
						  where client_id = v_client_id and upper_email_id = v_upper_email_id
						  and mobile_no = v_mobile_no
						-- and is_active = 1
						 ) then 
						 
				if exists(select 1 from labmi.labmi_otp_details
						 where mobile_no = v_mobile_no and otp = v_otp and is_verified = 1 ) then		 
						 
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
				 campaign_id,mobile_verified,membership_start_date,trans_guid,whatsapp_consent,platform_id,sync_data,pin_code)
                select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, 1, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
                v_favourite_club, v_edition, 'Uiwo6dOG90psCEd7TmLLU3IbGQwEse7L9prbqEKa3fw=', 1,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id,v_gender,v_dob,
				v_campaign_id,1,v_current_timestamp,uuid_generate_v4(),v_whatsapp_consent,v_platform_id,0,v_pin_code ;
				                 
                v_is_first_login := 1;
				
				v_status := 3 ;						
				v_message := 'A verification email has been sent to your registered email. Please check your inbox to complete the registration.' ;
				
			  else
				
				v_status := 0 ;						
				v_message := 'mobile number not verified.' ;
				
               end if;
			   
            else
            
				select is_verified, profile_picture_url , is_custom_image
				into v_is_verified,  v_profile_picture_url, v_is_custom_image
				from labmi.labmi_web_user 
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
			
            insert into labmi.labmi_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
               
			
			
	end if ;*/
    
	if p_opttype = 3 then   -- p_opttype = 3 Custom Login Email Verification 
    
    		if exists(select 1 from labmi.labmi_web_user where client_id = 5 and verification_key = v_verification_key and is_active = 1 and is_deleted=0
					 and is_verified<>1)
            then 
            	 select user_guid, is_verified, favourite_club, edition,  profile_picture_url , is_custom_image,
                 email_id,user_full_name,mobile_no,campaign_id
                 into v_user_guid, v_is_verified, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image,
                 v_email_id,v_user_full_name,v_mobile_no,v_campaign_id
                 from labmi.labmi_web_user
                 where client_id = 5 and verification_key = v_verification_key 
                 and is_active = 1 and  is_deleted=0;
                 
            	if v_is_verified = 1 then
                     v_status := 1 ;
                     v_message := 'Kindly proceed to update your profile.';
                else
                           
                     update labmi.labmi_web_user 
                     set is_verified = 1, is_login = 0, ipaddress = v_ipaddress, updated_date = v_current_timestamp
                     where client_id = 5 and verification_key = v_verification_key 
                     and is_active = 1  and  is_deleted=0;

                     v_status := 1 ;
                     v_message := 'Verification Successful. Kindly proceed to update your profile.';
                end if;
				
				if v_campaign_id is null then
				
					v_status := 1000 ;
				
				end if;
				
			else
				v_status := 0 ;	
				v_message := 'Verification failed. Please check the link or try again later.';  					
			end if ; 
			 v_is_first_login := 0;
			 v_is_login := 0 ;	
			 
             insert into labmi.labmi_web_user_audit
			 (audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			 select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
      --  raise notice 'v_user_guid  : %' , v_user_guid; 
      --  raise notice 'v_status  : %' , v_status;
      --  raise notice 'v_message  : %' , v_message;
        
			 
	end if;  --  end p_opttype = 3 Custom Login Email Verification  
    
     if p_opttype = 4 then   -- p_opttype = 4 Custom Login Email Verification 			 
		
		if exists(select 1 from labmi.labmi_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id 
				  and user_password = v_user_password 
				 -- and is_active = 1  and is_deleted=0                 
				 )
		then
			
							
			select failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            		favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,campaign_id,created_date,
					mobile_verified
            into v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
            		v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_campaign_id_1,
					v_created_date,v_mobile_verified
			from labmi.labmi_web_user 
			where upper_email_id = v_upper_email_id and user_password = v_user_password 
			-- and is_active = 1
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
							v_user_full_name := '';
							v_profile_picture_url :='';
							v_is_custom_image :='0';
							v_unlock_date :=null;
							v_failed_attempts :='0';
						
			   else
					if v_user_full_name is null then
						v_status := 2 ;
						v_message := 'Incomplete Profile. Name and Email are required to proceed.';
						
					else
						if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then 
						
							update labmi.labmi_web_user  
							set  failed_attempts = 0, unlock_date = null, updated_date = v_current_timestamp,
								 ipaddress = v_ipaddress
							where upper_email_id = v_upper_email_id and client_id = v_client_id 
							and is_active = 1 and is_deleted=0 and user_password = v_user_password 
							;
							
							

							v_status := 1 ;
							v_message := 'Login Successful';
							
							raise notice '% 1',v_campaign_id_1;
							raise notice '% 2',v_campaign_id;
							
							if v_campaign_id_1 is null and v_campaign_id =1 and v_mobile_verified =1 then
							
								update labmi.labmi_web_user
								set campaign_id =1 
								where upper_email_id = v_upper_email_id and client_id = v_client_id 
								and is_active = 1 and is_deleted=0 and user_password = v_user_password ; 
								
								v_already_exists := 0;
								
							elseif 	v_campaign_id_1 = 1 and v_campaign_id =1 then
							
								v_already_exists := 1;
							
							end if;
							
							
							
							if v_campaign_id_1 is null and '2020-06-29 05:55:48'::timestamp < v_created_date then -- for new user
		
							v_status := 1000 ;
							
							elseif  v_campaign_id_1 is null then
							
							v_status := 999 ;
		
							end if;
							
						else				
							v_status := 0 ;
							v_message := 'This account has been locked. Please try again after 24 hrs.';
							v_user_guid := '';
							v_user_full_name := '';
							v_profile_picture_url :='';
							v_is_custom_image :='0';
							v_unlock_date :=null;
							v_failed_attempts :='0';
						end if;
					end if ;
				end if;
			end if;
		else
			
			if not exists(select 1 from labmi.labmi_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id 
				 and is_active = 1 and is_deleted=0
				  )
		    then 
				 v_status := 0 ;
                 v_message := 'Incorrect credentials. Please check the credentials and try again.';
			else
			
				select coalesce(failed_attempts,0) +1 into v_failed_attempts 
				from labmi.labmi_web_user 
				where upper_email_id = v_upper_email_id
				and is_active = 1 and is_deleted=0
				and client_id = v_client_id  ;			
				
				if v_failed_attempts >= 3 then             
				
					 v_unlock_date = v_current_timestamp + interval '24 hours' ;
					 -- v_unlock_date = v_current_timestamp + interval '2 MINUTE' ;
					update labmi.labmi_web_user  
					set  failed_attempts = failed_attempts + 1, 
						 unlock_date = v_unlock_date ,
						 updated_date = v_current_timestamp,
						 ipaddress = v_ipaddress
					where upper_email_id = v_upper_email_id and client_id = v_client_id 
					and is_active = 1 and is_deleted=0
					;
					
					v_status := 0 ;
					v_message := 'This account has been locked. Please try again after 24 hrs.';
					v_unlock_date :=null;
					v_failed_attempts :='0';
				else
					update labmi.labmi_web_user 
					set  failed_attempts = failed_attempts + 1, updated_date = v_current_timestamp ,
						 ipaddress = v_ipaddress
					where upper_email_id = v_upper_email_id and client_id = v_client_id
					and is_active = 1 and is_deleted=0
					;
					
					v_status := 0 ;
					v_message := 'Incorrect credentials. Please check the credentials and try again.';
					
				end if ;
			end if;
		end if ; 
		

		
        insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id, v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
         
	
	end if;
    
    if p_opttype = 5 then   -- p_opttype = 5 Custom Login Forget Password 
		
		if exists(select 1 from labmi.labmi_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id  
				 and is_active = 1 and  is_deleted=0
				  )
		then	
				v_status := 4 ;				 
				v_key_expiry_date := v_current_timestamp + interval '24 hours ' ; 
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                
				select is_verified, verification_key,user_full_name into v_is_verified, v_verification_key,v_user_full_name
                from labmi.labmi_web_user 
                where client_id = v_client_id and upper_email_id = v_upper_email_id  
                ;
                
				if v_is_verified = 1 then 
				
					update labmi.labmi_web_user  
					set  reset_key = v_reset_key, 
						 token = v_token, 
						 key_expiry_date = v_key_expiry_date, 
						 reset_key_status = 1, 
						 epoch_timestamp = v_epoch_timestamp,
						 ipaddress = v_ipaddress,
						 updated_date = v_current_timestamp
					where upper_email_id = v_upper_email_id and client_id = v_client_id 
					-- and is_active = 1 and  is_deleted=0
					;
					
					v_message := 'Password Reset link has been sent to your registered email. Kindly check your inbox for further details. The link is valid up to 24 hrs.';
				else
                    
                        v_status := 3 ;
                        v_message :=  'Verification Required. A verification email has been sent to your registered email. Please check your inbox to complete the registration.';
                        v_user_guid := v_verification_key;
                        
                end if;
		else
				v_status := 0 ;
				v_message := 'Reset link sent on registered email and is valid for 10 hours.';
				
		end if ;
		
        insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
	
	end if ;  -- -- end p_opttype = 5 Custom Login Forget Password 
	
    
	if p_opttype = 6 then   -- p_opttype = 6 Custom Login Update Password 	
		
		if exists (select 1 from labmi.labmi_web_user 
				   where client_id = v_client_id -- and upper_email_id = v_upper_email_id 
					and reset_key = v_reset_key 
					 and is_active = 1 and  is_deleted=0
					)
		then
        	
             select user_guid, user_full_name, key_expiry_date , favourite_club, edition,  profile_picture_url, is_custom_image
             into v_user_guid, v_user_full_name, v_key_expiry_date, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image
             from labmi.labmi_web_user 
			 where client_id = v_client_id            
			 and reset_key = v_reset_key 
			--  and is_active = 1 and  is_deleted=0
			 ;
			
			if v_key_expiry_date > v_current_timestamp            
            then
				v_status := 1;
                
				update labmi.labmi_web_user  
				set old_password = user_password,
					user_password = v_user_password,
					failed_attempts = 0, 					
					updated_date = v_current_timestamp,
					reset_key = null,
					reset_key_status = 0,
					unlock_date = null,                    
                    verification_key = null
				where -- upper_email_id = v_upper_email_id and 
                client_id = v_client_id 
				and reset_key = v_reset_key 
				-- and is_active = 1 and  is_deleted=0
			    and key_expiry_date >= v_current_timestamp;
				
				v_message :=  'Password has been updated.';      
				
			else
				v_status := 6 ;
				v_message := 'Password reset token has expired. Please raise another request.';
			end if;
			
		else
			v_status := 6 ;
			v_message := 'Invalid token. Please check the link and try again.';
		end if; 	
		
		 insert into labmi.labmi_web_user_audit
		  (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
		 select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
		
	end if ;
    -- -----------------------------------------------------------------------------------------------------------------------------
   if p_opttype = 7 then   -- p_opttype = 7 Get User  
    
     
    	if exists (select 1 from labmi.labmi_web_user where user_guid = v_user_guid 
					and is_active = 1
					)
        then 
       
        	v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
           
            raise notice 'P1 : %' , v_epoch_timestamp;           
                           
                        
        	select  user_id, email_id, mobile_no, user_full_name, social_user_name, dob, favourite_club, edition, gender, city , a.is_deleted, 
					profile_picture_url , is_custom_image, a.is_active ,d.name , s.name,c.name,a.country_id,a.city_id,a.state_id,
					campaign_id,pcp.payment_guid,old_campaign_id
            into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted, 
				 v_profile_picture_url, v_is_custom_image, v_is_active,v_country_name,v_state_name,v_city_name,v_country_id,v_city_id,v_state_id,
				  v_campaign_id,v_payment_guid,v_old_campaign_id
            from labmi.labmi_web_user a
			left join waf_master.waf_cities c on a.city_id=c.city_id
			left join waf_master.waf_states s on a.state_id=s.state_id
			left join waf_master.waf_countries d on a.country_id=d.country_id
			left join labmi.labmi_product_cart_paydetails pcp on a.user_guid=pcp.user_guid 
				and lower(pcp.order_status) = lower('SUCCESS')
            where a.user_guid = v_user_guid 
			-- and is_active = 1
			;
			
			if v_payment_guid is not null then
			
			v_invoice_link := 'https://beta-mi.sportz.io/static-assets/pdfs/membership/invoice/'||v_payment_guid||'.pdf';
			
			end if;
			
			 
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
				
				update labmi.labmi_web_user set token = v_token, epoch_timestamp = v_epoch_timestamp
				where user_guid = v_user_guid 
				-- and is_active = 1	
				;  
			
				if ((v_user_full_name is null) or (v_email_id is null)) then 
					v_message := 'Incomplete Profile. Name and Email are required to proceed.';		
					v_status := 2 ;
				else
					v_message :=  'Success';   		
					v_status := 1 ;
				end if;
				
			end if;	
            
        else
        	v_status := -33;
            v_message := 'Unable to locate user information.';   		
                    
        end if; 
		
		/*select row_to_json(tab)  from(
		select p.product_name,pa.expiry_date
		from labmi.labmi_web_user wu
		left join  labmi.labmi_product_cart pa on wu.user_guid=pa.user_guid
		left join labmi.labmi_product p on wu.campaign_id=p.product_id
		where wu.user_guid = v_user_guid)tab 
		into v_campaign_json ;*/
		
		select p.product_name,pc.expiry_date,case  lower(order_status) when lower('SUCCESS') then 1
											when lower('SI-Initiated') then 2
											when lower('AWAITED') then 2
											else 3 end status,pcp.product_cart_id,
											sh.remarks,sh.received_by,sh.courier_status,
											sh.aw_bill_number,sh.service_provider,sh.date_of_dispatch,wu.membership_start_date
											
		into v_product_name,v_expiry_date,v_status_1,v_product_cart_id,
		v_remarks,v_received_by,v_courier_status,
		v_aw_bill_number,v_service_provider,v_date_of_dispatch,v_paid_membership_start_date
		from labmi.labmi_web_user wu
		left join  labmi.labmi_product_cart pc on wu.user_guid=pc.user_guid
		left join labmi.labmi_product p on wu.campaign_id=p.product_id
		left join labmi.labmi_product_cart_paydetails  pcp on pc.product_cart_id=pcp.product_cart_id
															and (lower(order_status)=lower('SUCCESS') 
											  or lower(order_status)=lower('SI-Initiated') 
											  or lower(order_status)=lower('AWAITED'))
		left join labmi.labmi_product_shipment_user sh on pc.product_cart_id=sh.product_cart_id
		where wu.user_guid = v_user_guid ;
		
		
		select pc.membership_owner,pc.name_on_card 
		into  v_membership_owner,v_name_on_card
		from  labmi.labmi_product_cart_paydetails pcp
		left join labmi.labmi_product_cart  pc on pcp.product_cart_id=pc.product_cart_id 
		where pc.user_guid = v_user_guid and (lower(order_status)=lower('SUCCESS'))  ;
		
	
		
		
		
    
       if v_campaign_id>1 then
	   v_status_1=1;
	    /* select row_to_json(t) into v_shipment_data
			from (
  			select remarks from labmi.labmi_product_shipment_user where product_cart_id=v_product_cart_id
			) t ; 8 */
			
	     end if;
		
		if v_campaign_id = 1 and v_status_1 <> 2 then
		
		v_status_1 = 4;	
		
		end if;
        
        insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
		p_result := v_user_id  ;
    
    end if ;  -- end  p_opttype = 7 Get User
    
    if p_opttype = 8 then   -- p_opttype = 8 Update User  
     
		if exists ( select 1 from labmi.labmi_web_user where user_guid = v_user_guid ) then 
			
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labmi.labmi_web_user where user_guid = v_user_guid ; 
			
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
				if exists ( select 1 from labmi.labmi_web_user where user_guid = v_user_guid and is_active = 1 and  is_deleted=0
							and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
				then 
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint; 
				
					select email_id, is_custom_image, profile_picture_url
					into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url
					from labmi.labmi_web_user 
					where user_guid = v_user_guid
					and is_active = 1 and  is_deleted=0; 
					
					if (v_is_custom_image_tab = 0  or v_profile_picture_url is null) then 		
						
						v_old_profile_image_url := ''; 
					
					end if; 			
			
					if coalesce(v_emailid_ex,'') = '' then 
				
						update labmi.labmi_web_user 
						set     user_full_name = v_user_full_name,
                        		-- social_user_name = v_social_user_name,
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
								token =  v_token,
								epoch_timestamp = v_epoch_timestamp ,
								ipaddress = v_ipaddress,
								edition =  v_edition, 
								is_custom_image = (case when  v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
								city_id=v_city_id,
								state_id=v_state_id,
								country_id=v_country_id,
								sync_data = 0
								
							   -- , is_verified = 1
						where user_guid = v_user_guid 
						and is_active = 1 and  is_deleted=0
						returning user_id into v_user_id ; 
						
						v_status := 1;
						v_message := 'Profile updated successfully.';
					
					else
                    
						if v_upper_email_id !=  v_emailid_ex then  		
						
							v_status := 0;
							v_message := 'Unrecognized user.';
							
						else
								
							update labmi.labmi_web_user 
							set    -- social_user_name = v_social_user_name,
									user_full_name = v_user_full_name,
									-- email_id = v_email_id,
									-- upper_email_id = v_upper_email_id,									
									dob =  v_dob,
									profile_picture_url = (case when  v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),								
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
									is_custom_image = (case when  v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
								   -- , is_verified = 1
								city_id=v_city_id,
								state_id=v_state_id,
								country_id=v_country_id	,
								sync_data = 0
							where user_guid = v_user_guid 
							and is_active = 1 and  is_deleted=0
							returning user_id into v_user_id ; 
							
							v_status := 1;
							v_message := 'Success';  	
						end if;
					end if ;	
				
				else 
					v_status := 0;
					v_message := 'Token mismatch.';	
				end if ;
				
			end if ; 
		
		else 
				
				-- raise notice 'opttype 8 test 2 ';   
				v_status := 0;
				v_message := 'Unable to locate user information.';  
				
		end if;	
		
        insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
		p_result := coalesce(v_user_id,1)  ;

    end if ;
    
    if p_opttype = 9 then   -- p_opttype = 9 Update User  and return user data     
 
		if exists ( select 1 from labmi.labmi_web_user where user_guid = v_user_guid )
		then 
		   
        
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labmi.labmi_web_user where user_guid = v_user_guid ; 
			
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
           
				if exists (select 1 from labmi.labmi_web_user where user_guid = v_user_guid and is_active = 1 and  is_deleted=0
							and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
				then 
             -- raise notice 'opttype 9 test 1 ';     
              			   	                   
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
										
								
					select email_id, is_custom_image, profile_picture_url,d.name , s.name,c.name,old_campaign_id
					into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url,v_country_name,v_state_name,v_city_name,v_old_campaign_id                      
					from labmi.labmi_web_user a
					left join waf_master.waf_cities c on a.city_id=c.city_id
					left join waf_master.waf_states s on a.state_id=s.state_id
					left join waf_master.waf_countries d on a.country_id=d.country_id
					where user_guid = v_user_guid
					and is_active = 1 and  is_deleted=0 ; 
					
                 
					if (v_is_custom_image_tab = 0  or v_profile_picture_url is null) then 		
						
						v_old_profile_image_url := ''; 
					
					end if; 
				
					if coalesce(v_emailid_ex,'') = '' then 
					
						update labmi.labmi_web_user 
						set     -- social_user_name = v_social_user_name,
								user_full_name = v_user_full_name,
								--email_id = v_email_id,
								--upper_email_id = v_upper_email_id,									
								dob =  v_dob,
								profile_picture_url = (case when v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),   
								city = v_city,
								--mobile_no = v_mobile_no,	
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
								country_id=v_country_id	,
								whatsapp_consent= v_whatsapp_consent,
								sync_data = 0
							   -- , is_verified = 1
						where user_guid = v_user_guid 
						and is_active = 1 and  is_deleted = 0 
						returning user_id into v_user_id ; 
						
						v_status := 1;
						v_message := 'Profile updated successfully.';
						
					else
						if v_upper_email_id !=  v_emailid_ex then  		
							v_status := 0;
							v_message := 'Unrecognized user.';
							v_email_id := v_emailid_ex;
							
						else
		                  
							update labmi.labmi_web_user 
							set     -- social_user_name = v_social_user_name,
									user_full_name = v_user_full_name,
									-- email_id = v_email_id,
									-- upper_email_id = v_upper_email_id,									
									dob =  v_dob,
									profile_picture_url =  (case when v_is_custom_image = 1 then v_profile_picture_url else profile_picture_url end),
									city = v_city,
									--mobile_no = v_mobile_no,								
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
									whatsapp_consent= v_whatsapp_consent,
									sync_data = 0
								   -- , is_verified = 1
							where user_guid = v_user_guid 
							and is_active = 1
							returning user_id into v_user_id ; 
							
							v_status := 1;
							v_message := 'Success'; 	
						end if;
					end if ;	
				
				else 
            
					-- raise notice 'opttype 9 test 2 ';   
					v_status := 0;
					v_message := 'Token mismatch.';	
				end if ;
				
			end if ;
			
		else 
					
				-- raise notice 'opttype 9 test 2 ';   
				v_status := 0;
				v_message := 'Unable to locate user information.';  
		
		end if ;
			
       -- raise notice 'opttype 9 test 3 ';   
		insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
		
       
		p_result := coalesce(v_user_id,1)  ;
            
          raise notice 'userjson : % ',  p_ures_json ;
			
    end if ; -- END p_opttype = 9 Update User  and return user data
	
    if p_opttype = 10 then   -- p_opttype = 10 User deleted 
         
    	if exists ( select 1 from labmi.labmi_web_user where user_guid = v_user_guid and is_active = 1 and  is_deleted=0
                    --and token =  v_token and epoch_timestamp = v_epoch_timestamp 
				  ) 
        then 
			
			-- delete from labmi.labmi_web_user where user_guid = v_user_guid and is_active = 1 ;
			
           select email_id into v_email_id
           from labmi.labmi_web_user 
           where user_guid = v_user_guid 
           and is_active = 1 ;
            
            update labmi.labmi_web_user set  is_active  = 0 ,
            is_deleted =  1, updated_date = v_current_timestamp,message=v_message_1
            where user_guid = v_user_guid and is_active = 1;
            --and token =  v_token and epoch_timestamp = v_epoch_timestamp ; 
            
			insert into labmi.labmi_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;	
						
			v_status := 1;
            v_message := 'We have initiated the request to delete your information from our system. The process may take up to 90 Days to remove all information from our systems.';   
			
		else 
        	v_status := 0;
            v_message := 'Unknown request.';  
        end if ;
		
	   p_result := 1  ;        

				
	end if;  -- end p_opttype = 10 User deleted 
    
	--------------------------------------------------------------------------------------------------------
	
    if p_opttype = 11 then   -- p_opttype = 11 Do User Active and Login
        
		if (v_user_guid is not null and v_is_active = 1 and v_is_deleted  = 0) then 
		
		if exists(select 1 from labmi.labmi_web_user where user_guid = v_user_guid and is_deleted = 1 ) then
		
			if v_client_id = 5 then 
									
					select failed_attempts , unlock_date, is_verified, user_full_name , verification_key,
							favourite_club, edition, email_id, profile_picture_url , is_custom_image
					into v_failed_attempts,  v_unlock_date, v_is_verified,  v_user_full_name, v_verification_key,
							v_favourite_club, v_edition, v_email_id , v_profile_picture_url, v_is_custom_image
					from labmi.labmi_web_user 
					where user_guid = v_user_guid					
					-- and is_active = 1
					and client_id = v_client_id  ;
					
					update labmi.labmi_web_user set is_active = v_is_active, is_deleted = v_is_deleted, updated_date = v_current_timestamp
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
							
								update labmi.labmi_web_user  
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
	
			else
				
				select email_id, user_full_name, user_id, favourite_club, edition,  profile_picture_url, is_custom_image
                into v_email_id, v_user_full_name, v_user_id , v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image
                from labmi.labmi_web_user 
                where user_guid = v_user_guid				
                -- and is_active = 1
				;
                
				update labmi.labmi_web_user set is_active = v_is_active, is_deleted = v_is_deleted, updated_date = v_current_timestamp
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
				

        
			end if;	
        else
		  
		  v_status := 0 ; 
		  v_message := 'Account already recovered.' ;
		
		end if;
							
		else
			
			v_status := 0 ; 
			v_message := 'Fail' ;
			

		end if ;
		
        insert into labmi.labmi_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
		
	  -- p_result := 1  ;            
				
	end if;  -- end p_opttype = 11  User  
    
    if p_opttype = 12 then  -- for User Logout 
    	
        if (select 1 from labmi.labmi_web_user where user_guid = v_user_guid ) then
    	
        	insert into labmi.labmi_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
            select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
            
            v_status := 1;
             v_message := 'Logout Successful';
            
        else 
        
			v_status := 0;
            v_message := 'Unknown request.'; 
            
        end if; 
                               
    end if ;    -- for User Logout End
--------------------------------------------------------
if p_opttype = 17 then  -- verification_key updation 
    
        if (select 1 from labmi.labmi_web_user where email_id = v_email_id 
		   and client_id=5) then
		   
		   
		   if (select 1 from labmi.labmi_web_user where email_id = v_email_id 
		   and client_id=5 and is_verified <>1 ) then
		   
		   select user_guid,user_id,attempt,attempt_date,user_full_name 
		   into v_user_guid, v_user_id,v_failed_attempts, v_attempt_date,v_user_full_name
		   from labmi.labmi_web_user 
		   where email_id = v_email_id and client_id=5 ;
		   
		   v_failed_attempts := coalesce(v_failed_attempts,0)+ 1;
		   
		   if v_failed_attempts<= 3 and  (v_current_timestamp < v_attempt_date + '1 hours'::interval 
								or v_attempt_date is null )then
								
		      
		   update labmi.labmi_web_user
		   set verification_key =v_verification_key,
		   attempt_date=v_current_timestamp,attempt = v_failed_attempts 
		   where email_id = v_email_id and client_id=5;
		   
		   elseif v_current_timestamp > v_attempt_date + '1 hours'::interval then
		   
		   v_failed_attempts := 1;
		   
		   update labmi.labmi_web_user
		   set verification_key =v_verification_key,
		   attempt_date=v_current_timestamp,attempt = v_failed_attempts
		   where email_id = v_email_id and client_id=5;
		   
		   end if;
    
        	insert into labmi.labmi_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
            select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
            
			if v_failed_attempts <= 3 then
			
            	v_status := 1;
             	v_message := 'Verification email sent successfully';
				
			else
			    v_status := 0;
             	v_message := 'Try after 1 hour.';
			end if;
			 
			 else  
						 
			 	v_status := 0;
            	v_message := 'User Already Verified.'; 
				
            end if;
        else 
        
			v_status := 0;
            v_message := 'Email Does not exists.'; 
            
        end if;  
		
		end if;
	
-----------------------------------------------------------------------------------------	
if p_opttype = 18 then  -- Change Password Start
   
        if (select 1 from labmi.labmi_web_user where user_guid = v_user_guid 
			and user_password=v_old_password and client_id = 5 ) then
			
   			
			update labmi.labmi_web_user   
			set user_password = v_user_password
			where user_guid = v_user_guid and user_password=v_old_password and client_id = 5;

        	insert into labmi.labmi_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
            select nextval('labmi.seq_labmi_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
           
            v_status := 1;
            v_message := 'Password Changed Successful';
			
           
        else
       
			v_status := 0;
            v_message := 'Unknown request.';
           
        end if;
                       
    end if ;    -- Change Password End			
----------------------------------------------------------------------------------------			
	if p_opttype = 19 then
	
		if exists (select 1 from labmi.labmi_web_user where user_guid = v_user_guid 
		   and v_is_active = 1 and campaign_id is null and v_otp is not null and v_mobile_no is not null) then
		   
		   if exists(select 1 from labmi.labmi_otp_details
						 where mobile_no = v_mobile_no and otp = v_otp and is_verified = 1 -- and expiry_date > current_timestamp time zone 'utc'
						 ) then
	
					
	
		  	--if not exists(select 1 into v_count from labmi_web_user 
			if not exists(select 1  from labmi.labmi_web_user 
					where mobile_no = v_mobile_no and mobile_verified = 1) then 
		   
					update labmi.labmi_web_user   
					set campaign_id= case when v_campaign_id = 1 then 1 else null end,
						mobile_verified = 1,
						mobile_no=v_mobile_no,
						membership_start_date = current_timestamp at time zone 'utc',
						whatsapp_consent= v_whatsapp_consent
					where user_guid = v_user_guid  
					and is_active = 1;
			
					v_status := case when v_campaign_id = 1 then 1 else 1000 end;
					v_message := 'T&C updated succesfully';
					
			
					
				select  user_id, email_id, mobile_no, user_full_name, social_user_name, dob, favourite_club, edition, gender, city , is_deleted, 
					profile_picture_url , is_custom_image, is_active ,d.name , s.name,c.name,a.country_id,a.city_id,a.state_id,
					campaign_id
            	into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted, 
				 v_profile_picture_url, v_is_custom_image, v_is_active,v_country_name,v_state_name,v_city_name,v_country_id,v_city_id,v_state_id,
				 v_campaign_id
				from labmi.labmi_web_user a
				left join waf_master.waf_cities c on a.city_id=c.city_id
				left join waf_master.waf_states s on a.state_id=s.state_id
				left join waf_master.waf_countries d on a.country_id=d.country_id
				where user_guid = v_user_guid ;
		
				
							 			
			else 
			
					v_status := 0;
					v_message := 'Mobile number already used.';
			
			end if;
			
		else 
		
			v_status := 0;
            v_message := 'Invalid request.';
			
		end if;	
			
			else
			
			v_status := 0;
            v_message := 'Invalid request.';
				
			
		end if ;	

	end if;
--------------------------------------------------------------------
	if v_campaign_id = 1 and v_already_exists =  0 then

				if not exists(select 1 from labmi.labmi_membership_coupon_code
							  where user_guid = v_user_guid and product_id = 1) then

						select coupon_code into v_coupon_code 
						from labmi.labmi_membership_coupon_code 
						where product_id = 1 and is_used = 0
						order by coupon_code_id
						limit 1;
						
						update labmi.labmi_membership_coupon_code
						set is_used = 1,
							allocated_date = v_current_timestamp,
							user_guid = v_user_guid
						where coupon_code = v_coupon_code and product_id = 1;
						
				end if;
					
		elseif	v_campaign_id = 1 and v_status =  1 then
				
				if not exists(select 1 from labmi.labmi_membership_coupon_code
							  where user_guid = v_user_guid and product_id = 1 and is_used = 1) then
							  
						select coupon_code into v_coupon_code 
						from labmi.labmi_membership_coupon_code 
						where product_id = 1 and is_used = 0
						order by coupon_code_id
						limit 1;
						
						update labmi.labmi_membership_coupon_code
						set is_used = 1,
							allocated_date = v_current_timestamp,
							user_guid = v_user_guid
						where coupon_code = v_coupon_code and product_id = 1;
						
				end if;		

		end if;	
		
		v_email_verified  :='True';
		v_mobile_verified :='True';

---------------------------------------------------------------------
			p_ures_json :='{
                  "data": {"waf_user_guid": "'|| coalesce(v_user_guid,'')||'",
				    "product_name": "'|| coalesce(v_product_name::varchar,'') ||'" ,
					"paid_membership_start_date": "'|| coalesce(v_paid_membership_start_date::varchar,'') ||'",
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
							  
							  
					},
					"subscribe_for_email": "'|| lower(coalesce(v_subscribe_for_email::varchar, 'false')) ||'"
                    },
                    "is_first_login": 0,
                    "is_app": "'|| coalesce(v_is_app,0) || '" ,
					"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
					"platform_type": '||
							CASE 
								WHEN coalesce(v_is_app,0) = 1 
								THEN coalesce(v_platform_type::varchar, 'null')
								ELSE 'null'
							END ||',
					"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'",
					"email_verified": '|| CASE WHEN v_email_verified THEN 'true' ELSE 'false' END ||',
					"mobile_verified": '|| CASE WHEN v_mobile_verified THEN 'true' ELSE 'false' END ||',

					"accept_tnc": '|| CASE WHEN v_accept_tnc THEN 'true' ELSE 'false' END ||'
					
                  }
                }';
				--,"shipment_data": "'||coalesce(v_shipment_data::text,'')||'"
	
	
	
    
  select ((a.sum_nvl*100)/7),coalesce(is_profile_complete,0)
   from (
    select (case when user_full_name is not null then 1 else 0 end
			   + case when dob is not null then 1 else 0 end
			+ case when mobile_no is not null then 1 else 0 end
			  + case when email_id is not null then 1 else 0 end
			  + case when state_id is not null then 1 else 0 end
			  + case when city_id is not null then 1 else 0 end
			  + case when gender is not null then 1 else 0 end
			 
			  ) as sum_nvl,is_profile_complete
	   from labmi.labmi_web_user
     where user_guid = v_user_guid
        ) as a										  
     into v_profile_completion_percentage,v_profile_complete;
     
     if v_profile_completion_percentage is not null then
     	p_ures_json := jsonb_set(p_ures_json,'{data,user,profile_completion_percentage}',v_profile_completion_percentage::text::jsonb,true);
    end if;
												   
	  if (v_profile_completion_percentage =100 and p_opttype in (3,9) 
		 and v_profile_complete<>1)
     then
     v_reg_cnt := nextval('labmi.labmi_profile_complete_seq');
     
     update labmi.labmi_web_user
     set is_profile_complete=1,complete_profile_id=v_reg_cnt
     where user_guid = v_user_guid;
	 
	select user_id
	from labmi.labmi_web_user										   
	where user_guid = v_user_guid
	into v_web_user_id;											   
	 											   
     
     select gratification_value,better_luck_value
     from labmi.labmi_gratification_event 
     where event_id=1
     into v_gratification_value,v_better_luck_value;
      
     
     if mod(v_reg_cnt,v_gratification_value) = 0 then
     
     with tab as( select gift_id,available_quantity,gift_name
     from labmi.labmi_gratification_gift
			where available_quantity >0
    order by RANDOM() 
    LIMIT 1) 
    select gift_id,gift_name
    from tab 
      into v_gift_id,v_gift_name;
												   
     update labmi.labmi_gratification_gift
     set available_quantity = available_quantity-1
     where gift_id =v_gift_id;
         
     insert into labmi.labmi_gratification_details
    values (nextval('labmi.labmi_gratification_detail_seq'),v_web_user_id,1,v_reg_cnt,v_gift_id,1,0,0,v_current_timestamp,null);
     
	  end if;
	
	if ((mod(v_reg_cnt,v_better_luck_value) = 0 or p_opttype=9) and v_gift_id =0) then
     
      select gift_id,gift_name
     from labmi.labmi_gratification_gift
		where is_flag=1	 
      into v_gift_id,v_gift_name;
		
      /*   
     insert into labmi.labmi_gratification_details
    values (nextval('labmi.labmi_gratification_detail_seq'),v_web_user_id,1,v_reg_cnt,v_gift_id,1,0,0,v_current_timestamp,null);
    */ 
     
                            
     end if;												   
												   
     
                            
     end if;
    
	p_ures_json := jsonb_set(p_ures_json,'{data,gift_id}',v_gift_id::text::jsonb,true);
	p_ures_json := jsonb_set(p_ures_json,'{data,gift_name}',('"'||v_gift_name||'"')::text::jsonb,true);
   														   
    p_result := 1  ;   
											   
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
