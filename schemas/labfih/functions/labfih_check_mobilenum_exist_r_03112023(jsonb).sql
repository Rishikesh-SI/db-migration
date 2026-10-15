-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_check_mobilenum_exist_r_03112023(jsonb)
-- Type: FUNCTION

-- Name: labfih_check_mobilenum_exist_r_03112023(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_check_mobilenum_exist_r_03112023(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
		/* input of function:-
	
	select * from labfih.labfih_check_mobilenum_exist( 
	'{
  "mobile_no": "8108789945",
  "email_id": "abc@gmail.com",
}') */
	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_status numeric;
	v_type numeric;
	v_msg text;

begin

insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'Input-check_mobilenum_exist_r','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labfih','logs');

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
		
			if exists(select 1 from labfih.labfih_web_user
					  where email_id = v_email_id  and is_verified=1 and is_active = 1 and is_deleted = 0) then
					v_status := 0 ;
					 v_msg := 'email_id already exist';
			else
					v_status := 1 ;
					 v_msg := 'email_id do not exist';
			
			end if;
		else 
		
			if exists(select 1 from labfih.labfih_web_user
					  where email_id = v_email_id and client_id=2) then --and is_active = 1 and is_deleted = 0
					v_status := 0 ;
					 v_msg := 'Log in using Facebook social login; custom email was not used to create your account.';
                     
            elsif exists(select 1 from labfih.labfih_web_user
					  where email_id = v_email_id and client_id=4) then --and is_active = 1 and is_deleted = 0
					v_status := 0 ;
					 v_msg := 'Log in using Google social login; custom email was not used to create your account.';
            
           elsif exists(select 1 from labfih.labfih_web_user
					  where email_id = v_email_id and client_id=5) then --and is_active = 1 and is_deleted = 0
					v_status := 0 ;
					 v_msg := 'Log in using your email; social login was not used to create your account.';
            
            elsif exists(select 1 from labfih.labfih_web_user
					  where email_id = v_email_id) then --and is_active = 1 and is_deleted = 0
					v_status := 0 ;
					 v_msg := 'email_id already exist';
			else
					v_status := 1 ;
					 v_msg := 'email_id do not exist';
			
			end if;

		end if;	
	
	elseif v_mobile_no is not null then
	
			if  exists(select 1 from labfih.labfih_web_user
						  where mobile_no = v_mobile_no and mobile_verified = 1 and is_active = 1 and is_deleted = 0) then
						  
				v_status := 0 ;
				 v_msg := 'mobile number already exist';
			else	 
				 v_status := 1 ;
				 v_msg := 'mobile number do not exist';

			end if;	
	
	end if;		
	
	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;
$$;


--
