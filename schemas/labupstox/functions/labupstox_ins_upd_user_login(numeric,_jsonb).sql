-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labupstox
-- Object: labupstox_ins_upd_user_login(numeric, jsonb)
-- Type: FUNCTION

-- Name: labupstox_ins_upd_user_login(numeric, jsonb); Type: FUNCTION; Schema: labupstox; Owner: -
--

CREATE FUNCTION labupstox.labupstox_ins_upd_user_login(p_opttype numeric, p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
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
    v_is_new_reg numeric:=0;
    v_reg_cnt numeric:=0;
	v_gift_id numeric:=0;
	v_gift_url text;
	v_gift_name varchar(500):='NO GIFT';
	v_available_quantity numeric;
	v_gratification_value numeric;
	v_profile_complete numeric;
	v_better_luck_value numeric;
	v_access_token text;
	v_pincode text;
	v_race_category_id numeric;
	v_race_category_id_chk numeric;
	v_address text;
	 v_ext_message text;
	
	begin

		v_current_timestamp := current_timestamp at time zone 'utc';
 

		select 	p_user_json->'data'->>'user_guid',
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
			--  p_user_json->'data'->>'created_date',
			--  p_user_json->'data'->>'updated_date',
			--  p_user_json->'data'->'is_deleted',    
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
			--  p_user_json->'data'->>'social_user_image',
				p_user_json->'data'->>'is_custom_image',
				p_user_json->'data'->'user'->>'country_id',
				p_user_json->'data'->'user'->>'state_id',
				p_user_json->'data'->'user'->>'city_id',
				p_user_json->'data'->>'access_token',
				p_user_json->'data'->'user'->>'pincode',
				p_user_json->'data'->'user'->>'race_category_id',
				p_user_json->'data'->'user'->>'address',
				p_user_json->'data'->>'message'
           
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
			   v_access_token,
			   v_pincode,
			   v_race_category_id,
			   v_address,
			   v_ext_message;
   
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;  
    /* ****************************************
      Client_id     Client
      2   Facebook
      3             Twitter
      4 Google+
      5 Custom
    ****************************************  */
   
			if p_opttype = 1 then   -- p_opttype = 1 Social Login
   
	 if not exists(select 1 from
				   labupstox.labupstox_web_user
				   where upper(email_id)=upper(v_email_id) ) then
						  
				v_user_guid := uuid_generate_v4();                
					v_is_active := 1;
					v_is_deleted := 0;
					v_created_by := 1;
					v_updated_by := 1;              
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
               
	   v_web_user_id := nextval('labupstox.seq_labupstox_web_users_id'); 
						
	 	insert into labupstox.labupstox_web_user
								(user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
								social_id, profile_picture_url, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
								is_verified, gender, epoch_timestamp, ipaddress, favourite_club, edition, is_custom_image,acces_token)
      	select  v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password,
								v_social_id, v_profile_picture_url, v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,
								1, v_is_verified,v_gender, v_epoch_timestamp, v_ipaddress, v_favourite_club, v_edition, v_is_custom_image ,v_access_token;
                
				insert into labupstox.labupstox_user_master
				(user_id,email_id,user_guid)
				select nextval('labupstox.seq_labupstox_user_id'),
				     v_ext_message,
					 v_user_guid;
				v_status:=1;
						v_is_first_login := 1;            
						v_result := v_web_user_id;
						 
				 
         else
		    
			     
				 -- raise notice 'opttype 1 else  Test 4' ;                     
					v_email_social:= v_email_id;
				  --v_mobile_social:= v_mobile_no;
					v_profile_image_social:= v_profile_picture_url;
               
                select email_id, user_full_name, user_id, user_guid, is_deleted, favourite_club, edition,  profile_picture_url ,
					  is_custom_image, is_active,race_category_id
				into  v_email_id, v_user_full_name, v_user_id, v_user_guid, v_is_deleted, v_favourite_club, v_edition,  v_profile_picture_url, 
					  v_is_custom_image, v_is_active,v_race_category_id
				from labupstox.labupstox_web_user
                where email_id=v_email_id;
               
                v_email_id:=coalesce(v_email_social,v_email_id);
               
                if v_is_custom_image!=1
                then
                v_profile_picture_url:=coalesce(v_profile_image_social,v_profile_picture_url);
               
                end if ;
                               
                
             -- and is_active = 1;

                      
				if coalesce(v_is_deleted,0) = 1 and v_is_active = 0 then

					v_status = 7 ;
					v_message := 'You have a pending account delete request. Proceed to cancel this request and restore your account.';
					v_is_first_login := 0 ;

				else

					--if v_email_id is null or v_user_full_name is null
					--then                                  
					-- raise notice 'opttype 1 Test 5' ;
					if  v_email_id is null  then
					    v_status = 2 ;
						v_message := 'Incomplete Profile. Name and Email are required to proceed.';
						v_is_first_login := 1;  
					else                
						v_status = 1 ;
						v_message := 'Login Successful';
					end if ;

				end if;
         	p_result := v_user_id  ;
        	insert into labupstox.labupstox_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
			select nextval('labupstox.seq_labupstox_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0) ;
        
     
       	
			
			end if;
			
		
			 end if;    -- end if :  p_opttype = 1 Social Login
   
    -- -----------------------------------------------------------------------------------------------------------------------------
			
----------------------------------------------------------------------------
        p_result := 1  ;
		 
			p_ures_json = '{
				"data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"client_id": '||coalesce(v_client_id,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"error": {
						"code": '||coalesce(v_status,0) ||',
						"message":  "'||coalesce(v_message,'')||'"
						},
				"user": {
						 "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						 "name": "'||coalesce(v_user_full_name,'') ||'",
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
						 "social_user_image": "'|| coalesce(v_profile_picture_url,v_old_profile_image_url,'') ||'",
						 "pincode": "'|| coalesce(v_pincode::varchar,'') ||'",
						 "race_category_id": "'|| coalesce(v_race_category_id::varchar,'') ||'",
						 "address": "'|| coalesce(v_address,'') ||'"
						},
						 "is_first_login": 0,
						 "is_app": '|| coalesce(v_is_app,0) ||' ,
						 "is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						 "old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"
		                }
		                   }' ;

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
				   -- return ;
			  */    
	end;

	$$;


--
