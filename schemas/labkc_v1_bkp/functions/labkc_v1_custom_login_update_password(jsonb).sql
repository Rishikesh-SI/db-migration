-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_custom_login_update_password(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_custom_login_update_password(jsonb); Type: FUNCTION; Schema: labkc_v1_bkp; Owner: -
--

CREATE FUNCTION labkc_v1_bkp.labkc_v1_custom_login_update_password(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
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
	v_platform_version numeric;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
   
begin

 v_current_timestamp := current_timestamp at time zone 'utc';
 

    select p_user_json->'data'->>'reset_key',
           p_user_json->'data'->>'ipaddress',
           p_user_json->'data'->>'is_app',
		   p_user_json->'data'->>'password',
		   p_user_json->'data'->>'platform_version',
			p_user_json->'data'->>'device_name',
			p_user_json->'data'->>'platform_type',
			p_user_json->'data'->>'option_type'
		   
    into  
           v_reset_key,
           v_ipaddress,
           v_is_app,
		   v_user_password,
		   v_platform_version,
			v_device_name,
			v_platform_type,
			v_option_type;
		   
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp; 
		v_option_type:=6;

		
		if exists (select 1 from labkc_v1.labkc_v1_web_user 
				   where client_id = 5 and reset_key = v_reset_key)
		then
        	
             select key_expiry_date,user_id
             into v_key_expiry_date,v_user_id
             from labkc_v1.labkc_v1_web_user 
			 where client_id = 5            
			 and reset_key = v_reset_key ;
			
			if v_key_expiry_date > v_current_timestamp            
            then
				v_status := 1;
				update labkc_v1.labkc_v1_web_user  
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

			insert into labkc_v1.labkc_v1_web_user_audit
			(audit_id, user_id, user_guid, ipaddress,audit_date,is_app,platform_version,device_name,platform_type,option_type)
			select nextval('labkc_v1.seq_labkc_v1_web_user_audit_id'), v_user_id,null, v_ipaddress, v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_device_name,v_platform_type,v_option_type;				
				
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
						"message": "'|| coalesce(v_message,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'"
					  }
					}' ; 

end;
$$;


--
