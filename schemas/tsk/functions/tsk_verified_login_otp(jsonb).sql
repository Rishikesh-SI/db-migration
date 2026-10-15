-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_verified_login_otp(jsonb)
-- Type: FUNCTION

-- Name: tsk_verified_login_otp(jsonb); Type: FUNCTION; Schema: tsk; Owner: -
--

CREATE FUNCTION tsk.tsk_verified_login_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_client_id numeric;
	v_status numeric;
	v_message text;
	v_mobile_no_1 text;
	v_email_id_1 text;
	v_dob text;
	v_address text;
	v_gender text;
	v_first_name character varying;
	v_last_name character varying;
	-- v_user_guid text;

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'		   
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_opt,
		   v_type,
		   v_user_guid,
		   v_is_app;
		   
	if 	v_opt in (1,2) then	
	
	
	select max(created_date) into v_created_date from tsk.tsk_otp_details
	where mobile_no =coalesce( v_mobile_no,v_email_id)
	and type = v_type;
	
				if exists(select 1 from tsk.tsk_otp_details
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp and 
							   expiry_date > current_timestamp at time zone 'utc'
						  		and created_date = v_created_date and coalesce(failed_attempt,0) < 3
						) then

						 update tsk.tsk_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;
						 
						 
						 select client_id ,1,'Success',mobile_no,email_id,dob,address,gender,user_guid,first_name,last_name
						 into v_client_id,v_status,v_message,v_mobile_no_1,v_email_id_1,v_dob,
						 v_address,v_gender,v_user_guid,v_first_name,v_last_name
						 from tsk.tsk_web_user
						 where (mobile_no = v_mobile_no or email_id = v_email_id) and client_id=11;

						p_data = '{
				"data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"email_id": "'|| coalesce(v_email_id_1,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"client_id": '||coalesce(v_client_id,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"error": {
						"code": '||coalesce(v_status,0) ||',
						"message":  "'||coalesce(v_message,'')||'"
						},
				"user": {
						 "mobile_no": "'|| coalesce(v_mobile_no_1,'') ||'" ,
						 "first_name": "'||coalesce(v_first_name,'') ||'",
						 "last_name": "'||coalesce(v_last_name,'') ||'",
						 "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						 "gender": "'|| coalesce(v_gender,'') ||'",
						 "address": "'|| coalesce(v_address,'') ||'"
						},
						 "is_first_login": 0,
						 "is_app": '|| coalesce(v_is_app,0) ||'
		                }
		                   }' ;
									
									
									

				else	
						if exists(select 1 from tsk.tsk_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then  
						
							 update tsk.tsk_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
							
							p_data	:= '{
								"data": 
								{"status": "0",
									"message": "Failed"}
									}';
										
									
						else

									
							p_data	:= ' {
								"data": {"status": "0",
										"message": "attempt exceeded."}}';		
						end if;			
									
				end if;	
		elseif 	v_opt = 3  then
		
			select max(created_date) into v_created_date from tsk.tsk_otp_details
			where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid
			and type = v_type;
			      
				  if exists(select 1 from tsk.tsk_otp_details
						    where mobile_no =coalesce( v_mobile_no,v_email_id) 
						     and otp=v_otp 
							and expiry_date > current_timestamp at time zone 'utc'
						  	and created_date = v_created_date and user_guid = v_user_guid
							and type = v_type and coalesce(failed_attempt,0) < 3
						) then

						 update tsk.tsk_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type;

						select client_id ,1,'Success',mobile_no,email_id,dob,address,gender,user_guid,first_name,last_name
						 into v_client_id,v_status,v_message,v_mobile_no_1,v_email_id_1,v_dob,
						 v_address,v_gender,v_user_guid,v_first_name,v_last_name
						 from tsk.tsk_web_user
						 where mobile_no = v_mobile_no or email_id = v_email_id;

						p_data = '{
				"data": {
						"user_guid": "'||coalesce(v_user_guid,'')||'",
						"email_id": "'|| coalesce(v_email_id_1,'') ||'",
						"status": '||coalesce(v_status,0) ||',
						"client_id": '||coalesce(v_client_id,0) ||',
						"message": "'|| coalesce(v_message,'')||'",
						"error": {
						"code": '||coalesce(v_status,0) ||',
						"message":  "'||coalesce(v_message,'')||'"
						},
				"user": {
						 "mobile_no": "'|| coalesce(v_mobile_no_1,'') ||'" ,
						 "first_name": "'||coalesce(v_first_name,'') ||'",
						 "last_name": "'||coalesce(v_last_name,'') ||'",
						 "dob": "'|| coalesce(v_dob::varchar,'') ||'",
						 "address": "'|| coalesce(v_address,'') ||'"
						},
						 "is_first_login": 0,
						 "is_app": '|| coalesce(v_is_app,0) ||'
		                }
		                   }' ;

					else
						
						if exists(select 1 from tsk.tsk_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 			  and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then 
						
							 update tsk.tsk_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;						
								
							p_data	:= ' {
								"data": 
								{"status": "0",
										"message": "Failed"}
										}';			
					else
							
							p_data	:= ' {
								"data": {"status": "0",
										"message": "attempt exceeded."}
										}';   
							
						end if;
								
					end if;	

		end if;	
	
end;
$$;


--
