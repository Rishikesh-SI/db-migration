-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_generate_otp_07202023(jsonb)
-- Type: FUNCTION

-- Name: labrr_generate_otp_07202023(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_generate_otp_07202023(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_user_full_name character varying(1000);
	v_otp_1 numeric;
	v_failed_attempt numeric;
	
	
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
			 -- v_otp:= 12318006;	  
	if not exists(select 1 from labrr.labrr_web_user where (mobile_no = v_mobile_no 
				  and mobile_verified = 1) or (email_id = v_email_id and email_verified = 1) ) then
				  --or (email_id = v_email_id and is_verified =1  )
			select failed_attempt,otp into v_failed_attempt,v_otp_1 from labrr.labrr_otp_details
			where mobile_no = coalesce( v_mobile_no,v_email_id)	 and created_date + '1 day'::interval > current_timestamp at time zone 'utc'
			order by created_date desc
			limit 1;
			
		 
			if 	v_opt in (1,2) then
            
             if (v_failed_attempt < 3) or (v_failed_attempt is null)  then

				if v_type = 1 then
--				if v_failed_attempt is null then

							if not exists(select 1 from labrr.labrr_otp_details
										where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '1800 seconds'::interval > current_timestamp at time zone 'utc') then
								select count(1) into v_count  from labrr.labrr_otp_details
								where  mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type ;	
								
								select max(created_date) into v_created_date from labrr.labrr_otp_details
								where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
								
								
								if (v_count <= 2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
																 or v_created_date is null )then
									insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
										 "otp_duration": "1800"}';

								elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

									delete from labrr.labrr_otp_details
									where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
									insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)

									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
										 "otp_duration": "1800"}';
								else
										p_data	:= '{"status": "2",
													"message": "Too many requests for OTP"
													}';
								end if;		
							else
										 p_data := '{"status": "0",
										"message": "Previous OTP is still valid"}';
										
							end if;			
	                   
				elsif v_type = 3 then
	
								if not exists(select 1 from labrr.labrr_otp_details
										where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '1800 seconds'::interval > current_timestamp at time zone 'utc') then

								select count(1) into v_count  from labrr.labrr_otp_details
								where  mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid ;	
								
								select max(created_date) into v_created_date from labrr.labrr_otp_details
								where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid;
								
								raise notice 'v_count %',v_count;
								raise notice 'v_created_date %',v_created_date;
								if (v_count <= 2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
																 or v_created_date is null )then
									insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
										 "otp_duration": "1800"}';

								elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

									delete from labrr.labrr_otp_details where user_guid = v_user_guid and
									mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
									insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)

									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "OTP sent successfully",
										 "otp_duration": "1800"}';
								else
										p_data	:= '{"status": "2",
													"message": "Too many requests for OTP"
													}';
								end if;		
							else
										 p_data := '{"status": "0",
										"message": "Previous OTP is still valid"}';
							end if;

			end if;	
            
			else
                p_data	:= '{"status": "2",
				"message": "Try after 24 hours to generate a new OTP"
				}';
                end if;
                

							
			elseif v_opt = 3 then
			
			
				select max(created_date) into v_created_date from labrr.labrr_otp_details
				where user_guid = v_user_guid -- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type ;
				
				select coalesce(failed_attempt,0) into v_failed_attempt from labrr.labrr_otp_details
				where user_guid = v_user_guid and created_date = v_created_date-- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type;
			
				select count(1) into v_count  from labrr.labrr_otp_details
				where user_guid = v_user_guid 
				and type = v_type and current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval ;	
				
				
				
				
				
				if v_count is null or v_count = 0 then 
				
					insert into labrr.labrr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app);
					p_data	:= '{"status": "1",
								"message": "OTP sent successfully",
								"otp_duration": "1800"}';
								
				elseif v_count >= 1 and v_failed_attempt < 3 then
				
					update labrr.labrr_otp_details
					set mobile_no = coalesce( v_mobile_no,v_email_id),
						otp = v_otp,
						is_verified = 0,
						created_date = current_timestamp at time zone 'utc',
						expiry_date = current_timestamp at time zone 'utc' + '1800 seconds'::interval			
				   where user_guid = v_user_guid and type = v_type;
				   
				   
						p_data	:= '{"status": "1",
								"message": "OTP sent successfully",
								"otp_duration": "1800"}';
				   
				 elseif  v_failed_attempt >= 3 then 
				 
				 	p_data	:= '{"status": "2",
										"message": "Try after 24 hours to generate a new OTP"}';	
				   
			     end if;  
				   
				
				
			end if;
			
		select first_name into v_user_full_name  from labrr.labrr_web_user
		where user_guid = v_user_guid;
		
	
		p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true);
			
	else
	
			p_data	:= '{"status": "3",
						"message": "Already Verified"}';
		
	end if;
	
	
	
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true);
	
end;
$$;


--
