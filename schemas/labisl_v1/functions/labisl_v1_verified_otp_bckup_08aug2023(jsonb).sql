-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_verified_otp_bckup_08aug2023(jsonb)
-- Type: FUNCTION

-- Name: labisl_v1_verified_otp_bckup_08aug2023(jsonb); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_verified_otp_bckup_08aug2023(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare

	/*'{
  "data": {
    "mobile_no": "string",
    "otp": "string",
    "email_id": "string",
    "opt": "string",
    "type": 0,
    "user_guid": "string",
    "is_app": "string"
 		  }
	}'*/

	v_mobile_no character varying(1000);
	v_email_id character varying(1000);
	v_otp numeric;
	v_opt numeric;
	v_type numeric;
	v_user_guid character varying(1000);
	v_is_app numeric;
	v_count numeric ;
	v_created_date timestamp;

begin
	select p_inputjson->'data'->>'mobile_no',
	       p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id',
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'		   
	into  v_mobile_no,
		  v_otp,
		  v_email_id,
		  v_opt,
		  v_type,
		  v_user_guid,
		  v_is_app;
		  
	if 	v_opt in (1,2) then	
	

	
	select max(created_date) into v_created_date from labisl_v1.labisl_v1_otp_details
	where mobile_no =coalesce( v_mobile_no,v_email_id)
	and type = v_type;
   
   	raise notice'v_created_date:%',v_created_date;
   
				if exists(select 1 from labisl_v1.labisl_v1_otp_details
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp and 
						       expiry_date > current_timestamp at time zone 'utc'
						       and created_date = v_created_date and coalesce(failed_attempt,0) < 5
						) then
	--raise notice'v_created_date:%',v_created_date;

						 update labisl_v1.labisl_v1_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;

						p_data	:= '{"status": "1",
									"message": "Success"}';

				else	
						if exists(select 1 from labisl_v1.labisl_v1_otp_details 
								  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 5) then
						
							 update labisl_v1.labisl_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
							
							p_data	:= '{"status": "0",
									"message": "Failed"}';
										
										
						else

									
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';		
						end if;			
									
				end if;	
		elseif 	v_opt = 3  then
		   
		    select max(created_date) into v_created_date from labisl_v1.labisl_v1_otp_details
			where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid and type = v_type ;
			
			if exists(select 1 from labisl_v1.labisl_v1_otp_details
					  where mobile_no =coalesce( v_mobile_no,v_email_id) 
					  and otp=v_otp
					  and expiry_date > current_timestamp at time zone 'utc'
					  and created_date = v_created_date and user_guid = v_user_guid
					  and type = v_type and coalesce(failed_attempt,0) < 5
						) then

						 update labisl_v1.labisl_v1_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type;

						p_data	:= '{"status": "1",
									"message": "Success"}';

					else
						
						if exists(select 1 from labisl_v1.labisl_v1_otp_details 
								  where mobile_no =coalesce( v_mobile_no,v_email_id) 
								  and created_date = v_created_date and coalesce(failed_attempt,0) < 5) then
						
							 update labisl_v1.labisl_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;						
								
							p_data	:= '{"status": "0",
										"message": "Failed"}';			
						else
							
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';
							
						end if;
								
					end if;	

		end if;	
	
end;

$$;


--
