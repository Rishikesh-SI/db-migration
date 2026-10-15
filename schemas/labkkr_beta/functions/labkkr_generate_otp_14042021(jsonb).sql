-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_beta
-- Object: labkkr_generate_otp_14042021(jsonb)
-- Type: FUNCTION

-- Name: labkkr_generate_otp_14042021(jsonb); Type: FUNCTION; Schema: labkkr_beta; Owner: -
--

CREATE FUNCTION labkkr_beta.labkkr_generate_otp_14042021(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
			
		
		select count(1) into v_count  from labkkr.labkkr_otp_details
		where user_guid = v_user_guid 
		--and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type ;	
		
		select max(created_date) into v_created_date from labkkr.labkkr_otp_details
		where user_guid = v_user_guid --and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type;
		
		
		
		if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		-- raise notice 'attempt count null wali : % ',  v_created_date ;
		-- raise notice 'v_created_date count : % ',  v_count ;
		-- raise notice 'current_timestamp count : % ',  current_timestamp at time zone 'utc' ;
			
			insert into labkkr.labkkr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
			p_data	:= '{"status": "1",
		 				"message": "OTP is sent to your email and will be valid for 30 minutes",
						"otp_duration": "1800"}';
			
		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
			
		 raise notice 'v_created_date date wali : % ',  v_created_date ;
		 
			insert into labkkr.labkkr_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '1800 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
					p_data	:= '{"status": "1",
		 						"message": "OTP is sent to your email and will be valid for 30 minutes",
								"otp_duration": "1800"}';
		else						
					p_data	:= '{"status": "2",
		 						"message": "OTP attempts exceeded. Please try again in 24hrs."}';
		end if;
	
	
	end if;
	
	
	/*select user_full_name into v_user_full_name  from labkkr.labkkr_web_user
	where user_guid = v_user_guid;*/
	v_user_full_name:=null;
	
		   p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;

$$;


--
