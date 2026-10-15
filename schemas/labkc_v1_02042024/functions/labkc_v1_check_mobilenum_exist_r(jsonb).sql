-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_02042024
-- Object: labkc_v1_check_mobilenum_exist_r(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_check_mobilenum_exist_r(jsonb); Type: FUNCTION; Schema: labkc_v1_02042024; Owner: -
--

CREATE FUNCTION labkc_v1_02042024.labkc_v1_check_mobilenum_exist_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
		/* input of function:-
	
	select * from labkc_v1.labkc_v1_check_mobilenum_exist( 
	'{
  "mobile_no": "8108789945",
  "email_id": "abc@gmail.com",
}') */
	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_status numeric;
	v_type numeric;
	v_msg text;
	v_user_id numeric;

begin
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
		
			if exists(select 1 from labkc_v1.labkc_v1_web_user
					  where email_id = v_email_id and is_active = 1 and is_deleted = 0) then
					v_status := 1 ;
					 v_msg := 'Email id already exists';
			else
					v_status := 1 ;
					 v_msg := 'Email id do not exist';
			
			end if;
		else 
		
			if exists(select 1 from labkc_v1.labkc_v1_web_user
					  where email_id = v_email_id  and is_active = 1 and is_deleted = 0) then
					v_status := 1 ;
					 v_msg := 'Email id already exists';
			else
					v_status := 1 ;
					 v_msg := 'Email id do not exist';
			
			end if;

		end if;	
	
	elseif v_mobile_no is not null then
	
			if  exists(select 1 from labkc_v1.labkc_v1_web_user
						  where mobile_no = v_mobile_no  and is_active = 1 and is_deleted = 0) then
				 select user_id into v_user_id
				 from labkc_v1.labkc_v1_web_user
						  where mobile_no = v_mobile_no  and is_active = 1 and is_deleted = 0;
				 v_status := 0 ;
				 v_msg := 'mobile number already exist';
			else	 
				 v_status := 1 ;
				 v_msg := 'mobile number do not exist';

			end if;	
	
	end if;		
	
	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				"user_id": "'|| coalesce(v_user_id::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;
$$;


--
