-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_generate_otp_13042022(jsonb)
-- Type: FUNCTION

-- Name: labkkr_generate_otp_13042022(jsonb); Type: FUNCTION; Schema: labkkr_30012024; Owner: -
--

CREATE FUNCTION labkkr_30012024.labkkr_generate_otp_13042022(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
		   
	/*insert into labkkr.labkkr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
	values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		   current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
		
		 p_data	:= '{"status": "1",
		 "message": "Success",
		 "otp_duration": "1800"}';*/
		 
		 p_data	:= '{"status": "0",
		 				"message": "Invalid Request",
						"otp_duration": "1800"}';
	
	elseif v_type = 3 then
		
		select max(created_date) into v_created_date from labkkr.labkkr_otp_details
		where user_guid = v_user_guid --and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type;
		
		select coalesce(failed_attempt,0) into v_failed_attempt from labkkr.labkkr_otp_details
				where user_guid = v_user_guid and created_date = v_created_date-- and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type;
		
		select count(1) into v_count  from labkkr.labkkr_otp_details
		where user_guid = v_user_guid 
		--and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type and current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval;	
		
		
		raise notice '%' , v_failed_attempt;
				
				if v_count is null or v_count = 0 then 
				
					insert into labkkr.labkkr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	  
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);
					p_data	:= '{"status": "1",
								"message": "Success",
								"otp_duration": "120"}';
		
		
		elseif v_count >= 1 and v_failed_attempt < 3 then
				
					update labkkr.labkkr_otp_details
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
				   
				
	select user_full_name into v_user_full_name  from labkkr.labkkr_web_user
		where user_guid = v_user_guid;
		
	
		p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true);
			
	else
	
			p_data	:= '{"status": "3",
						"message": "Already Verified"}';
		
	end if;
	
	/*select user_full_name into v_user_full_name  from labkkr.labkkr_web_user
	where user_guid = v_user_guid;*/
	
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
