-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_ins_upd_get_web_users_login(numeric, jsonb)
-- Type: FUNCTION

-- Name: labrstg_ins_upd_get_web_users_login(numeric, jsonb); Type: FUNCTION; Schema: labrstg; Owner: -
--

CREATE FUNCTION labrstg.labrstg_ins_upd_get_web_users_login(p_opttype numeric, p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
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
    v_is_verified numeric :=1;
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
    v_ipaddress character varying;
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
   v_social_user_name_ex character varying;
   v_is_shared_data numeric;
   v_is_used_data numeric;
   v_campaign_id numeric;
   v_is_msg_sent numeric;
   v_registration_date timestamp;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'user_guid', --1
           p_user_json->'data'->>'token',--2
           p_user_json->'data'->>'epoch_timestamp',--3
           p_user_json->'data'->>'social_id',--4
           p_user_json->'data'->>'client_id', --5
    	   p_user_json->'data'->>'email_id',--6
   		   p_user_json->'data'->>'status',--7
           p_user_json->'data'->>'reset_key',--8
           p_user_json->'data'->>'key_expiry_date',--9
           p_user_json->'data'->>'password',--10
           p_user_json->'data'->>'confirm_password',--11
           p_user_json->'data'->>'old_password',--12
    	   p_user_json->'data'->>'failed_attempts',--13
    	   p_user_json->'data'->>'unlock_date',--14
    	   p_user_json->'data'->>'is_registered',--15
    	   p_user_json->'data'->>'ipaddress',--16
       	   p_user_json->'data'->'user'->>'mobile_no',--17
           p_user_json->'data'->'user'->>'name',--18
           p_user_json->'data'->'user'->>'social_user_name',--19
           p_user_json->'data'->'user'->>'dob',--20
           p_user_json->'data'->'user'->>'gender',--21
           p_user_json->'data'->'user'->>'city',--22
           p_user_json->'data'->'user'->>'favourite_club',--23
           p_user_json->'data'->'user'->>'edition',--24
           p_user_json->'data'->'user'->>'social_user_image',--25
           p_user_json->'data'->>'is_app',--26
           p_user_json->'data'->>'verification_key',--27
           p_user_json->'data'->>'is_deleted',--28
           p_user_json->'data'->>'is_active',--29
           p_user_json->'data'->'user'->>'social_user_image',--30
		   p_user_json->'data'->>'is_custom_image',--31
           p_user_json->'data'->'user'->>'country_id',--32
		   p_user_json->'data'->'user'->>'state_id',--33
		   p_user_json->'data'->'user'->>'city_id',--34
		   p_user_json->'data'->'user'->>'first_name',--35
		   p_user_json->'data'->'user'->>'last_name',--36
		   p_user_json->'data'->>'is_shared_data',--37
		   p_user_json->'data'->>'is_used_data',--38
		   p_user_json->'data'->>'campaign_id'--39
    into   v_user_guid,--1
           v_token,--2
           v_epoch_timestamp,--3
           v_social_id,--4
           v_client_id,--5
           v_email_id,--6
           v_is_active,--7
           v_reset_key,--8
           v_key_expiry_date,--9
           v_user_password,--10
           v_confirm_password,--11
           v_old_password,--12
           v_failed_attempts,--13
           v_unlock_date,--14
           v_is_registered,--15
           v_ipaddress,--16
           v_mobile_no,--17
           v_user_full_name,--18
           v_social_user_name,--19
           v_dob,--20
           v_gender, --21
           v_city,--22
           v_favourite_club,--23
           v_edition,--24
           v_profile_picture_url,--25
           v_is_app, --26
           v_verification_key,--27
           v_is_deleted,--28
           v_is_active,--29
           v_profile_picture_url,--30
		   v_is_custom_image,--31
		   v_country_id,--32
			v_state_id,--33
			v_city_id,--34
			v_first_name,--35
			v_last_name,--36
			v_is_shared_data,--37
			v_is_used_data,--38
			v_campaign_id
           ;
   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   
		
		--v_is_verified :=1;
    /* ****************************************
      Client_id     Client 
      2   			Facebook
      3             Twitter
      4 			Google+
      5				Custom
    ****************************************  */
    
    if p_opttype = 1 then   -- p_opttype = 1 Social Login

         
    		if not exists(select 1 from labrstg.labrstg_web_user where social_id = v_social_id 
			and client_id = v_client_id and v_is_shared_data=1 and v_is_used_data=1)
            then 
			
			if not exists (select 1 from labrstg.labrstg_web_user where email_id=v_email_id) then

                v_web_user_id := nextval('labrstg.seq_labrstg_web_users_id');               
                v_user_guid := uuid_generate_v4();                 
                v_is_active := 1;
                v_is_deleted := 0;
                v_created_by := 1;
                v_updated_by := 1;              
				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
                
               if  v_social_id is null then 
               		
                    v_status = 0 ;
                    v_message := 'Invalid Social_id';
                        

                    v_result := 0;
               else 
                    if v_email_id is null or v_mobile_no is null or v_first_name is null or v_last_name is null 
                    then
                       
                        v_status = 2 ;
                        v_message := 'Incomplete Profile. Username and Email are required to proceed.';
                       
                    else 
                       
                        v_status = 1 ;
                        v_message := 'Login Successful';
                    end if ;              

                    insert into labrstg.labrstg_web_user
                    (user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
                     social_id, profile_picture_url, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
                     is_verified, gender, epoch_timestamp, ipaddress, favourite_club, edition, is_custom_image,first_name,last_name,sync_status,is_shared_data,is_used_data,campaign_id)
                    select v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password,
                            v_social_id, v_profile_picture_url, v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,
                            1, v_is_verified,v_gender, v_epoch_timestamp, v_ipaddress, v_favourite_club, v_edition, v_is_custom_image,v_first_name,v_last_name,0,v_is_shared_data,v_is_used_data,v_campaign_id;

                    v_is_first_login := 1;            

                    v_result := v_web_user_id;
					v_user_id :=v_web_user_id;
                 end if;
				 insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
				else
					v_status = -5 ;
					v_message := 'Email Already EXISTS';
					v_is_first_login := 0 ;
			 end if;
            else
            	
                 v_email_social:= v_email_id;
    			 v_profile_image_social:= v_profile_picture_url;
                
                select email_id, mobile_no,first_name,last_name, user_id, user_guid, is_deleted, favourite_club, edition,  profile_picture_url , is_custom_image, is_active,campaign_id
                into v_email_id, v_mobile_no,v_first_name,v_last_name, v_user_id, v_user_guid, v_is_deleted, v_favourite_club, v_edition,  v_profile_picture_url, v_is_custom_image, v_is_active,v_campaign_id
                from labrstg.labrstg_web_user 
                where social_id = v_social_id
                and client_id = v_client_id;
                /*
                v_email_id:=coalesce(v_email_social,v_email_id);   
                update labrstg.labrstg_web_user  
					set  email_id =v_email_id, 
						 upper_email_id =v_email_id
                        
                         where social_id = v_social_id
                			and client_id = v_client_id;
                			*/
                
				if coalesce(v_is_deleted,0) = 1 and v_is_active = 0 then 
					
					v_status = 7 ;
					v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
					v_is_first_login := 0 ;
					
				else
				
					if v_email_id is null or v_mobile_no is null or v_first_name is null or v_last_name is null 
					then                	                   
						v_status = 2 ;
						v_message := 'Incomplete Profile.Username and Email are required to proceed.';
						--v_is_first_login := 1;  
					else                 	
						v_status = 1 ;
						 v_message := 'Login Successful';
					end if ; 
				
				end if;
					p_result := v_user_id  ;
					
					insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
					
            end if ;
            
    	 
         p_result := v_user_id  ;
           -- end if;                        	
	
                      
    end if;    -- end if :  p_opttype = 1 Social Login 
    
    -- -----------------------------------------------------------------------------------------------------------------------------
   	if p_opttype = 2 then   -- p_opttype = 2 Custom Registration   
    
    		if not exists(select 1 from labrstg.labrstg_web_user 
						  where (email_id = v_email_id or mobile_no = v_mobile_no )
			and v_is_shared_data = 1 and v_is_used_data = 1)
            then 
                v_web_user_id := nextval('labrstg.seq_labrstg_web_users_id');
                v_user_guid := uuid_generate_v4();
				v_is_new_reg:=1;
                v_is_active := 1;
                v_is_deleted := 0; 				
                v_created_date := v_current_timestamp;
                v_updated_date := v_current_timestamp;  				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                v_is_login := 0;			                
          	
                insert into labrstg.labrstg_web_user
                (user_id, client_id,social_user_name, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
				is_verified, token, epoch_timestamp, ipaddress, is_login, verification_key,created_by , updated_by, 
                 favourite_club, edition, profile_picture_url , is_custom_image,user_full_name,mobile_no,city_id,state_id,country_id,gender,dob,first_name,last_name,sync_status,is_shared_data,is_used_data,campaign_id,is_msg_sent)
                select v_web_user_id, v_client_id,v_social_user_name, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted,
                v_created_date, v_updated_date, 1, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login, v_verification_key,1 ,1,
                v_favourite_club, v_edition, v_profile_picture_url, 1,v_user_full_name,v_mobile_no,v_city_id,v_state_id,v_country_id,v_gender,v_dob,v_first_name,v_last_name,0,v_is_shared_data,v_is_used_data,v_campaign_id,1;
				                 
                v_is_first_login := 1;
				
				v_status := 1 ;						
				v_user_id :=v_web_user_id;
				insert into labrstg.labrstg_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
            else
            
				/*select is_verified, profile_picture_url , is_custom_image
				into v_is_verified,  v_profile_picture_url, v_is_custom_image
				from labrstg.labrstg_web_user 
				where client_id = v_client_id and upper_email_id = v_upper_email_id;
				*/
                v_status = 0 ; 
				v_message := 'Email Or Mobile no is in use.';
                    
				v_is_first_login := 0;   
				v_is_login = 0 ;
				
            end if ;
			
	end if ;
    
	if p_opttype = 3 then   -- p_opttype = 3 Custom Login Email Verification 
    
    		if exists(select 1 from labrstg.labrstg_web_user where client_id = 5 and verification_key = v_verification_key and is_active = 1 and is_deleted = 0 )
            then 
            	 select user_id,user_guid, is_verified, favourite_club, edition,  profile_picture_url , is_custom_image,
                 email_id,user_full_name,mobile_no
                 into v_user_id,v_user_guid, v_is_verified, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image,
                 v_email_id,v_user_full_name,v_mobile_no
                 from labrstg.labrstg_web_user
                 where client_id = 5 and verification_key = v_verification_key 
                 and is_active = 1 and is_deleted = 0
				 ;
                 
            	if v_is_verified = 1 then
                     v_status := 1 ;
                     v_message := 'Kindly proceed to update your profile.';
                else
                           
                     update labrstg.labrstg_web_user 
                     set is_verified = 1, is_login = 0, ipaddress = v_ipaddress, updated_date = v_current_timestamp
                     where client_id = 5 and verification_key = v_verification_key 
                     and is_active = 1  and is_deleted = 0
					 ;

                     v_status := 1 ;
                     v_message := 'Verification Successful. Kindly proceed to update your profile.';
                end if;
			else
				v_status := 0 ;	
				v_message := 'Verification failed. Please check the link or try again later.';  					
			end if ; 
			 v_is_first_login := 0;
			 v_is_login := 0 ;	
			 
             insert into labrstg.labrstg_web_user_audit
			 (audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			 select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
	end if;  --  end p_opttype = 3 Custom Login Email Verification  
    
     if p_opttype = 4 then   -- p_opttype = 4 Custom Login 			 
		
		if exists(select 1 from labrstg.labrstg_web_user 
				  where client_id = v_client_id and email_id = v_email_id 
				  and user_password = v_user_password )
		then
			
			select social_user_name,user_id,failed_attempts , unlock_date, is_verified, user_guid, user_full_name , verification_key,
            		favourite_club, edition, is_deleted, is_active, profile_picture_url , is_custom_image,first_name,last_name,mobile_no,email_id
            into v_social_user_name,v_user_id,v_failed_attempts,  v_unlock_date, v_is_verified, v_user_guid, v_user_full_name, v_verification_key,
            		v_favourite_club, v_edition, v_is_deleted, v_is_active , v_profile_picture_url, v_is_custom_image,v_first_name,v_last_name,v_mobile_no,v_email_id
			from labrstg.labrstg_web_user 
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
					if v_email_id is null or v_social_user_name is null or v_mobile_no is null or v_first_name is null or v_last_name is null
					then
						v_status := 2 ;
						v_message := 'Incomplete Profile. Name,Email and mobile number are required to proceed.';
						
					else
						if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then 
						
							update labrstg.labrstg_web_user  
							set  failed_attempts = 0, unlock_date = null, updated_date = v_current_timestamp,
								 ipaddress = v_ipaddress
							where client_id = v_client_id and upper_email_id = v_upper_email_id
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
			
			if not exists(select 1 from labrstg.labrstg_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id)
		    then 
				 v_status := 0 ;
                 v_message := 'Invalid User';
			else
			
				select coalesce(failed_attempts,0) +1 into v_failed_attempts 
				from labrstg.labrstg_web_user 
				where upper_email_id = v_upper_email_id
				and client_id = v_client_id  ;			
				
				if v_failed_attempts >= 3 then             
				
					v_unlock_date = v_current_timestamp + interval '24 hours' ;
					update labrstg.labrstg_web_user  
					set  failed_attempts = failed_attempts + 1, 
						 unlock_date = v_unlock_date ,
						 updated_date = v_current_timestamp,
						 ipaddress = v_ipaddress
					where upper_email_id = v_upper_email_id and client_id = v_client_id;
					
					v_status := 0 ;
					v_message := 'Too many failed attempts. The account has been locked. Please try again after 24 hrs.';
				else
					update labrstg.labrstg_web_user 
					set  failed_attempts = failed_attempts + 1, updated_date = v_current_timestamp ,
						 ipaddress = v_ipaddress
					where upper_email_id = v_upper_email_id and client_id = v_client_id;
					
					v_status := 0 ;
					v_message := 'Invalid User';
				end if ;
			end if;
		end if ; 
		
        insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id, v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
         
	
	end if;
    
    if p_opttype = 5 then   -- p_opttype = 5 Custom Login Forget Password 
		
		if exists(select 1 from labrstg.labrstg_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id  
				  )
		then	
				v_status := 4 ;				 
				v_key_expiry_date := v_current_timestamp + interval '24 hours ' ; 
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                
				select is_verified, verification_key,first_name into v_is_verified, v_verification_key,v_first_name
                from labrstg.labrstg_web_user 
                where client_id = v_client_id and upper_email_id = v_upper_email_id  
                ;
                
				if v_is_verified = 1 then 
				
					update labrstg.labrstg_web_user  
					set  reset_key = v_reset_key, 
						 token = v_token, 
						 key_expiry_date = v_key_expiry_date, 
						 reset_key_status = 1, 
						 epoch_timestamp = v_epoch_timestamp,
						 ipaddress = v_ipaddress,
						 updated_date = v_current_timestamp
					where upper_email_id = v_upper_email_id and client_id = v_client_id;
					
					v_message := 'Password Reset link has been sent to your registered email. Kindly check your inbox for further details. The link is valid up to 24 hrs.';
				else
                    
                        v_status := 3 ;
                        v_message :=  'Verification Required. A verification email has been sent to your registered email. Please check your inbox to complete the registration.';
                        v_user_guid := v_verification_key;
                        
                end if;
		else
				v_status := 0 ;
				v_message := 'Password Reset link has been sent to your registered email. Kindly check your inbox for further details. The link is valid up to 24 hrs.';
				
		end if ;
		
        insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        end if ; 
	
    
	if p_opttype = 6 then   -- p_opttype = 6 Custom Login Update Password 	
		
		if exists (select 1 from labrstg.labrstg_web_user 
				   where client_id = v_client_id and reset_key = v_reset_key )
		then
        	
             select user_guid, user_full_name, key_expiry_date , favourite_club, edition,  profile_picture_url, is_custom_image
             into v_user_guid, v_user_full_name, v_key_expiry_date, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image
             from labrstg.labrstg_web_user 
			 where client_id = v_client_id            
			 and reset_key = v_reset_key ;
			
			if v_key_expiry_date > v_current_timestamp            
            then
				v_status := 1;
                
				update labrstg.labrstg_web_user  
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
				-- and is_active = 1 and is_deleted = 0
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
		
		 insert into labrstg.labrstg_web_user_audit
		  (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
		 select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
		
	end if ;
    -- -----------------------------------------------------------------------------------------------------------------------------
   if p_opttype = 7 then   -- p_opttype = 7 Get User  
    
     
    	if exists (select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid)
        then 
        	v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;      
     
        	select  user_id, email_id, mobile_no, user_full_name, social_user_name, dob, favourite_club, edition, gender, city , is_deleted, 
					profile_picture_url , is_custom_image, is_active ,d.name , s.name,c.name,a.country_id,a.city_id,a.state_id,first_name,last_name,campaign_id,created_date
            into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city, v_is_deleted, 
				 v_profile_picture_url, v_is_custom_image, 
				v_is_active,v_country_name,v_state_name,v_city_name,v_country_id,v_city_id,v_state_id,v_first_name,v_last_name,v_campaign_id,v_registration_date
            from labrstg.labrstg_web_user a
			left join waf_master.waf_cities c on a.city_id=c.city_id
			left join waf_master.waf_states s on a.state_id=s.state_id
			left join waf_master.waf_countries d on a.country_id=d.country_id
            where user_guid = v_user_guid ;
			 
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
				
				update labrstg.labrstg_web_user set token = v_token, epoch_timestamp = v_epoch_timestamp
				where user_guid = v_user_guid;  
			
				if v_email_id is null or v_social_user_name is null or v_mobile_no is null or v_first_name is null or v_last_name is null
				then
					v_message := 'Incomplete Profile. Name,Email and mobile number are required to proceed.';		
					v_status := 2 ;
				else
					v_message :=  'Success';   		
					v_status := 1 ;
				end if;
				
			end if;	
            
        else
        	v_status := 0;
            v_message := 'Unable to locate user information.';   		
                    
        end if; 
        
        insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
		p_result := v_user_id  ;	
    
    end if ;  -- end  p_opttype = 7 Get User
    
    if p_opttype = 8 then   -- p_opttype = 8 Update User  
     
		if exists ( select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid ) then 
			
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labrstg.labrstg_web_user where user_guid = v_user_guid ; 
			
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
				/*if exists ( select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0
							and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
				then */
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint; 
				
					select email_id, is_custom_image, profile_picture_url
					into v_emailid_ex, v_is_custom_image_tab, v_old_profile_image_url
					from labrstg.labrstg_web_user 
					where user_guid = v_user_guid
					and is_active = 1 and is_deleted = 0; 
					
					if (v_is_custom_image_tab = 0  or v_profile_picture_url is null) then 		
						
						v_old_profile_image_url := ''; 
					
					end if; 			
			
					if coalesce(v_emailid_ex,'') = ''
					then 
				     
						update labrstg.labrstg_web_user 
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
								token =  v_token,
								epoch_timestamp = v_epoch_timestamp ,
								ipaddress = v_ipaddress,
								edition =  v_edition, 
								is_custom_image = (case when  v_is_custom_image = 1 then v_is_custom_image else is_custom_image end),
								city_id=v_city_id,
								state_id=v_state_id,
								country_id=v_country_id
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
								
							update labrstg.labrstg_web_user 
							set     social_user_name = v_social_user_name,
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
								country_id=v_country_id
							where user_guid = v_user_guid 
							and is_active = 1 and is_deleted = 0
							returning user_id into v_user_id ; 
							
							v_status := 1;
							v_message := 'Success';  	
						end if;
					end if ;	
				
				/*else 
					v_status := 0;
					v_message := 'Token mismatch.';	
				end if ;*/
				
			end if ; 
		
		else 
				
				-- raise notice 'opttype 8 test 2 ';   
				v_status := 0;
				v_message := 'Unable to locate user information.';  
				
		end if;	
		
        insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;

    end if ;
    
    if p_opttype = 9 then   -- p_opttype = 9 Update User  and return user data    

	
	
	if not exists ( select 1 from labrstg.labrstg_web_user where mobile_no = v_mobile_no)
		then
 
		if exists ( select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid )
		then 
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labrstg.labrstg_web_user where user_guid = v_user_guid ; 
			
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
           
				/*if exists (select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0)
							--and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
				then 
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
						*/				
								
					select user_id,is_custom_image, profile_picture_url,d.name , s.name,c.name,email_id,is_msg_sent
					into v_user_id,v_is_custom_image_tab, v_old_profile_image_url,v_country_name,v_state_name,v_city_name,v_emailid_ex,v_is_msg_sent         from labrstg.labrstg_web_user a
					left join waf_master.waf_cities c on a.city_id=c.city_id
					left join waf_master.waf_states s on a.state_id=s.state_id
					left join waf_master.waf_countries d on a.country_id=d.country_id
					where user_guid = v_user_guid
					and is_active = 1 and is_deleted = 0 ; 
				
					if coalesce(v_emailid_ex,'') = ''
					then 
					if not exists(select 1 from labrstg.labrstg_web_user where email_id = v_email_id)
					  then			
						update labrstg.labrstg_web_user 
						set     
						        social_user_name = v_social_user_name,
								user_full_name = v_user_full_name,
								first_name = v_first_name,
								last_name = v_last_name,
								email_id = v_email_id,
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
								campaign_id=v_campaign_id,
								sync_status=0,
								is_msg_sent = 1
							   -- , is_verified = 1
						where user_guid = v_user_guid 
						and is_active = 1 and  is_deleted = 0 
						returning user_id into v_user_id ; 
						
						v_status := 1;
						v_message := 'Profile updated successfully.';
						else
							v_status := 0;
							v_message := 'user name already exists';
						end if;
						
					else
						if v_social_user_name !=  v_social_user_name_ex then  		
							v_status := 0;
							v_message := 'Unrecognized user.';
							
						else
		                  
							update labrstg.labrstg_web_user 
							set     
							--social_user_name = v_social_user_name,
									user_full_name = v_user_full_name,
									first_name = v_first_name,
									last_name = v_last_name,
									email_id = v_email_id,
									upper_email_id = v_upper_email_id,									
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
									campaign_id=v_campaign_id,
									sync_status=0,
									is_msg_sent = 1
							where user_guid = v_user_guid 
							and is_active = 1
							returning user_id into v_user_id ; 
							
							v_status := 1;
							v_message := 'Success'; 	
						end if;
					end if ;	
				
			/*	else 
            
					v_status := 0;
					v_message := 'Token mismatch.';
                    v_user_full_name := '';
					v_dob := '';
					v_email_id:= '';

				end if ; */
				
			end if ;
			
		else 
				v_status := 0;
				v_message := 'Unable to locate user information.';  
		
		end if ;
		
		
		else
		
		 if exists ( select 1 from labrstg.labrstg_web_user where mobile_no = v_mobile_no and user_guid = v_user_guid ) then 
		 
		if exists ( select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid )
		then 
			select is_active, is_deleted into v_is_active, v_is_deleted
			from labrstg.labrstg_web_user where user_guid = v_user_guid ; 
			
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
           
				/*if exists (select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted = 0)
							--and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
				then 
					v_token :=  uuid_generate_v4();
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
						*/				
								
					select user_id,is_custom_image, profile_picture_url,d.name , s.name,c.name,email_id,is_msg_sent
					into v_user_id,v_is_custom_image_tab, v_old_profile_image_url,v_country_name,v_state_name,v_city_name,v_emailid_ex,v_is_msg_sent         from labrstg.labrstg_web_user a
					left join waf_master.waf_cities c on a.city_id=c.city_id
					left join waf_master.waf_states s on a.state_id=s.state_id
					left join waf_master.waf_countries d on a.country_id=d.country_id
					where user_guid = v_user_guid
					and is_active = 1 and is_deleted = 0 ; 
				
					if coalesce(v_emailid_ex,'') = ''
					then 
					if not exists(select 1 from labrstg.labrstg_web_user where email_id = v_email_id)
					  then			
						update labrstg.labrstg_web_user 
						set     
						        social_user_name = v_social_user_name,
								user_full_name = v_user_full_name,
								first_name = v_first_name,
								last_name = v_last_name,
								email_id = v_email_id,
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
								campaign_id=v_campaign_id,
								sync_status=0,
								is_msg_sent = 1
							   -- , is_verified = 1
						where user_guid = v_user_guid 
						and is_active = 1 and  is_deleted = 0 
						returning user_id into v_user_id ; 
						
						v_status := 1;
						v_message := 'Profile updated successfully.';
						else
							v_status := 0;
							v_message := 'user name already exists';
						end if;
						
					else
						if v_social_user_name !=  v_social_user_name_ex then  		
							v_status := 0;
							v_message := 'Unrecognized user.';
							
						else
		                  
							update labrstg.labrstg_web_user 
							set     
							--social_user_name = v_social_user_name,
									user_full_name = v_user_full_name,
									first_name = v_first_name,
									last_name = v_last_name,
									email_id = v_email_id,
									upper_email_id = v_upper_email_id,									
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
									campaign_id=v_campaign_id,
									sync_status=0,
									is_msg_sent = 1
							where user_guid = v_user_guid 
							and is_active = 1
							returning user_id into v_user_id ; 
							
							v_status := 1;
							v_message := 'Success'; 	
						end if;
					end if ;	
				
			/*	else 
            
					v_status := 0;
					v_message := 'Token mismatch.';
                    v_user_full_name := '';
					v_dob := '';
					v_email_id:= '';

				end if ; */
				
			end if ;
			
		else 
				v_status := 0;
				v_message := 'Unable to locate user information.';  
		
		end if ;
		 
		 else
		
			v_status := 0;
			v_message := 'Mobile NO already exists';
			
			end if;
		
		end if;
		
		
			  
		insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
		
       
		p_result := coalesce(v_user_id,1)  ;
			
    end if ; -- END p_opttype = 9 Update User  and return user data
	
    if p_opttype = 10 then   -- p_opttype = 10 User deleted 
         
    	if exists ( select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid and is_active = 1 and is_deleted  = 0
                    and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
        then 
			
			-- delete from labrstg.labrstg_web_user where user_guid = v_user_guid and is_active = 1 ;
			
           select email_id into v_email_id
           from labrstg.labrstg_web_user 
           where user_guid = v_user_guid 
           and is_active = 1 ;
            
            update labrstg.labrstg_web_user set  is_active  = 0 ,
            is_deleted =  1, updated_date = v_current_timestamp
            where user_guid = v_user_guid and is_active = 1
            and token =  v_token and epoch_timestamp = v_epoch_timestamp ; 
            
			insert into labrstg.labrstg_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;	
						
			v_status := 1;
            v_message := 'We have initiated the request to delete your information from our system. The process may take up to 72 hours to remove all information from our systems.';   
			
		else 
        	v_status := 0;
            v_message := 'Unknown request.';  
        end if ;
		
	   p_result := 1  ;        
				
	end if;  -- end p_opttype = 10 User deleted 
    
	--------------------------------------------------------------------------------------------------------
	
    if p_opttype = 11 then   -- p_opttype = 11 Do User Active and Login
        
		if (v_user_guid is not null and v_is_active = 1 and v_is_deleted  = 0) then 
		
			if v_client_id = 5 then 
									
					select failed_attempts , unlock_date, is_verified, user_full_name , verification_key,
							favourite_club, edition, email_id, profile_picture_url , is_custom_image
					into v_failed_attempts,  v_unlock_date, v_is_verified,  v_user_full_name, v_verification_key,
							v_favourite_club, v_edition, v_email_id , v_profile_picture_url, v_is_custom_image
					from labrstg.labrstg_web_user 
					where user_guid = v_user_guid					
					-- and is_active = 1
					and client_id = v_client_id  ;
					
					update labrstg.labrstg_web_user set is_active = v_is_active, is_deleted = v_is_deleted, updated_date = v_current_timestamp
					where user_guid = v_user_guid				
					-- and is_active = 1
					and client_id = v_client_id ;
										
					if ( v_is_verified != 1) then -- check user is verified or not       
							v_status := 3 ;
							v_message :=  'Verification Required. A verification email has been sent to your registered email address. Please check your inbox to complete the registration.';
							v_user_guid := v_verification_key;
							
				    else
						if v_user_full_name is null or v_mobile_no is null then
							v_status := 2 ;
							v_message := 'Incomplete Profile. Name and Email are required to proceed.';
							
						else
							if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then 
							
								update labrstg.labrstg_web_user  
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
                from labrstg.labrstg_web_user 
                where user_guid = v_user_guid				
                -- and is_active = 1
				;
                
				update labrstg.labrstg_web_user set is_active = v_is_active, is_deleted = v_is_deleted, updated_date = v_current_timestamp
                where user_guid = v_user_guid				
                -- and is_active = 1
				;				
				
				if v_email_id is null or v_user_full_name is null or v_mobile_no is null 
				then          	                   
					v_status = 2 ;
					v_message := 'Incomplete Profile. Name and Email are required to proceed.';
					--v_is_first_login := 1;  
				else                 	
					v_status = 1 ;
					 v_message := 'Login Successful';
				end if ;
				
        
			end if;	
            
							
		else
			
			v_status := 0 ; 
			v_message := 'Fail' ;
		end if ;
		
        insert into labrstg.labrstg_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
		select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
		
	  -- p_result := 1  ;            
				
	end if;  -- end p_opttype = 11  User  
    
    if p_opttype = 12 then  -- for User Logout 
    	
        if (select 1 from labrstg.labrstg_web_user where user_guid = v_user_guid ) then
    	
        	insert into labrstg.labrstg_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
            select nextval('labrstg.seq_labrstg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
            
            v_status := 1;
             v_message := 'Logout Successful';
            
        else 
        
			v_status := 0;
            v_message := 'Unknown request.'; 
            
        end if; 
                       
    end if ;    -- for User Logout End
        p_result := 1  ;
   		p_ures_json = '{
					  "data": {
					    "user_id": "'||coalesce(v_user_id::varchar,'')||'",
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"created_date": "'|| coalesce(v_registration_date::varchar,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"error": {
							"code": '||coalesce(v_status,0) ||',
							"message":  "'||coalesce(v_message,'')||'"
						},
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
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'" 
						},
						"is_first_login": "'||coalesce(v_is_first_login::varchar,'')||'",
						"is_msg_sent": "'||coalesce(v_is_msg_sent::varchar,'')||'",
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"	,
						"is_shared_data": "'|| coalesce(v_is_shared_data,'0') ||'" ,
						"is_used_data": "'|| coalesce(v_is_used_data,'0') ||'" ,
						"campaign_id": '|| coalesce(v_campaign_id,0) ||' 					  }
					}' ;  
end;
$$;


--
