-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_social_login_25_05_2022(jsonb)
-- Type: FUNCTION

-- Name: labgt_social_login_25_05_2022(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_social_login_25_05_2022(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
   v_first_name character varying;
   v_last_name character varying;
   v_waf_user_guid character varying;
   v_is_shared_data numeric;
   v_is_used_data numeric;
   v_is_ind character varying;
   v_membership_code character varying;
   v_ext_info jsonb;
   v_is_shared_data_c character varying;
   v_is_used_data_C character varying;
   v_favourite_player_id character varying;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'user_guid',--1
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
    	   p_user_json->'data'->>'is_verified',--16
    	   p_user_json->'data'->>'ipaddress',--17
       	   p_user_json->'data'->'user'->>'mobile_no',--18
           p_user_json->'data'->'user'->>'name',--19
           p_user_json->'data'->'user'->>'social_user_name',--20
           p_user_json->'data'->'user'->>'dob',--21
           p_user_json->'data'->'user'->>'gender',--22
           p_user_json->'data'->'user'->>'city',--23
           p_user_json->'data'->'user'->>'favourite_club',--24
           p_user_json->'data'->'user'->>'edition',--25
           p_user_json->'data'->'user'->>'social_user_image',--26
           p_user_json->'data'->>'is_app',--27
           p_user_json->'data'->>'verification_key',--28
           p_user_json->'data'->>'is_deleted',--29
           p_user_json->'data'->>'is_active',--30
		   p_user_json->'data'->>'is_custom_image',--31
           p_user_json->'data'->'user'->>'country_id',--32
		   p_user_json->'data'->'user'->>'state_id',--33
		   p_user_json->'data'->'user'->>'city_id',--34
		   p_user_json->'data'->'user'->>'first_name',--35
		   p_user_json->'data'->'user'->>'last_name',--36
		   p_user_json->'data'->'user'->>'membership_code',--37
		   p_user_json->'data'->>'is_ind',--38
		   p_user_json->'data'->>'is_shared_data',--39
		   p_user_json->'data'->>'is_used_data'  --40
    
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
           v_is_verified,--16
           v_ipaddress,--17
           v_mobile_no,--18
           v_user_full_name,--19
           v_social_user_name,--20
           v_dob,--21
           v_gender, --22
           v_city,--23
           v_favourite_club,--24
           v_edition,--25
           v_profile_picture_url,--26
           v_is_app, --27
           v_verification_key,--28
           v_is_deleted,--29
           v_is_active,--30
        
		   v_is_custom_image,--31
		   v_country_id,--32
			v_state_id,--33
			v_city_id,--34
			v_first_name,--35
			v_last_name,--36
			v_membership_code,--37
			v_is_ind,--38
			v_is_shared_data_c,--39
			v_is_used_data_c;--40
			
			
           
   		
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
	
	
	--raise notice 'v_is_shared_data_c=%',v_is_shared_data_c;
	if v_is_ind='' or v_is_ind is null then
		v_is_ind:=0;
	end if;
	
	
	if v_is_shared_data_c='' or v_is_shared_data_c is null then
		v_is_shared_data:=0;
	else  
	 v_is_shared_data:=v_is_shared_data_c::int;
	end if;
	
	if v_is_used_data_c='' or v_is_used_data_c is null then
		v_is_used_data:=0;
	else  
	 v_is_used_data:=v_is_used_data_c::int;
	end if;
	
    		if not exists(select 1 from labgt.labgt_web_user where social_id = v_social_id
                          and client_id = v_client_id ) -- and v_is_shared_data=1 and v_is_used_data=1 
            then 
              if not exists (select 1 from labgt.labgt_web_user where email_id = v_email_id ) then
					v_web_user_id := nextval('labgt.seq_labgt_web_users_id');               
					v_user_guid := uuid_generate_v4();                 
					v_is_active := 1;
					v_is_deleted := 0;
					v_created_by := 1;
					v_updated_by := 1;              
					
					v_epoch_timestamp :=  EXTRACT(EPOCH FROM NOW())::bigint;
                
               
                    insert into labgt.labgt_web_user
                    (user_id, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password,
                     social_id, profile_picture_url, user_guid, is_active, is_deleted, created_by, updated_by, created_date, updated_date, is_registered,
                     is_verified, gender, epoch_timestamp, ipaddress, favourite_club, edition, is_custom_image,first_name,last_name,is_shared_data,is_used_data,membership_code,is_ind)
                    select v_web_user_id, v_client_id, v_social_user_name, v_user_full_name, v_email_id, v_upper_email_id, v_user_password,
                            v_social_id, v_profile_picture_url, v_user_guid, v_is_active, v_is_deleted, v_created_by, v_updated_by, v_created_date, v_updated_date,
                            1, v_is_verified,v_gender, v_epoch_timestamp, v_ipaddress, v_favourite_club, v_edition, v_is_custom_image,v_first_name,v_last_name,v_is_shared_data,v_is_used_data,v_membership_code,v_is_ind::int;

                    v_is_first_login := 1;            
                    v_result := v_web_user_id;
					
					else 
						v_social_id:=null;
						v_status = -5 ;
                        v_message := 'Email_id already exists';
                end if;
				
			end if;
			
   	if v_social_id is not null then
                   
		  select email_id, user_full_name,first_name,last_name, user_id, user_guid, is_deleted, favourite_club, edition,  profile_picture_url , is_custom_image, is_active,mobile_no,membership_code,ext_info,dob,gender,country_id,city,favourite_player_id
		  into v_email_id, v_user_full_name,v_first_name,v_last_name, v_user_id, v_user_guid, v_is_deleted, v_favourite_club, v_edition,  v_profile_picture_url, v_is_custom_image, v_is_active,v_mobile_no,v_membership_code,v_ext_info,v_dob,v_gender,v_country_id,v_city,v_favourite_player_id
		  from labgt.labgt_web_user 
		  where social_id = v_social_id
		  and client_id = v_client_id;   
		  
		        insert into labgt.labgt_web_user_audit
				(audit_id, user_id, user_guid, ipaddress, option_type, audit_date, is_app)
				select nextval('labgt.seq_labgt_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, 0, v_current_timestamp, coalesce(v_is_app,0) ;
				
				if v_email_id is null or v_first_name is null or v_last_name is null --or v_dob is null--or v_mobile_no is null 
				--or v_gender is null or v_country_id is null or v_city is null or v_favourite_player_id is null
							then                	                   
								v_status = 2 ;
								v_message := 'Incomplete Profile.';
							else                 	
								v_status = 1 ;
								v_message := 'Login Successful';
							end if ; 
	end if;
		
	
	p_ures_json = '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"token": "'|| coalesce(v_token,'') ||'",
						"epoch_timestamp": "'|| coalesce(v_epoch_timestamp,'') ||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "membership_code": "'|| coalesce(v_membership_code,'') ||'",
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
						"is_first_login": '|| coalesce(v_is_first_login,0) ||' ,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" ,
						"old_profile_img_url" : "'|| coalesce(v_old_profile_image_url,'') ||'"						
					  }
					}' ;  
					p_ures_json:=jsonb_set(p_ures_json, '{data,user,ext_info}',coalesce(v_ext_info,'null'), true);

end;
$$;


--
