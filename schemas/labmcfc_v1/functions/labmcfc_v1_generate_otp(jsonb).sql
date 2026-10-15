-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_v1_generate_otp(jsonb); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
           
--            v_otp:=123456;
		  
	if not exists(select 1 from labmcfc_v1.labmcfc_v1_web_user where (mobile_no = v_mobile_no
				  and mobile_verified = 1  )  ) then
                  
--                   raise notice '1';
				  --or (email_id = v_email_id and is_verified =1  )
			select failed_attempt,otp into v_failed_attempt,v_otp_1 from labmcfc_v1.labmcfc_v1_otp_details
			where mobile_no = coalesce( v_mobile_no,v_email_id)	 and created_date + '1 day'::interval > current_timestamp at time zone 'utc'
			order by created_date desc
			limit 1;
			
		  raise notice'v_failed_attempt:%',v_failed_attempt;
			if 	v_opt in (1,2) then
            
             if (v_failed_attempt < 3) or (v_failed_attempt is null)  then

				if v_type = 1 then
--				if v_failed_attempt is null then

							if not exists(select 1 from labmcfc_v1.labmcfc_v1_otp_details
										where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '90 seconds'::interval > current_timestamp at time zone 'utc') then
								select count(1) into v_count  from labmcfc_v1.labmcfc_v1_otp_details
								where  mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type ;	
								
								select max(created_date) into v_created_date from labmcfc_v1.labmcfc_v1_otp_details
								where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
								
								raise notice 'v_count %',v_count;
								raise notice 'v_created_date %',v_created_date;
								if (v_count <= 2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
																 or v_created_date is null )then
									insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '45 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "Success",
										 "otp_duration": "120"}';

								elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

									delete from labmcfc_v1.labmcfc_v1_otp_details
									where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
									insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)

									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '45 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "Success",
										 "otp_duration": "120"}';
								else
										p_data	:= '{"status": "2",
													"message": "attempt exceeded"
													}';
								end if;		
							else
										 p_data := '{"status": "0",
										"message": "OTP not Expired"}';
										
							end if;			
	                   
				elsif v_type = 3 then
                
								if not exists(select 1 from labmcfc_v1.labmcfc_v1_otp_details
										where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '90 seconds'::interval > current_timestamp at time zone 'utc') then
                                raise notice 'asdfgh';
								select count(1) into v_count  from labmcfc_v1.labmcfc_v1_otp_details
								where  mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid ;	
								
								select max(created_date) into v_created_date from labmcfc_v1.labmcfc_v1_otp_details
								where mobile_no =coalesce( v_mobile_no,v_email_id) and user_guid = v_user_guid;
								
								raise notice 'v_count %',v_count;
								raise notice 'v_created_date %',v_created_date;
								if (v_count <= 2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
																 or v_created_date is null )then
									insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '45 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "Success",
										 "otp_duration": "120"}';

								elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

									delete from labmcfc_v1.labmcfc_v1_otp_details where user_guid = v_user_guid and
									mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;
									insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)

									values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
										   current_timestamp at time zone 'utc' + '45 seconds'::interval,0,v_type,v_user_guid,v_is_app);
										 p_data	:= '{"status": "1",
										 "message": "Success",
										 "otp_duration": "120"}';
								else
										p_data	:= '{"status": "2",
													"message": "attempt exceeded"
													}';
								end if;		
							else
										 p_data := '{"status": "0",
										"message": "OTP not Expired"}';
							end if;

			end if;	
            
			else
                p_data	:= '{"status": "2",
				"message": "Try after 24hrs to generate OTP"
				}';
                end if;
                
/*					elseif 	v_failed_attempt >= 3 then
						 
						 p_data	:= '{"status": "3",
										"message": "Try after 24hrs to generate OTP"}';
						
					elseif v_failed_attempt < 3 then
					    
						update labmcfc_v1.labmcfc_v1_otp_details
						set otp = v_otp,
							expiry_date = current_timestamp at time zone 'utc' + '120 seconds'::interval
						where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type and otp = v_otp_1;	
						
						 p_data	:= '{"status": "1",
										 "message": "Success",
										 "otp_duration": "120"}';
					
					end if; */
							
			elseif v_opt = 3 then
			
			
				select max(created_date) into v_created_date from labmcfc_v1.labmcfc_v1_otp_details
				where user_guid = v_user_guid -- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type ;
				
				select coalesce(failed_attempt,0) into v_failed_attempt from labmcfc_v1.labmcfc_v1_otp_details
				where user_guid = v_user_guid and created_date = v_created_date-- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type;
			
				select count(1) into v_count  from labmcfc_v1.labmcfc_v1_otp_details
				where user_guid = v_user_guid 
				and type = v_type and current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval ;	
				
				
				
				raise notice '1234%' , v_failed_attempt;
				
				if v_count is null or v_count = 0 then 
				
					insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);
					p_data	:= '{"status": "1",
								"message": "Success",
								"otp_duration": "120"}';
								
				elseif v_count >= 1 and v_failed_attempt < 3 then
				
					update labmcfc_v1.labmcfc_v1_otp_details
					set mobile_no = coalesce( v_mobile_no,v_email_id),
						otp = v_otp,
						is_verified = 0,
						created_date = current_timestamp at time zone 'utc',
						expiry_date = current_timestamp at time zone 'utc' + '120 seconds'::interval			
				   where user_guid = v_user_guid and type = v_type;
				   
				   
						p_data	:= '{"status": "1",
								"message": "Success",
								"otp_duration": "120"}';
				   
				 elseif  v_failed_attempt >= 3 then 
				 
				 	p_data	:= '{"status": "2",
										"message": "Try after 24hrs to generate OTP"}';	
				   
			     end if;  
				   
				
				/*
				
				if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
														 or v_created_date is null )then
					
					if exists (select 1 from labmcfc_v1.labmcfc_v1_otp_details
							   where user_guid = v_user_guid and failed_attempt < 3
				               and type = v_type ;	) then
							   
							   
					
					else
					
					insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);
					p_data	:= '{"status": "1",
								"message": "Success",
								"otp_duration": "120"}';
								
								
				elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
				
					delete from labmcfc_v1.labmcfc_v1_otp_details
					where user_guid = v_user_guid and type = v_type; -- and mobile_no =coalesce( v_mobile_no,v_email_id);
					
					insert into labmcfc_v1.labmcfc_v1_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);
							p_data	:= '{"status": "1",
										"message": "Success",
										"otp_duration": "120"}';
				else						
							p_data	:= '{"status": "2",
										"message": "attempt exceeded."}';
				end if;*/
			end if;
			
		select user_full_name into v_user_full_name  from labmcfc_v1.labmcfc_v1_web_user
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
