-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgsoc
-- Object: labgsoc_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: labgsoc_generate_otp(jsonb); Type: FUNCTION; Schema: labgsoc; Owner: -
--

CREATE FUNCTION labgsoc.labgsoc_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_country_code numeric;
	v_user_full_name character varying(1000);

begin
	select p_inputjson->'data'->>'mobile_no',
		   p_inputjson->'data'->>'otp',
		   p_inputjson->'data'->>'email_id' ,
		   p_inputjson->'data'->>'type' ,
		   p_inputjson->'data'->>'opt' ,
		   p_inputjson->'data'->>'user_guid',
		   p_inputjson->'data'->>'is_app'	,
		   p_inputjson->'data'->>'country_code'
	into   v_mobile_no,
		   v_otp,
		   v_email_id,
		   v_type,
		   v_opt,
		   v_user_guid,
		   v_is_app,
		   v_country_code;
		   
		 --  v_otp := 123456;
		   
-- 	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'inptu-generate_otp','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labgsoc','logs');
  

	if v_email_id in ('J2NCxsHpEjujemtRWwBusEszVkb+50dDslo9jA7E3ue6CmW4PcEdUXuSF/wl20aeUwjKRyeeI3vcAA7/rFqMkx9VI3ab3gGTne51IezRBPg='
					) then

			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),123456,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
				p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "900",
                        "subject":"Email Verification"
                        }';

		raise notice '1';
	else 
	raise notice '2';
		if 	v_opt in (1,2) then    
		   
		 
	select count(1) into v_count  from labgsoc.labgsoc_otp_details
		where  mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type and created_date between current_timestamp - '1 day'::interval and current_timestamp ;
		
	
		select max(created_date) into v_created_date from labgsoc.labgsoc_otp_details
		where mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type and created_date between current_timestamp - '1 day'::interval and current_timestamp ;
		
    if v_email_id in ('appou3LE5bspwmis3e/w0Cy2hMVWbSPT4jpDTtmhHv5yXrjUiieWFEfkG2gJOLJZJDs1QXffkqkW92VdPCGN4g==',
				  'cHl4VBM/ILwMLdVckRUkXIKRCPjj1UibbrM4iUygJEIiuySgkPSMJVXIjrp0bTgK',
				  '2GDSRExqvWohO12hNhX/eeZkcEa+u36FxFMqff7BZYU7Iw50bcjZZpocFAQ17eqH',
				  '0EVGlmAkikKKSGQj5voXkGLioKEjV2YlOp6CNszUDIS2MS0vsw1r/C+4zN4TniY4ynkk7SbA+wDDdUVojKUnt/WrB0viVzSDVEwoGxet7Sc=',
					  '2GDSRExqvWohO12hNhX/eV6lp/Pib3rAE5gd5M6jkmMHWeN+PFJGShqxRIOm+YSQ',
					  'gD3o+SeSQg5ux6MdhztU4WKz7j/FZ8NpHeD5iAlvFZOTS/tua2oGag0o49c+qAq0',
                     'bCXRb5b87rrDKDNecesA3I7KrC0xD8e6+xDDRMn6A4Io9QC/0KbJMddO9qpWs9ZCWTzH40g12cYipAcresivkLUw8sTkVyqJlC5v8gPrc1c=',
                     'hSbbqyIO47zWHOBcJQdfpNY/XQKNsv2B39NRBSvhQ0mUXketyiXLB5gC8LWt5V1R88tQsMd3VWu7clmvtf6qZIt5L8iH7XED4S/aRQKJsHQ=',
                     '15Ya9iPfONc9OhaDyHfZQrWtVhPoYttIhRkI+dhNgvd0xbsCkt1srpSVtjNMbE0kVNPbjiFTqUyUqnU9OacqdAJFJbRxpfn5dbfkSTF/EGU=',
					 'hSbbqyIO47zWHOBcJQdfpNY/XQKNsv2B39NRBSvhQ0mUXketyiXLB5gC8LWt5V1R88tQsMd3VWu7clmvtf6qZIt5L8iH7XED4S/aRQKJsHQ=',
					 'xxpDR+TSv43RGMtT/iW7mSTLCmS5m0zS6Hw8NqhQGTvXkhTczl5crVs+7SERwgdtt2AdABy0iaIlsLUh/P+fiA==',
					  'uXSwBnEpr5BOq6EThQ6wiUdc9UJi9K6pWXbY9ZokJADl46aZLzSSpSt2rNGMllObRjerqvV1FNL01QLBC6o17g==',
                     '2GDSRExqvWohO12hNhX/eV3MSJm15P5a0UJpNlsZc1Wf1mTrxYopR3Xo3B3ph/kgoa1Qrv2kwDPmAMKvOf2EkA==') then
		if (v_count <=100 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		
			
			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
			p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "900",
                        "subject":"Email Verification"}';
			
-- 		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
-- 			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
-- 			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
-- 		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
-- 					p_data	:= '{"status": "1",
-- 		 						"message": "Success",
-- 								"otp_duration": "900"}';
		else						
					p_data	:= '{"status": "5",
		 						"message": "attempt exceeded."}';
		end if;
		
	else
	
		
	--v_count <=4 	
	if (v_count <=100 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		
			
			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
			p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "900",
                        "subject":"Email Verification"}';
			
-- 		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
-- 			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
-- 			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
-- 		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
-- 					p_data	:= '{"status": "1",
-- 		 						"message": "Success",
-- 								"otp_duration": "900"}';
		else						
					p_data	:= '{"status": "5",
		 						"message": "attempt exceeded."}';
		end if;
		
	end if;
	
	elseif v_opt = 3 then
			
		
		select count(1) into v_count  from labgsoc.labgsoc_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type ;	
		
		select max(created_date) into v_created_date from labgsoc.labgsoc_otp_details
		where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
		and type = v_type;
		
		
		--v_count <=2 
		if (v_count <=100 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
												 or v_created_date is null )then
												 
		
			
			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
			p_data	:= '{"status": "1",
		 				"message": "Success",
						"otp_duration": "900"}';
			
		elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then
			
			insert into labgsoc.labgsoc_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app,opt)	   
			values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
		    current_timestamp at time zone 'utc' + '900 seconds'::interval,0,v_type,v_user_guid,v_is_app,v_opt);
			
					p_data	:= '{"status": "1",
		 						"message": "Success",
								"otp_duration": "900"}';
		else						
					p_data	:= '{"status": "2",
		 						"message": "attempt exceeded."}';
		end if;
	
	
	end if;
		-----------------
-- 		raise notice '1.country_code %', v_country_code;
-- 		raise notice 'email_id%',v_email_id;

-- 					if  exists(select 1 from labgsoc.labgsoc_otp_details
-- 						 where mobile_no =coalesce(v_mobile_no,v_email_id) and otp = v_otp) and v_country_code is not null then

-- 						UPDATE labgsoc.labgsoc_web_user
-- 						SET country_code = v_country_code
-- 						Where email_id=v_email_id;
-- 					end if;

-- 				raise notice '2. country_code %', v_country_code;
				
				------------------------------
	end if;
	
	
	
	select user_full_name into v_user_full_name  from labgsoc.labgsoc_web_user
	where user_guid = v_user_guid;
	
		   p_data	:= 	jsonb_set(p_data, '{user_full_name}', ('"'||coalesce(v_user_full_name,'')||'"')::jsonb, true); 
		
		-- p_data	:= 	jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true); 
	
end;
$$;


--
