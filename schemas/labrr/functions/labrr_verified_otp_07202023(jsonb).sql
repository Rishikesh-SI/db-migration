-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_verified_otp_07202023(jsonb)
-- Type: FUNCTION

-- Name: labrr_verified_otp_07202023(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_verified_otp_07202023(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_attemp numeric ;
	v_country_code character varying(30);

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app',
		   p_inputjson->'data'->>'country_code'		   
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_opt,
		   v_type,
		   v_user_guid,
		   v_is_app,
		   v_country_code;
           
                         
   
	if 	v_opt in (1,2)  and v_type=1  then	

	--raise notice 'abubakar';
	select max(created_date) into v_created_date from labrr.labrr_otp_details
	where mobile_no =coalesce( v_mobile_no,v_email_id) 
	and type = v_type;
	
				if exists(select 1 from labrr.labrr_otp_details
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp and 
							   expiry_date > current_timestamp at time zone 'utc'
						  		and created_date = v_created_date and coalesce(failed_attempt,0) < 3
						) then
                                          

						 update labrr.labrr_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;

						p_data	:= '{"status": "1",
									"message": "OTP verified successfully"}';

				else
                		 

						if exists(select 1 from labrr.labrr_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
                   
                       
							 update labrr.labrr_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
							
							 select failed_attempt into v_attemp from labrr.labrr_otp_details 
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 	 and created_date = v_created_date;
							p_data	:= '{"status": "0",
										"message": "Attempt:'||coalesce(v_attemp,0)||'/3",
										"failed_attempt":'||coalesce(v_attemp,0)::text||'
										}';	
										
										
						else

									
							p_data	:= '{"status": "2",
										"message": "Try after 24 hours to generate a new OTP"}';		
						end if;			
									
				end if;	
                
          
		elseif 	v_opt in (1,2)  and v_type<>1  then
		 
		
			      
			select max(created_date) into v_created_date from labrr.labrr_otp_details
			where  user_guid = v_user_guid and type = v_type;
			      	  
				  
				  if exists(select 1 from labrr.labrr_otp_details
						    where -- mobile_no =coalesce( v_mobile_no,v_email_id) and 
							otp=v_otp 
							and expiry_date > current_timestamp at time zone 'utc'
						  	and created_date = v_created_date and user_guid = v_user_guid
							and type = v_type and coalesce(failed_attempt,0) < 3
						) then

						 update labrr.labrr_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type;
						 
						 if v_user_guid is not null then
						 
						 
								 if v_opt=1 then
							begin		 
										 update labrr.labrr_web_user
										 set mobile_no=v_mobile_no,mobile_verified=1,country_code=v_country_code::numeric
										 where user_guid=v_user_guid;
										 
										 p_data	:= '{"status": "1",
									"message": "OTP verified successfully"}';
										 
											EXCEPTION
										   WHEN SQLSTATE '23000' THEN
										   p_data	:= '{"status": "0",
										  "message": "Mobile Number is already in use"}';
						
						end;				 
								 elseif v_opt=2 then
						
						begin
						
								     update labrr.labrr_web_user
										 set email_id=v_email_id,email_verified=1
										 where user_guid=v_user_guid;
										 p_data	:= '{"status": "1",
									"message": "OTP verified successfully"}';
										 
											EXCEPTION
										   WHEN SQLSTATE '23000' THEN
										   p_data	:= '{"status": "0",
										  "message": "Email is already in use"}';
										 
						end;				 
								 
								 end if;
						 
						 end if;
                        
						

					else
						
						if exists(select 1 from labrr.labrr_otp_details 
									  where -- mobile_no =coalesce( v_mobile_no,v_email_id) and 
								  created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labrr.labrr_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where -- mobile_no =coalesce( v_mobile_no,v_email_id) and 
							 created_date = v_created_date
							 and user_guid = v_user_guid
						     and type = v_type;
							 
							 select failed_attempt into v_attemp from labrr.labrr_otp_details 
							 where -- mobile_no =coalesce( v_mobile_no,v_email_id) and 
							 created_date = v_created_date
							 and user_guid = v_user_guid
						     and type = v_type;
								
							p_data	:= '{"status": "0",
										"message": "Attempt:'||coalesce(v_attemp,0)||'/3",
										"failed_attempt":'||coalesce(v_attemp,0)::text||'}';			
						else
						
							
							
							p_data	:= '{"status": "2",
										"message": "Try after 24 hours to generate a new OTP"}';
							
						end if;
								
					end if;	

		end if;	

end;
$$;


--
