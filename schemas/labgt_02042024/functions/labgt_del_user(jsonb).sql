-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_del_user(jsonb)
-- Type: FUNCTION

-- Name: labgt_del_user(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_del_user(p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_email_id character varying;
	v_user_id numeric;
	v_user_guid character varying;
	p_opttype numeric:=13;
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
	v_created_date timestamp;
	v_recovery_interval character varying;
    v_verification_key character varying;
begin
/*
{
  "data": {
    "user_guid": "",
    "is_app": "1",
    "captcha": null,
    "ipaddress": null,
    "platform_version": 1,
    "platform_type": 1,
    "device_name": "web"
  }
}
*/

    select p_user_json ->'data'->>'user_guid',
           p_user_json ->'data'->>'is_app',
           p_user_json ->'data'->>'ipaddress',
           p_user_json ->'data'->>'platform_version',
           p_user_json ->'data'->>'platform_type', 
		   p_user_json ->'data'->>'delete_key',
           p_user_json ->'data'->>'delete_interval',
		   p_user_json ->'data'->>'device_name',
		   p_user_json ->'data'->>'captcha'
   into
  		  v_user_guid,
		  v_is_app,
		  v_ipaddress,
		  v_platform_version,
		  v_platform_type,
          v_verification_key,
		  v_recovery_interval, --interval where user can't delete its account after recovering. 
		  v_device_name,
		  v_captcha;

 v_current_timestamp := current_timestamp at time zone 'utc';

       if exists(select 1 from labgt.labgt_web_user where verification_key = v_verification_key
			 and is_deleted=0
			 and is_active=1) then 
		
			update labgt.labgt_web_user
			set is_deleted = 1,
			is_active=0,
			updated_date=v_current_timestamp
			where verification_key = v_verification_key;
--			and is_deleted=0;
			
			v_status := 1;
            v_message := 'Account Deleted.'; 
            v_subject := 'Account Deleted.';
			
		   select user_guid,user_id,first_name,last_name,email_id,user_full_name
		   into v_user_guid, v_user_id,v_first_name,v_last_name,v_email_id,v_user_full_name
		   from labgt.labgt_web_user 
		   where verification_key = v_verification_key;
	
        	insert into labgt.labgt_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app,platform_type,device_name,platform_version)
            select nextval('labgt.seq_labgt_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0),v_platform_type,v_device_name,v_platform_version ;

        else 
        
			v_status := 0;
            v_message := 'Unknown request OR Account already Deleted'; 
            v_subject := 'Unknown request OR Account already Deleted';
            
        end if;         
		
		   p_result := 1  ;
	
	p_ures_json:= '{
						 "data": {
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": "'|| coalesce(v_status,0) ||'",
						"message":"'|| coalesce(v_message,'') ||'",
						"code": "'|| coalesce(v_status,0) ||'",
                        "subject":"'|| coalesce(v_subject,'') ||'",
                        "bcc":"'|| 'nik.velani@twocircles.com,Tim.Barber@twocircles.com,Seb.Gemes@twocircles.com' ||'",
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
