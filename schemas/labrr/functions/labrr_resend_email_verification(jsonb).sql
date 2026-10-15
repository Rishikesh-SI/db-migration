-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_resend_email_verification(jsonb)
-- Type: FUNCTION

-- Name: labrr_resend_email_verification(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_resend_email_verification(p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_email_id character varying;
	v_verification_key character varying;
	v_user_id numeric;
	v_user_guid character varying;
	p_opttype numeric:=10;
	v_platform_type numeric;
	v_device_name character varying;
	v_platform_version character varying;
	v_status numeric;
	v_message character varying;
	v_captcha character varying;
	v_first_name character varying;
	v_last_name character varying;
	v_user_full_name character varying;
	v_is_app numeric;
	v_ipaddress character varying;
	v_reset_key character varying;
	v_subject character varying;
	v_attempts numeric;
    v_failed_attempts numeric;
   v_attempt_date timestamp;
   
   begin

    select p_user_json->'data'->>'email_id',
           p_user_json->'data'->>'is_app',
           p_user_json->'data'->>'ipaddress',
           p_user_json->'data'->>'platform_version',
           p_user_json->'data'->>'platform_type', 
		   p_user_json->'data'->>'reset_key',
		   p_user_json->'data'->>'device_name',
		   p_user_json->'data'->>'captcha'
   into
  		  v_email_id,
		  v_is_app,
		  v_ipaddress,
		  v_platform_version,
		  v_platform_type,
		  v_verification_key,
		  v_device_name,
		  v_captcha;

 v_current_timestamp := current_timestamp at time zone 'utc';

		   select user_guid,user_id,first_name,last_name,email_id,user_full_name,attempt,attempt_date
		   into v_user_guid, v_user_id,v_first_name,v_last_name,v_email_id,v_user_full_name,v_failed_attempts, v_attempt_date
		   from labrr.labrr_web_user 
		   where email_id = v_email_id and client_id=5 ;
		   

       if (select 1 from labrr.labrr_web_user where email_id = v_email_id 
		   and client_id=5) then
		   
		   
		   if (select 1 from labrr.labrr_web_user where email_id = v_email_id 
		   and client_id=5 and is_verified <>1 ) then
		   
		   v_failed_attempts := coalesce(v_failed_attempts,0)+ 1;
		   
		   if v_failed_attempts<= 3 and  (v_current_timestamp < v_attempt_date + '1 hours'::interval 
								or v_attempt_date is null )then
		   
				   v_status := 1;
				   v_subject:='Email Verification';

				   update labrr.labrr_web_user
				   set verification_key =v_verification_key,
				   attempt_date=v_current_timestamp,attempt = v_failed_attempts 
				   where email_id = v_email_id and client_id=5;
    		
		     elseif v_current_timestamp > v_attempt_date + '1 hours'::interval then
		   
			   v_failed_attempts := 1;

			   update labrr.labrr_web_user
			   set verification_key =v_verification_key,
			   attempt_date=v_current_timestamp,attempt = v_failed_attempts
			   where email_id = v_email_id and client_id=5;
		   
   		   end if;

        	insert into labrr.labrr_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app,platform_type,device_name,platform_version)
            select nextval('labrr.seq_labrr_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0),v_platform_type,v_device_name,v_platform_version ;

			   select count(1) into v_attempts 
			   from labrr.labrr_web_user_audit 
			   where user_guid = v_user_guid
			   and option_type=10;

 					
			if v_failed_attempts <= 3 then
			
            	v_status := 1;
             	v_message := 'Verification email sent successfully';
				v_subject := 'Verify your Email';
				
				
			else
			    v_status := 0;
             	v_message := 'Try after 1 hour.';
			end if;		
			 
			 else  
			 
			 		   select count(1) into v_attempts 
					   from labrr.labrr_web_user_audit 
					   where user_guid = v_user_guid
					   and option_type=10;
			 
			 	v_status := 0;
            	v_message := 'User Already Verified.'; 
				
            end if;
        else 
        
			v_status := 0;
            v_message := 'Unknown request.'; 
            
        end if;         
		
		   p_result := 1  ;
	
	p_ures_json:= '{
						 "data": {
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": "'|| coalesce(v_status,0) ||'",
						"message":"'|| coalesce(v_message,'') ||'", 
						"attempts": "'|| coalesce(v_attempts,0) ||'",
						"subject":"'|| coalesce(v_subject,'') ||'", 
						"error": {
						"code": "'|| coalesce(v_status,0) ||'",
						"message": "'|| coalesce(v_message,'') ||'"
						},
						"user": {
								 "first_name": "'|| coalesce(v_first_name,'') ||'",
								 "last_name": "'|| coalesce(v_last_name,'') ||'",
								 "name": "'||coalesce(v_user_full_name,'') ||'"								 
								}
						 }
					}' ;

		
		
end;
$$;


--
