-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_verified_otp_13032023(jsonb)
-- Type: FUNCTION

-- Name: labkkr_verified_otp_13032023(jsonb); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_verified_otp_13032023(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_status numeric;

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
	
	select max(created_date) into v_created_date from labkkr.labkkr_otp_details
	where mobile_no =coalesce( v_mobile_no,v_email_id) --and user_guid = v_user_guid
	and type = v_type;
	
				if exists(select 1 from labkkr.labkkr_otp_details
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp and 
							   expiry_date > current_timestamp at time zone 'utc'
						  		and created_date = v_created_date and coalesce(failed_attempt,0) < 3
						) then

						 update labkkr.labkkr_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and otp=v_otp and created_date = v_created_date;

						p_data	:= '{"status": "1",
									"message": "Success"}';

				else	
						if exists(select 1 from labkkr.labkkr_otp_details 
									  where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 and created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labkkr.labkkr_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
							 and created_date = v_created_date;
						
						 select failed_attempt into v_attemp from labkkr.labkkr_otp_details
							 where mobile_no =coalesce( v_mobile_no,v_email_id) 
						 	 and created_date = v_created_date;
								
							
							p_data	:= '{"status": "0",
										"message": "Attempts Allowed: '||coalesce(v_attemp,0)||'/3",
										"failed_attempt":'||coalesce(v_attemp,0)::text||'}';
										
										
						else
		
							p_data	:= '{"status": "2",
										"message": "Try after 24hrs to generate OTP"}';	
										
										
						end if;			
							
				end if;	
				
				
										
		elseif 	v_type = 3  then
		
			select max(created_date) into v_created_date from labkkr.labkkr_otp_details
			where --mobile_no =coalesce( v_mobile_no,v_email_id) and
			user_guid = v_user_guid
			and type = v_type;
			      
				  if exists(select 1 from labkkr.labkkr_otp_details
						    where --mobile_no =coalesce( v_mobile_no,v_email_id) and
						     otp=v_otp 
							and expiry_date > current_timestamp at time zone 'utc'
						  	and created_date = v_created_date and user_guid = v_user_guid
							and type = v_type and coalesce(failed_attempt,0) < 3
						) then

						 update labkkr.labkkr_otp_details
						 set is_verified= 1
						 where mobile_no =coalesce( v_mobile_no,v_email_id) and otp=v_otp 
						 and created_date = v_created_date 
						 and user_guid = v_user_guid
						 and type = v_type;

						p_data	:= '{"status": "1","message": "Success"}';

					else
						
						if exists(select 1 from labkkr.labkkr_otp_details 
									  where --mobile_no =coalesce( v_mobile_no,v_email_id) and
						 			  created_date = v_created_date and coalesce(failed_attempt,0) < 3) then
						
							 update labkkr.labkkr_otp_details
							 set failed_attempt = coalesce(failed_attempt,0)+1
							 where --mobile_no =coalesce( v_mobile_no,v_email_id) and
							 created_date = v_created_date
							  and user_guid = v_user_guid
						     and type = v_type;
							 
							  select failed_attempt into v_attemp from labkkr.labkkr_otp_details 
							 where --mobile_no =coalesce( v_mobile_no,v_email_id) and
						 	  created_date = v_created_date
							  and user_guid = v_user_guid
						     and type = v_type;
								
							p_data	:= '{"status": "0",
										"message": "Attempts Allowed: '||coalesce(v_attemp,0)||'/3",
										"failed_attempt":'||coalesce(v_attemp,0)::text||'}';			
						else
							
							p_data	:= '{"status": "2",
										"message": "OTP attempts exceeded. Please try again in 24hrs."}';
							
						end if;
								
					end if;	

		end if;	
	
end;
$$;


--
