-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_custom_login_forget_password(jsonb)
-- Type: FUNCTION

-- Name: labdsg_custom_login_forget_password(jsonb); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_custom_login_forget_password(p_user_json jsonb, OUT p_ures_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_user_full_name character varying;
    v_email_id character varying;
    v_subject text;
    v_first_name character varying;
	v_last_name character varying;
	v_status numeric;
	v_message text;
	v_is_verified numeric;
	v_upper_email_id character varying;
	v_created_date timestamp;
	v_updated_date timestamp;
	v_key_expiry_date timestamp;
	v_reset_key character varying;
	v_ipaddress character varying;
	v_user_id numeric;
	v_is_app numeric;
	v_platform_version numeric;
   v_device_name character varying;
   v_platform_type numeric;
   v_option_type numeric;
begin

 v_current_timestamp := current_timestamp at time zone 'utc';

    select 
    	   p_user_json->'data'->>'email_id',
		   p_user_json->'data'->>'reset_key',
		   p_user_json->'data'->>'ipaddress',
		   p_user_json->'data'->>'is_app',
		    p_user_json->'data'->>'platform_version',
			p_user_json->'data'->>'device_name',
			p_user_json->'data'->>'platform_type',
			p_user_json->'data'->>'option_type'
		   
    into   
           v_email_id,
		   v_reset_key,
		   v_ipaddress,
		   v_is_app,
		   v_platform_version,
			v_device_name,
			v_platform_type,
			v_option_type;
   		
        v_upper_email_id := v_email_id;
        v_created_date := v_current_timestamp;
        v_updated_date := v_current_timestamp; 
		v_option_type:=5;

		if exists(select 1 from labdsg.labdsg_web_user where client_id = 5 and upper_email_id = v_upper_email_id )
		then	
				v_status := 4 ;				 
				v_key_expiry_date := v_current_timestamp + interval '24 hours ' ; 
                
				select is_verified,first_name,last_name ,user_id
				into v_is_verified,v_first_name,v_last_name,v_user_id
                from labdsg.labdsg_web_user 
                where client_id = 5 and upper_email_id = v_upper_email_id;
                
				if v_is_verified = 1 then 
				
					update labdsg.labdsg_web_user  
					set  reset_key = v_reset_key, 
						 key_expiry_date = v_key_expiry_date, 
						 reset_key_status = 1, 
						 ipaddress = v_ipaddress,
						 updated_date = v_current_timestamp
					where upper_email_id = v_upper_email_id and client_id = 5 ;
					
					v_status := 1 ;
					
					v_message := 'Password Reset link has been sent to your registered email. Kindly check your inbox for further details. The link is valid up to 24 hrs.';
				else
                    
                        v_status := 3 ;
                        v_message :=  'Verification Required. A verification email has been sent to your registered email. Please check your inbox to complete the registration.';
                        
                end if;
				insert into labdsg.labdsg_web_user_audit
				(audit_id, user_id, user_guid, ipaddress, audit_date, is_app,platform_version,device_name,platform_type,option_type)
				select nextval('labdsg.seq_labdsg_web_user_audit_id'), v_user_id,  null, v_ipaddress, v_current_timestamp, coalesce(v_is_app,0),v_platform_version,v_device_name,v_platform_type,v_option_type;
		else
		        v_email_id:='';
				v_status := 0 ;
				v_message := 'Invalid email. Please provide your registered email and try again.';
				
		end if ;
		
        
        
	

		 v_subject := 'Reset your password' ;
	
				p_ures_json = '{
					  "data": {
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"subject": "'|| coalesce(v_subject,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,0)||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(v_option_type,0)||'",
						"user": {
						  "first_name": "'|| coalesce(v_first_name,'') ||'" ,
						  "last_name": "'||coalesce(v_last_name,'') ||'"
						}
					  }
					}' ;  

end;
$$;


--
