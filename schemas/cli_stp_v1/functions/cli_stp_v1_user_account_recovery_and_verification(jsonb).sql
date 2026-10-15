-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cli_stp_v1
-- Object: cli_stp_v1_user_account_recovery_and_verification(jsonb)
-- Type: FUNCTION

-- Name: cli_stp_v1_user_account_recovery_and_verification(jsonb); Type: FUNCTION; Schema: cli_stp_v1; Owner: -
--

CREATE FUNCTION cli_stp_v1.cli_stp_v1_user_account_recovery_and_verification(p_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_email_id character varying;
	v_verification_key character varying;
	v_user_id numeric;
	v_user_guid character varying;
	p_opttype numeric:=11;
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
begin
/*
{
   "author_guid":"da51ef77-d1f8-4526-8942-8e3512b3cc6c"
}
*/

    select p_json ->'data'->>'user_guid',
           p_json ->'data'->>'is_app',
           p_json ->'data'->>'ipaddress',
           p_json ->'data'->>'platform_version',
           p_json ->'data'->>'platform_type', 
		   p_json ->'data'->>'reset_key',
		   p_json ->'data'->>'device_name',
		   p_json ->'data'->>'captcha'
   into
  		  v_user_guid,
		  v_is_app,
		  v_ipaddress,
		  v_platform_version,
		  v_platform_type,
		  v_verification_key,
		  v_device_name,
		  v_captcha;

 v_current_timestamp := current_timestamp at time zone 'utc';

       if exists(select 1 from cli_stp_v1.cli_stp_v1_web_user where --verification_key = v_verification_key
			 user_guid = v_user_guid
				and is_deleted=1) then 
			
			update cli_stp_v1.cli_stp_v1_web_user
			set verification_key = v_verification_key
			where user_guid = v_user_guid
			and is_deleted=1;
			
			v_status := 1;
            v_message := 'An account recovery email has been sent to your registered email to complete recovery process.'; 
            v_subject := 'Recover Your Account.'; 
			
		   select user_guid,user_id,first_name,last_name,email_id,user_full_name
		   into v_user_guid, v_user_id,v_first_name,v_last_name,v_email_id,v_user_full_name
		   from cli_stp_v1.cli_stp_v1_web_user 
		   where user_guid = v_user_guid;
	
        	insert into cli_stp_v1.cli_stp_v1_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app,platform_type,device_name,platform_version)
            select nextval('cli_stp_v1.seq_cli_stp_v1_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0),v_platform_type,v_device_name,v_platform_version ;

        else 
        
			v_status := 0;
            v_message := 'Unknown request.'; 
            
        end if;         
		
		   p_result := 1  ;
	
	p_ures_json:= '{
						 "data": {
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": "'|| coalesce(v_status,0) ||'",
						"subject": "'|| coalesce(v_subject,'') ||'"	,					
						"message":"'|| coalesce(v_message,'') ||'",
						"code": "'|| coalesce(v_status,0) ||'",
						"error": {
						"code": "'|| coalesce(v_status,0) ||'",
						"message":"'|| coalesce(v_message,'') ||'"
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
