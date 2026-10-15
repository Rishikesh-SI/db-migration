-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_verified_otp(jsonb)
-- Type: FUNCTION

-- Name: labisl_v1_verified_otp(jsonb); Type: FUNCTION; Schema: labisl_v1; Owner: -
--

CREATE FUNCTION labisl_v1.labisl_v1_verified_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_user_email_count numeric;
	v_email_verified numeric;

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
		  
		  
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'verify_otp','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labisl_v1','logs');

	if 	v_opt = 1 then	
	
if v_type=3 then 
v_mobile_no :=v_email_id;
end if;
	
	select max(created_date) into v_created_date from labisl_v1.labisl_v1_otp_details
	where mobile_no =v_mobile_no
	and type = v_type;
   
   	raise notice'v_created_date:%',v_created_date;
   
				if exists(select 1 from labisl_v1.labisl_v1_otp_details
						 where mobile_no =v_mobile_no and otp=v_otp and 
						       expiry_date > current_timestamp at time zone 'utc'
						       and created_date = v_created_date and coalesce(failed_attempt,0) < 5
						) then
	--raise notice'v_created_date:%',v_created_date;

						 update labisl_v1.labisl_v1_otp_details
						 set is_verified= 1
						 where mobile_no =v_mobile_no
						 and otp=v_otp and created_date = v_created_date;

						p_data	:= '{"status": "1",
									"message": "Success"}';

				else	
						if exists(select 1 from labisl_v1.labisl_v1_otp_details 
								  where mobile_no =v_mobile_no 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 5) then
						
							 update labisl_v1.labisl_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = v_mobile_no
							 and created_date = v_created_date;
						
							
							p_data	:= '{"status": "0",
									"message": "Failed"}';
										
										
						else

									
							p_data	:= '{"status": "0",
										"message": "attempt exceeded."}';		
						end if;			
									
				end if;	
				
		elseif v_opt = 2 and v_user_guid is not null then
			select max(created_date) into v_created_date from labisl_v1.labisl_v1_otp_details
			where mobile_no = v_email_id
			and type = v_type;
   
   			if exists	(select 1 from labisl_v1.labisl_v1_otp_details
								 where 	mobile_no = v_email_id 
								 		and otp = v_otp 
								 		and expiry_date > current_timestamp at time zone 'utc'
						       			and created_date = v_created_date 
								) then
						
					 update labisl_v1.labisl_v1_otp_details
					 set is_verified= 1
					 where mobile_no = v_email_id 
					 and otp=v_otp and created_date = v_created_date;

					--Check for other users having same email id
					select 	count(1)  from labisl_v1.labisl_v1_web_user
					into 	v_user_email_count
					where 	email_id = v_email_id 
					and 	email_verified = 1;

					--If there are other verified user with same email
					if v_user_email_count > 0 then
						--raise notice 'Cannot verify email.Email already exists. ';
						p_data	:= '{"status" : "0",
									"message" : "Cannot verify email Id .Email Id already exists."}';
					else
						--- Verify email for current user and set other users with same email = NULL
						select email_verified 
						into v_email_verified 
						from labisl_v1.labisl_v1_web_user
						where user_guid = v_user_guid and is_active = 1 and  is_deleted = 0;
						
						if coalesce(v_email_verified,0) = 0 then

							update 	labisl_v1.labisl_v1_web_user
							set		email_id = NULL,
									upper_email_id = NULL,
									email_verified = 0
							where 	email_id = v_email_id;

							update 	labisl_v1.labisl_v1_web_user
							set		email_id = v_email_id,
									upper_email_id = v_email_id,
									email_verified = 1
							where 	user_guid = v_user_guid 
									and is_active = 1 and  is_deleted = 0;

							--raise notice 'Email verified sucessfully.';
							p_data	:= '{"status" : "1",
									"message" : "Email Id verified sucessfully."}';
		
						else 
							--raise notice 'Email already verified.';
							p_data	:= '{"status" : "0",
									"message" : "Email Id already verified."}';
						end if;
					end if;
					else
						if exists(select 1 from labisl_v1.labisl_v1_otp_details 
								  where mobile_no =v_email_id
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 5) then
						
							 update labisl_v1.labisl_v1_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1,
							     updated_date = current_timestamp at time zone 'utc'
							 where mobile_no = v_email_id
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
/*						 
						 if exists(select 1 from labisl_v1.labisl_v1_web_user where email_id=v_email_id and (is_verified=0 or is_verified is null))then
						 				--incase 
						 				 update labisl_v1.labisl_v1_web_user
										 set email_id=null
										 where email_id=v_email_id;
						 
								         update labisl_v1.labisl_v1_web_user
										 set email_id=v_email_id,is_verified=1
										 where user_guid=v_user_guid;
										 
						ELSE
						
										 update labisl_v1.labisl_v1_web_user
										 set email_id=v_email_id,is_verified=1
										 where user_guid=v_user_guid;
						end if;				 
*/
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
