-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_ins_web_users_encription(jsonb)
-- Type: FUNCTION

-- Name: isl_ins_web_users_encription(jsonb); Type: FUNCTION; Schema: isl; Owner: -
--

CREATE FUNCTION isl.isl_ins_web_users_encription(p_user_json jsonb, OUT p_result numeric) RETURNS numeric
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
   
     v_json jsonb; 
     v_user_bio character varying;
     
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 
 
 /*
 {
  "data": {
    "user_id": null,
    "user_guid": null,
    "client_id": null,
    "social_id": null,
    "social_user_name": null,
    "user_full_name": null,
    "email_id": null,
    "upper_email_id": null,
    "user_password": null,    
    "dob": null,
    "profile_picture_url": null,
    "city": null,
    "mobile_no": null,    
    "reset_key": null,
    "key_expiry_date": null,
    "reset_key_status": null,
    "old_password": null,
    "failed_attempts": null,
    "unlock_date": null,
    "user_bio": null,
    "is_registered": null,
    "created_date": null,
    "updated_date": null,
    "gender": null,
    "is_verified": null,
    "favourite_club": null,
    "token": null,
    "epoch_timestamp": null,
    "ipaddress": null,
    "edition": null,
    "is_login": null,
    "verification": null
  }
}
 */
	
   FOR v_json IN 
     select * from json_array_elements(p_user_json::json) U(ab) 
   loop 
   	select v_json->>'user_id',			   				
		   v_json->>'user_guid',
           v_json->>'client_id',          				
		   v_json->>'social_id',
           v_json->>'social_user_name',   				
		   v_json->>'user_full_name',  
		   v_json->>'email_id',						
		   v_json->>'upper_email_id',
		   v_json->>'user_password',					
		   v_json->>'dob',
		   v_json->>'profile_picture_url',				
		   v_json->>'city',
		   v_json->>'mobile_no',						
		   v_json->>'reset_key',
		   v_json->>'key_expiry_date',					
		   v_json->>'reset_key_status',
		   v_json->>'old_password',					
		   v_json->>'failed_attempts',
		   v_json->>'unlock_date',						
		   v_json->>'user_bio',
		   v_json->>'is_registered',					
		   v_json->>'created_date',
		   v_json->>'updated_date',					
		   v_json->>'gender',
		   v_json->>'is_verified',						
		   v_json->>'favourite_club',
		   v_json->>'token',							
		   v_json->>'epoch_timestamp',
		   v_json->>'ipaddress',						
		   v_json->>'edition',
		   v_json->>'is_login',						
		   v_json->>'verification_key'	   
          
    into    v_user_id,												
			v_user_guid,
			v_client_id,											
			v_social_id,
			v_social_user_name,										
			v_user_full_name,
			v_email_id,												
			v_upper_email_id,
			v_user_password,										
			v_dob,
			v_img_url,												
			v_city,
			v_mobile_no,											
			v_reset_key,
			v_key_expiry_date,										
			v_reset_key_status,
			v_old_password,											
			v_failed_attempts,
			v_unlock_date,											
			v_user_bio,
			v_is_registered,										
			v_created_date,
			v_updated_date,											
			v_gender, 
			v_is_verified,											
			v_favourite_club,
			v_token,												
			v_epoch_timestamp,
            v_ipaddress,											
			v_edition,
            v_is_login, 											
			v_verification_key;
            
           insert into isl.isl_web_user
            (user_id, user_guid, client_id, social_user_name, user_full_name, email_id, upper_email_id, user_password, social_id, 
            dob, profile_picture_url, city, mobile_no, reset_key, key_expiry_date, reset_key_status,
            old_password, failed_attempts, unlock_date, user_bio, is_registered, created_date, updated_date, gender,
            is_verified,
             -- favourite_club,  token, epoch_timestamp, ipaddress, edition, is_login, verification_key,
             is_active, is_deleted, created_by, updated_by
            )
            select  v_user_id, v_user_guid, v_client_id, v_social_user_name, coalesce(v_user_full_name,v_social_user_name), v_email_id,
            		v_upper_email_id, v_user_password, v_social_id, v_dob, v_img_url, v_city, v_mobile_no, v_reset_key, v_key_expiry_date,
                    v_reset_key_status,v_old_password, v_failed_attempts, v_unlock_date, v_user_bio, v_is_registered, v_created_date, 
                    v_updated_date, v_gender, v_is_verified,
                    -- , v_favourite_club, v_token, v_epoch_timestamp, v_ipaddress, v_edition, v_is_login, v_verification_key,
                    1, 0, 1, 1  ; 
   			
           update isl.isl_web_user_nonencript set is_process_encript = 1 
			where user_id = v_user_id ;
            
   end loop ;
        
   p_result := 1 ; 
/*   
 exception 
 	when others then 
     	p_result := -1 ; 
   */    
end;

$$;


--
