-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmsg
-- Object: labmsg_user_account_recovery(jsonb)
-- Type: FUNCTION

-- Name: labmsg_user_account_recovery(jsonb); Type: FUNCTION; Schema: labmsg; Owner: -
--

CREATE FUNCTION labmsg.labmsg_user_account_recovery(p_user_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_email_id character varying;
	v_verification_key character varying;
	v_user_id numeric;
	v_user_guid character varying;
	p_opttype numeric:=12;
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
	v_is_verified numeric;
	v_favourite_club character varying;
	v_edition character varying;
	v_profile_picture_url character varying;
	v_is_custom_image character varying;
	v_mobile_no character varying;
begin
/*
{
  "data": {
    "is_app": "1",
    "captcha": null,
    "reset_key": "674D3973675A3435464B74462B6B696658544578386D476E4C7747445639656F536A65774C4F4C77503872534F6D4679694C504362762F31784C6934666D3778",
    "ipaddress": null,
    "platform_version": 1,
    "platform_type": 1,
    "device_name": "web"
  }
*/

    select p_user_json ->'data'->>'user_guid',
           p_user_json ->'data'->>'is_app',
           p_user_json ->'data'->>'ipaddress',
           p_user_json ->'data'->>'platform_version',
           p_user_json ->'data'->>'platform_type', 
		   p_user_json ->'data'->>'verification_key',
		   p_user_json ->'data'->>'device_name',
		   p_user_json ->'data'->>'captcha'
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

       if exists(select 1 from labmsg.labmsg_web_user 
				 where verification_key = v_verification_key) then 

     	 select user_guid, is_verified, favourite_club, edition,  profile_picture_url , is_custom_image,
         email_id,user_full_name,mobile_no,first_name,last_name,user_id
         into v_user_guid, v_is_verified, v_favourite_club, v_edition, v_profile_picture_url, v_is_custom_image,
         v_email_id,v_user_full_name,v_mobile_no,v_first_name,v_last_name,v_user_id
		 from labmsg.labmsg_web_user 
		 where verification_key = v_verification_key;

			update labmsg.labmsg_web_user
			set verification_key = null,
			is_deleted=0,
			is_active=1
			where verification_key = v_verification_key;
--			and is_deleted=0;
			
			v_status := 1;
            v_message := 'Account Recovered Succesfully.'; 
			v_subject := 'Account Recovered Succesfully.'; 
            
			
            
            -- raise notice '%',v_bcc;
            
        	insert into labmsg.labmsg_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app,platform_type,device_name,platform_version)
            select nextval('labmsg.seq_labmsg_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0),v_platform_type,v_device_name,v_platform_version ;

        else 
        
			v_status := 0;
            v_message := 'Unkown Request.'; 
            
        end if;         
		
		   p_result := 1  ;
           
           
	
	p_ures_json = '{
					  "data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"waf_user_guid": "'||coalesce(v_user_guid,'')||'",
						"email_id": "'|| coalesce(v_email_id,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"subject": "'|| coalesce(v_subject,'')||'",
						"platform_version": "'|| coalesce(v_platform_version,'')||'",
						"device_name": "'|| coalesce(v_device_name,'')||'",
						"platform_type": "'|| coalesce(v_platform_type,0)||'",
						"option_type": "'|| coalesce(p_opttype,0)||'",
						"user": {
						  "mobile_no": "'|| coalesce(v_mobile_no,'') ||'" ,
						  "name": "'||coalesce(v_user_full_name,'') ||'",
						  "first_name": "'||coalesce(v_first_name,'') ||'",
						  "last_name": "'||coalesce(v_last_name,'') ||'",
						  "favourite_club": "'||coalesce(v_favourite_club,'') ||'",
						  "edition": "'|| coalesce(v_edition,'') ||'",
                          "social_user_image": "'|| coalesce(v_profile_picture_url,'') ||'" 
						},
						"is_first_login": 1,
						"is_app": '|| coalesce(v_is_app,0) ||' ,
						"is_custom_image": "'|| coalesce(v_is_custom_image,'0') ||'" 
					  }
					}' ;  

end;
$$;


--
