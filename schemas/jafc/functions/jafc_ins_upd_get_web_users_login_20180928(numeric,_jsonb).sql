-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_ins_upd_get_web_users_login_20180928(numeric, jsonb)
-- Type: FUNCTION

-- Name: jafc_ins_upd_get_web_users_login_20180928(numeric, jsonb); Type: FUNCTION; Schema: jafc; Owner: -
--

CREATE FUNCTION jafc.jafc_ins_upd_get_web_users_login_20180928(p_opttype numeric, p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
    v_client_id numeric;
    v_social_user_name character varying(100);
    v_user_full_name character varying(100);
    v_email_id character varying(100);
    v_user_password character varying(256);
    v_social_id character varying(100);
    v_upper_email_id character varying(100);
    v_web_user_id numeric;
    v_user_guid character varying(256);
    v_is_active numeric;
    v_is_deleted numeric;
    v_created_by numeric;
    v_updated_by numeric;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_reset_key character varying(256);
    v_key_expiry_date timestamp without time zone;
    v_reset_key_status numeric;
    v_dob date;
    v_profile_picture_url character varying(100);
    v_city character varying(100);
    v_mobile_no character varying(20);
    v_gender character varying(10);
    v_sport_skill json;
    v_sport_skill_map json; 
    v_sport_id numeric;
    v_skill_level numeric;
    v_result numeric;
    v_is_verified numeric;
    v_is_custom  numeric;
    v_userjson jsonb;
    v_favourite_club character varying(2000);
    v_edition character varying(2000);
    v_status numeric; 
    v_is_first_login   numeric := 0 ;
    v_token  character varying(2000);
    v_epoch_timestamp  character varying(200);
    v_confirm_password character varying(200);
    v_old_password character varying(200);
    v_failed_attempts numeric;
    v_unlock_date timestamp;
    v_is_registered  numeric;
    v_ipaddress   character varying(200);
    v_message character varying(2000);
    v_is_app numeric;
    v_user_id numeric;
    v_img_url character varying(2000);
    v_is_login numeric;
	
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
           p_user_json->'data'->'user'->>'img_url',
            p_user_json->'data'->>'is_app'
         
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
           v_img_url,
           v_is_app;
   		
        v_upper_email_id := upper(trim(v_email_id));
         
    /* ****************************************
      Client_id     Client 
      1   			Facebook
      2             Twitter
      3 			Google+
      5				Custom
    ****************************************  */
    
    if p_opttype = 1 then   -- p_opttype = 1 Social Login
   
    		if not exists(select 1 from jafc.jafc_web_user where social_id = v_social_id
                          and client_id = v_client_id  and is_active = 1)
            then 
            
                v_web_user_id := nextval('jafc.seq_jafc_web_users_id');               
                v_user_guid := uuid_generate_v4();                 
                v_is_active := 1;
                v_is_deleted := 0;
                v_created_by := 1;
                v_updated_by := 1;
                v_created_date := v_current_timestamp;
                v_updated_date := v_current_timestamp;   
				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
                
                if v_email_id is null or v_user_full_name is null  
                then
                   raise notice 'opttype 1 Test 1' ;
                	v_status = 2 ;
                    v_message := 'Login Is Incomplite : Name or Email_id is missing';
                    v_is_verified = 0 ; 
                else 
               		 raise notice 'opttype 1 Test 2' ;
                	v_is_verified = 1; 
                	v_status = 1 ;
                    v_message := 'Login Is Successfull';
                end if ;
               
               raise notice 'opttype 1 Test 3' ;
               
                insert into jafc.jafc_web_user
                (user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
                 social_id, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
                 is_verified, gender, epoch_timestamp, ipaddress)
                select v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password,
                		v_social_id,  v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,
                        1, v_is_verified,v_gender, v_epoch_timestamp, v_ipaddress;
				                
                v_is_first_login := 1;            
                 
            	v_result := v_web_user_id;
                 
            else
            	raise notice 'opttype 1 else  Test 4' ;
                
                select email_id, user_full_name, user_id, user_guid
                into v_email_id, v_user_full_name, v_user_id, v_user_guid 
                from jafc.jafc_web_user 
                where social_id = v_social_id
                and client_id = v_client_id
                and is_active = 1;
                
                if v_email_id is null or v_user_full_name is null 
                then
                	raise notice 'opttype 1 Test 5' ;
                	v_status = 2 ;
                    v_message := 'Login Is Incomplite : Name or Email_id is missing';
                    v_is_first_login := 1;  
                else 
                	
                	v_status = 1 ;
                     v_message := 'Login Is Successfull ';
                end if ; 
            	p_result := v_user_id  ;
                
            end if ;
            
    	 insert into jafc.jafc_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
         p_result := v_user_id  ;
      	
       /*  raise notice 'v_user_guid %' , v_user_guid; 
          
         raise notice 'v_status %' , v_status; 
         raise notice 'v_message %' , v_message; 
         raise notice 'v_user_full_name %' , v_user_full_name; 
         raise notice 'v_is_first_login %' , v_is_first_login; 
         raise notice 'v_is_app : %' , v_is_app; 
       
         select 1/0 ;
         */
         p_ures_json := ' {
                          "data": {
                            "user_guid": "'|| v_user_guid ||'",
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,  
                            "error": { "code": null,
                                       "message": null
                            		  },
                            "user": { "name": "'|| coalesce(v_user_full_name,'') ||'"
                                    },
                            "is_first_login": '|| v_is_first_login ||'
                            ,   "is_app": '|| coalesce(v_is_app,0) ||'
                           }
                       }' ;
                      
    end if;    -- end if :  p_opttype = 1 Social Login 
    
    -- -----------------------------------------------------------------------------------------------------------------------------
   	
    -- -----------------------------------------------------------------------------------------------------------------------------
   if p_opttype = 7 then   -- p_opttype = 7 Get User  
    
    	if exists (select 1 from jafc.jafc_web_user where user_guid = v_user_guid and is_active = 1)
        then 
        	v_token :=  uuid_generate_v4();
           v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
           
            raise notice 'P1 : %' , v_epoch_timestamp;
            
            update jafc.jafc_web_user set token = v_token, epoch_timestamp = v_epoch_timestamp
            where user_guid = v_user_guid 
            and is_active = 1	;                 
                        
        	select  user_id, email_id, mobile_no, user_full_name, social_user_name, dob, favourite_club, edition, gender, city
            into v_user_id, v_email_id, v_mobile_no, v_user_full_name, v_social_user_name, v_dob, v_favourite_club, v_edition, v_gender, v_city
            from jafc.jafc_web_user
            where user_guid = v_user_guid and is_active = 1	  ;
			
			v_message := 'Success : User Login'; 			
            v_status := 1 ;
            
        else
        	v_status := 0;
            v_message := 'Failed : User not Exists'; 			
                    
        end if; 
        
        insert into jafc.jafc_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
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
                      "dob": "'|| coalesce(v_dob::varchar,'') ||' ",
                      "gender": "'|| coalesce(v_gender,'') ||'",
                      "city": "'|| coalesce(v_city,'')||'",
                      "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
                      "edition": "'|| coalesce(v_edition,'') ||'"
                    },
                    "is_first_login": 0,
                    "is_app": "'|| coalesce(v_is_app,0) || '"
                  }
                }';		
    
    end if ;  -- end  p_opttype = 7 Get User
    
    if p_opttype = 8 then   -- p_opttype = 8 Update User  
     
    
    	if exists ( select 1 from jafc.jafc_web_user where user_guid = v_user_guid and is_active = 1
                    and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
        then 
        	v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
								
			update jafc.jafc_web_user 
			set     social_user_name = v_social_user_name,
					user_full_name = v_user_full_name,
					email_id = v_email_id,
					upper_email_id = v_upper_email_id,									
					dob =  v_dob,
					profile_picture_url = v_img_url ,
					city = v_city,
					mobile_no = v_mobile_no,	
					-- user_bio = ,	
					updated_date = v_current_timestamp,
					gender = v_gender ,					
					favourite_club = v_favourite_club,
					token =  v_token,
					epoch_timestamp = v_epoch_timestamp ,
					ipaddress = v_ipaddress,
					edition =  v_edition
                   -- , is_verified = 1
			where user_guid = v_user_guid 
			and is_active = 1
            returning user_id into v_user_id ; 
			
			v_status := 1;
            v_message := 'Success : Profile Updated';	
			
		else 
        	v_status := 0;
            v_message := 'Failed : Token or Epoch_timestamp not validate ';	
        end if ;
		
        insert into jafc.jafc_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
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
			"is_app": "'|| coalesce(v_is_app,0) || '"
		  }
		}' ;

    end if ;
    
    if p_opttype = 9 then   -- p_opttype = 9 Update User  and return user data     
    
    	if exists ( select 1 from jafc.jafc_web_user where user_guid = v_user_guid and is_active = 1
                    and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
        then 
             raise notice 'opttype 9 test 1 ';     
             
        	v_token :=  uuid_generate_v4();
            v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
								
			update jafc.jafc_web_user 
			set     social_user_name = v_social_user_name,
					user_full_name = v_user_full_name,
					email_id = v_email_id,
					upper_email_id = v_upper_email_id,									
					dob =  v_dob,
					profile_picture_url = v_img_url ,
					city = v_city,
					mobile_no = v_mobile_no,	
					-- user_bio = ,	
					updated_date = v_current_timestamp,
					gender = v_gender ,					
					favourite_club = v_favourite_club,
					token =  v_token,
					epoch_timestamp = v_epoch_timestamp ,
					ipaddress = v_ipaddress,
					edition =  v_edition
                   -- , is_verified = 1
			where user_guid = v_user_guid 
			and is_active = 1
			returning jafc_web_user.user_id into v_user_id ; 
			           
			v_status := 1;
            v_message := 'Success : Profile Updated';	
			
		else 
        	
        	raise notice 'opttype 9 test 2 ';   
        	v_status := 0;
            v_message := 'Failed : Token or Epoch_timestamp not validate ';	
        end if ;
		
        raise notice 'opttype 9 test 3 ';   
		insert into jafc.jafc_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
		
        /*
         raise notice 'v_user_guid %' , v_user_id;           
         raise notice 'v_status %' , v_status; 
         raise notice 'v_message %' , v_message; 
         raise notice 'v_user_full_name %' , v_user_full_name; 
         raise notice 'v_is_first_login %' , v_is_first_login; 
         raise notice 'v_is_app : %' , v_is_app; 
         raise notice 'v_token : %' , v_token; 
       	 raise notice 'v_epoch_timestamp : %' , v_epoch_timestamp; 
         raise notice 'v_mobile_no : %' , v_mobile_no; 
         raise notice 'v_user_full_name : %' , v_user_full_name; 
         raise notice 'v_social_user_name : %' , v_social_user_name; 
         raise notice 'v_token : %' , v_token; 
         raise notice 'v_token : %' , v_token; 
        */      
       
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
						  "dob": "'|| coalesce(v_dob::varchar,'') ||' ",
						  "gender": "'|| coalesce(v_gender,'') ||'",
						  "city": "'|| coalesce(v_city,'')||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'"
						},
						"is_first_login": 0,
						"is_app": 0
					  }
					}' ;
            
          raise notice 'userjson : % ',  p_ures_json ;
			
    end if ; -- END p_opttype = 9 Update User  and return user data
	
    if p_opttype = 10 then   -- p_opttype = 10 User deleted 
         
    	if exists ( select 1 from jafc.jafc_web_user where user_guid = v_user_guid and is_active = 1
                    and token =  v_token and epoch_timestamp = v_epoch_timestamp ) 
        then 
			
			delete from jafc.jafc_web_user where user_guid = v_user_guid and is_active = 1 ;
			
			insert into jafc.jafc_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
			select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;	
						
			v_status := 1;
            v_message := 'Success : User Profile Deleted';	
			
		else 
        	v_status := 0;
            v_message := 'Failed : Token or Epoch_timestamp not validate ';	
        end if ;
		
	   p_result := 1  ;        
       p_ures_json := ' {
                          "data": {
                            "user_guid": "'|| v_user_guid ||'",
                            "status": '|| v_status ||' ,
                            "message": "'|| v_message ||'" ,
                            "error": {
							"code": '|| v_status ||',
							"message":  "'|| v_message||'"
							},
                            "user": { "name": ""
                                    },
                            "is_first_login": '|| v_is_first_login ||'
                            , "is_app": '|| v_is_app ||'
                           }
                       }' ;
				
	end if;  -- end p_opttype = 10 User deleted 
    
    if p_opttype = 2 then   -- p_opttype = 2 Custom Login  
    
    		if not exists(select 1 from jafc.jafc_web_user where client_id = v_client_id and upper_email_id = v_upper_email_id and is_active = 1)
            then 
                v_web_user_id := nextval('jafc.seq_jafc_web_users_id');
                v_user_guid := uuid_generate_v4();
                v_is_active := 1;
                v_is_deleted := 0; 
				v_is_verified = 0 ; 				
                v_created_date := v_current_timestamp;
                v_updated_date := v_current_timestamp;  				
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                v_is_login := 0;			                
                  
                insert into jafc.jafc_web_user
                (user_id, client_id, email_id, upper_email_id, user_password, user_guid, is_active, is_deleted, created_date, updated_date, is_registered,
				is_verified, token, epoch_timestamp, ipaddress, is_login )
                select v_web_user_id, v_client_id, v_email_id, v_upper_email_id, v_user_password, v_user_guid, v_is_active, v_is_deleted, v_created_date, v_updated_date,
                        1, v_is_verified, v_token, v_epoch_timestamp, v_ipaddress, v_is_login;
				                 
                v_is_first_login := 1;  
				
				v_status := 3 ;						
				v_message := 'Registration Successfull : Verification Required' ; 
                             	
            else
            
				select is_verified into v_is_verified
				from jafc.jafc_web_user 
				where client_id = v_client_id and upper_email_id = v_upper_email_id and is_active = 1 ;
				
				if v_is_verified = 0 then 					
					v_status = 0 ; 
					v_message := 'Fail : Please Verify Email_id ';	
				else
					v_status = 0 ; 
					v_message := 'Fail : Already Verified, Login';					
				end if ;		
				 
				v_is_first_login := 0;   
				v_is_login = 0 ;
				
            end if ;
			
            insert into jafc.jafc_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
			select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
        
			p_ures_json := '{
			  "data": {
				"user_guid": "'|| coalesce(v_user_guid,'') ||'",
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
			
			
	end if ;
    
	if p_opttype = 3 then   -- p_opttype = 3 Custom Login Email Verification 
    
    		if not exists(select 1 from jafc.jafc_web_user where client_id = v_client_id and token = v_token and is_active = 1)
            then 
				 update jafc.jafc_web_user set is_verified = 1, is_login = 0, ipaddress = v_ipaddress, updated_date = v_current_timestamp
                 where client_id = v_client_id and token = v_token and is_active = 1 ;				   
				 	
				 v_status := 2 ;
				 v_message := 'Success : Verified Email id, Incomplite Profile';		
			else
				v_status := 0 ;	
				v_message := 'Fail :  Email id Verification fail';						
			end if ; 
			 v_is_first_login := 0;
			 v_is_login := 0 ;	
			 
             insert into jafc.jafc_web_user_audit
			 (audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
			 select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
        
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
			 
	end if;  --  end p_opttype = 3 Custom Login Email Verification 
    
     if p_opttype = 4 then   -- p_opttype = 4 Custom Login Email Verification 	
		
		if exists(select 1 from jafc.jafc_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id 
				  and user_password = v_user_password and is_active = 1                   
				  )
		then
							
			select failed_attempts , unlock_date, is_verified into v_failed_attempts,  v_unlock_date, v_is_verified 
			from jafc.jafc_web_user 
			where upper_email_id = v_upper_email_id and is_active = 1
		    and client_id = v_client_id  ;
			
            if ( v_is_verified != 1) then -- check user is verified or not       
               	v_status := 0 ;
				v_message := 'Fail : EmailId not Verified';
            else
                if (coalesce(v_unlock_date, v_current_timestamp) <= v_current_timestamp) then 

                    update jafc.jafc_web_user  
                    set  failed_attempts = 0, unlock_date = null, updated_date = v_current_timestamp,
                         ipaddress = v_ipaddress
                    where upper_email_id = v_upper_email_id and client_id = v_client_id and is_active = 1 ;

                    v_status := 1 ;
                    v_message := 'Success : Login Successfull';
                else				
                    v_status := 0 ;
                    v_message := 'Fail : Your Login is Locked';
				end if;
			end if ;			
		else
			
			v_status := 0 ;
			v_message := 'Fail : Login Fail, provided Right Creditial';
			
			select coalesce(failed_attempts,0) +1 into v_failed_attempts 
			from jafc.jafc_web_user 
			where upper_email_id = v_upper_email_id and is_active = 1
		    and client_id = v_client_id  ;
			
			
			if v_failed_attempts >= 3 then             
			
				v_unlock_date = v_current_timestamp + interval '24 hours' ;
				update jafc.jafc_web_user  
                set  failed_attempts = failed_attempts + 1, 
                	 unlock_date = v_unlock_date ,
                     updated_date = v_current_timestamp,
                     ipaddress = v_ipaddress
				where upper_email_id = v_upper_email_id and client_id = v_client_id and is_active = 1 ;
				
			else
				update jafc.jafc_web_user 
                set  failed_attempts = failed_attempts + 1, updated_date = v_current_timestamp ,
                	 ipaddress = v_ipaddress
				where upper_email_id = v_upper_email_id and client_id = v_client_id and is_active = 1 ;
				
			end if ;
		end if ; 
		
        insert into jafc.jafc_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
                
		p_ures_json := '{
						  "data": {
							"user_guid": "",
							"status": "'|| v_status ||'",
							"message": "'||v_message || '",
							"error": {
								"code": null,
								"message": null
							},
							"failed_attempts": '|| v_failed_attempts || ',
							"unlock_date": "'|| v_unlock_date ||'",
							"user": {
									  "name": ""
									},
									"is_first_login": "'|| v_is_first_login || '",
									"is_app": '|| v_is_app ||'
						  }
						}' ;
	
	end if;
    
    if p_opttype = 5 then   -- p_opttype = 5 Custom Login Forget Password 
		
		if exists(select 1 from jafc.jafc_web_user 
				  where client_id = v_client_id and upper_email_id = v_upper_email_id  and is_active = 1
				  )
		then	
				v_status := 4 ;				 
				v_key_expiry_date := v_current_timestamp + interval '24 hours ' ; 
				v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;  
                
				update jafc.jafc_web_user  
                set  reset_key = v_token, 
                	 token = v_token, 
                     key_expiry_date = v_key_expiry_date, 
                	 reset_key_status = 1, 
                     epoch_timestamp = v_epoch_timestamp,
                     ipaddress = v_ipaddress,
                     updated_date = v_current_timestamp
				where upper_email_id = v_upper_email_id and client_id = v_client_id and is_active = 1 ;
				
				v_message := 'Success : Reset link sent on registered email and is valid for 24 hours';
		else
				v_status := 0 ;
				v_message := 'Fail : EmailId not exists ';
				
		end if ;
		
        insert into jafc.jafc_web_user_audit
		(audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
        
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
	
	end if ;  -- -- end p_opttype = 5 Custom Login Forget Password 
	
    
	if p_opttype = 6 then   -- p_opttype = 6 Custom Login Update Password 	
		
		if exists (select 1 from jafc.jafc_web_user 
				   where client_id = v_client_id and upper_email_id = v_upper_email_id 
					and token = v_token and is_active = 1 )
		then
			
			if exists (select 1 from jafc.jafc_web_user 
				       where client_id = v_client_id and upper_email_id = v_upper_email_id 
					   and token = v_token and is_active = 1
					   and key_expiry_date >= v_current_timestamp)
			then
				v_status := 5; 
				
				update jafc.jafc_web_user  
				set old_password = user_password,
					user_password = v_user_password,
					failed_attempts = 0, 
					unlock_date = null, 
					updated_date = v_current_timestamp,
					reset_key = null,
					reset_key_status = 0,
					unlock_date = null
				where upper_email_id = v_upper_email_id 
				and client_id = v_client_id 
				and token = v_token and is_active = 1
			    and key_expiry_date >= v_current_timestamp;
				
				v_message := 'Success : Password Successfully Changed';
				
			else
				v_status := 6 ;
				v_message := 'Fail : Reset Token is Expired';
			end if;
			
		else
			v_status := 6 ;
			v_message := 'Fail : Not valid Token ';
		end if; 	
		
		 insert into jafc.jafc_web_user_audit
		  (audit_id, user_id, user_guid, ipaddress, option_type, audit_date)
		 select nextval('jafc.seq_jafc_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp ;
        
		
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
			  "name": "abc"
			},
			"is_first_login": "'|| v_is_first_login || '",
			"is_app": '|| v_is_app ||'
		  }
		}' ;
		
	end if ;
    
    -- select 1/0 ;
    p_result := 1  ; 
    
exception 
		when others then 
             p_result := -1 ;
             
end;

$$;


--
