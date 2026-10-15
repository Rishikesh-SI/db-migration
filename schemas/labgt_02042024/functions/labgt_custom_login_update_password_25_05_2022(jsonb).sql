-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_custom_login_update_password_25_05_2022(jsonb)
-- Type: FUNCTION

-- Name: labgt_custom_login_update_password_25_05_2022(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_custom_login_update_password_25_05_2022(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_created_date timestamp without time zone;
    v_updated_date timestamp without time zone;
    v_reset_key character varying;
    v_key_expiry_date timestamp without time zone;
    v_status numeric; 
	v_ipaddress character varying;
	v_is_app numeric;
	v_message character varying;
	v_user_id numeric;
	v_user_password  character varying;
	v_option_type numeric;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'reset_key',
           p_user_json->'data'->>'ipaddress',
           p_user_json->'data'->>'is_app',
		   p_user_json->'data'->>'password'
		   
    into  
           v_reset_key,
           v_ipaddress,
           v_is_app,
		   v_user_password;
		   
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp;   

		
		if exists (select 1 from labgt.labgt_web_user 
				   where client_id = 5 and reset_key = v_reset_key)
		then
        	
             select key_expiry_date,user_id
             into v_key_expiry_date,v_user_id
             from labgt.labgt_web_user 
			 where client_id = 5            
			 and reset_key = v_reset_key ;
			
			if v_key_expiry_date > v_current_timestamp            
            then
				v_status := 1;
				update labgt.labgt_web_user  
				set old_password = user_password,
					user_password = v_user_password,
					failed_attempts = 0, 					
					updated_date = v_current_timestamp,
					reset_key = null,
					reset_key_status = 0,
					unlock_date = null,                    
                    verification_key = null
				where 
                client_id = 5 
				and reset_key = v_reset_key 
			    and key_expiry_date >= v_current_timestamp;
				
				v_message :=  'Password has been updated.';

			insert into labgt.labgt_web_user_audit
			(audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app)
			select nextval('labgt.seq_labgt_web_user_audit_id'), v_user_id,  null, v_ipaddress, 0, v_current_timestamp, coalesce(v_is_app,0) ;				
				
			else
				v_status := 0 ;
				v_message := 'Password reset token has expired. Please raise another request.';
			end if;
			
		else
			v_status := 0 ;
			v_message := 'Invalid token. Please check the link and try again.';
		end if; 	
		
		
        
p_ures_json = '{
					  "data": {
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'"
					  }
					}' ; 

end;
$$;


--
