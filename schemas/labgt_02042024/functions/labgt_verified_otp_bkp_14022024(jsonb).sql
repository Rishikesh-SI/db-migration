-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_verified_otp_bkp_14022024(jsonb)
-- Type: FUNCTION

-- Name: labgt_verified_otp_bkp_14022024(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_verified_otp_bkp_14022024(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
v_ref_user_guid character varying;
begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'		   
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_type,
		   v_opt,
		   v_user_guid,
		   v_is_app;
		   
	if 	v_type in (1,2) then	
	

	
	select max(created_date) into v_created_date from labgt.labgt_otp_details
	where mobile_no =coalesce( v_mobile_no,v_email_id)
	and type = v_type;
	
				if exists(select 1 from labgt.labgt_otp_details
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp and 
							   expiry_date > current_timestamp at time zone 'utc'
						  		and created_date = v_created_date and coalesce(failed_attempt,0) < 5
						) then

						 update labgt.labgt_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;

						p_data	:= '{"status": "1",
									"message": "Success"}';

				else	
						if exists(select 1 from labgt.labgt_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 5) then
						
							 update labgt.labgt_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
							
							p_data	:= '{"status": "0",
									"message": "Failed"}';
										
										
						else

									
							p_data	:= '{"status": "2",
										"message": "attempt exceeded."}';		
						end if;			
									
				end if;	
		elseif 	v_type = 3  then
		
			select max(created_date) into v_created_date from labgt.labgt_otp_details
			where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid
			and type = v_type;
			      
				  if exists(select 1 from labgt.labgt_otp_details
						    where mobile_no =coalesce( v_mobile_no,v_email_id) 
						     and otp=v_otp 
							and expiry_date > current_timestamp at time zone 'utc'
						  	and created_date = v_created_date and user_guid = v_user_guid
							and type = v_type and coalesce(failed_attempt,0) < 5
						) then

						 update labgt.labgt_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type;
						 
						 
						 if v_user_guid is not null then
						 
							if v_opt=2 then
							
										select user_guid into v_ref_user_guid
										from labgt.labgt_web_user_old_data
										where email_id = v_email_id
										order by updated_date desc limit 1;
								 
								         update labgt.labgt_web_user
										 set email_id=v_email_id,email_verified=1,ref_user_guid=v_ref_user_guid
										 where user_guid=v_user_guid;
								
								 
								 end if;
							end if;	 

						p_data	:= '{"status": "1",
									"message": "Success"}';

					else
						
						if exists(select 1 from labgt.labgt_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 			  and created_date = v_created_date and coalesce(failed_attempt,0) < 5) then
						
							 update labgt.labgt_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;						
								
							p_data	:= '{"status": "0",
										"message": "Failed"}';			
						else
							
							p_data	:= '{"status": "2",
										"message": "attempt exceeded."}';
							
						end if;
								
					end if;	

		end if;	
	
end;
$$;


--
