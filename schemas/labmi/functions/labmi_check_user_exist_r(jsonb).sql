-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_check_user_exist_r(jsonb)
-- Type: FUNCTION

-- Name: labmi_check_user_exist_r(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_check_user_exist_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_status numeric;
	v_type numeric;
	v_msg text;

begin

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'check_mobile','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labmi','logs');

	select p_inputjson->>'mobile_no',
		    p_inputjson->>'email_id',
			p_inputjson->>'type' 
	into v_mobile_no,
		 v_email_id,
		 v_type;
		 
		 -- raise notice '% ,% ',v_mobile_no,v_email_id;
		 
		 
	if v_mobile_no is not null and 	v_email_id is not null then
	
			v_status := -1 ;
	        v_msg := 'Invalid Request';
		 
	elseif 	v_mobile_no is null and v_email_id is null then 
	
			v_status := -1 ;
	       v_msg := 'Invalid Request';
		 
	elseif 	v_email_id is not null then
	
		if v_type=3 then
		
			if exists(select 1 from labmi.labmi_web_user
					  where email_id = v_email_id and client_id=5 and is_verified=1 and is_active = 1 and is_deleted = 0) then
					v_status := 0 ;
					 v_msg := 'If the account exists, OTP has been sent';
			else
					v_status := 1 ;
					 v_msg := 'If the account exists, OTP has been sent';
			
			end if;
		else 
		
			if exists(select 1 from labmi.labmi_web_user
					  where email_id = v_email_id and client_id=5 and is_active = 1 and is_deleted = 0) then
					v_status := 0 ;
					 v_msg := 'If the account exists, OTP has been sent';
			else
					v_status := 1 ;
					 v_msg := 'If the account exists, OTP has been sent';
			
			end if;

		end if;	
	
	elseif v_mobile_no is not null then
	
			if  exists(select 1 from labmi.labmi_web_user
						  where mobile_no = v_mobile_no and mobile_verified = 1 ) then
						  
				v_status := 0 ;
				 v_msg := 'If the account exists, OTP has been sent';
			else	 
				 v_status := 1 ;
				 v_msg := 'If the account exists, OTP has been sent';

			end if;	
	
	end if;		
	
	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;

$$;


--
