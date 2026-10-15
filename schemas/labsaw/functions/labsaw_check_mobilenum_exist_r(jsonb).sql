-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsaw
-- Object: labsaw_check_mobilenum_exist_r(jsonb)
-- Type: FUNCTION

-- Name: labsaw_check_mobilenum_exist_r(jsonb); Type: FUNCTION; Schema: labsaw; Owner: -
--

CREATE FUNCTION labsaw.labsaw_check_mobilenum_exist_r(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
		/* input of function:-
	
	select * from labsaw.labsaw_check_mobilenum_exist( 
	'{
  "mobile_no": "8108789945",
  "email_id": "abc@gmail.com",
}') */
	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_status numeric;
	v_type numeric;
	v_msg text;
	v_social_user_name character varying(1000);

begin
	select p_inputjson->>'mobile_no',
		    p_inputjson->>'email_id',
			p_inputjson->>'type' ,
			p_inputjson->>'social_user_name'
	into v_mobile_no,
		 v_email_id,
		 v_type,
		 v_social_user_name;
		 
		 -- raise notice '% ,% ',v_mobile_no,v_email_id;
		 
		 
	if v_mobile_no is not null and 	v_email_id is not null and v_social_user_name is not null then
	
			v_status := -1 ;
	        v_msg := 'Invalid Request';
		 
	elseif 	v_mobile_no is null and v_email_id is null and v_social_user_name is null then 
	
			v_status := -1 ;
	       v_msg := 'Invalid Request';
		 
	elseif 	v_email_id is not null then
	
		if v_type=3 then
		
			if exists(select 1 from labsaw.labsaw_web_user
					  where email_id = v_email_id  and is_verified=1 and is_active = 1 and is_deleted = 0) then
					v_status := 0 ;
					 v_msg := 'email_id already exist';
			else
					v_status := 1 ;
					 v_msg := 'email_id do not exist';
			
			end if;
		else 
		
			if exists(select 1 from labsaw.labsaw_web_user
					  where email_id = v_email_id  and is_active = 1 and is_deleted = 0) then
					v_status := 0 ;
					 v_msg := 'email_id already exist';
			else
					v_status := 1 ;
					 v_msg := 'email_id do not exist';
			
			end if;

		end if;	
	
	elseif v_mobile_no is not null then
	
			if  exists(select 1 from labsaw.labsaw_web_user
						  where mobile_no = v_mobile_no and mobile_verified = 1 and is_active = 1 and is_deleted = 0) then
						  
				v_status := 0 ;
				 v_msg := 'mobile number already exist';
			else	 
				 v_status := 1 ;
				 v_msg := 'mobile number do not exist';

			end if;	
			
	elseif v_social_user_name is not null then
	
			if  exists(select 1 from labsaw.labsaw_web_user
						  where social_user_name = v_social_user_name and is_active = 1 and is_deleted = 0) then
						  
				v_status := 0 ;
				 v_msg := 'Username already exist';
			else	 
				 v_status := 1 ;
				 v_msg := 'Username do not exist';

			end if;			
			
	
	end if;		
	
	p_data := '{
				"status": "'|| coalesce(v_status::varchar,'')||'",
				 "message": "'|| coalesce(v_msg,'')||'"
  			}';

    
	

end;

$$;


--
