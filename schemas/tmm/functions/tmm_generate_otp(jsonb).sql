-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmm
-- Object: tmm_generate_otp(jsonb)
-- Type: FUNCTION

-- Name: tmm_generate_otp(jsonb); Type: FUNCTION; Schema: tmm; Owner: -
--

CREATE FUNCTION tmm.tmm_generate_otp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
                    if exists(select 1 from tmm.tmm_web_user
								where (mobile_no =v_mobile_no or email_id=v_email_id) and client_id=11) then
					if not exists(select 1 from tmm.tmm_otp_details
								where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '90 seconds'::interval > current_timestamp at time zone 'utc') then

						select count(1) into v_count  from tmm.tmm_otp_details
						where  mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type ;	

						select max(created_date) into v_created_date from tmm.tmm_otp_details
						where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;

						if (v_count <= 9 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 hours'::interval
														 or v_created_date is null )then

							insert into tmm.tmm_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	   
							values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
								   current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app);

						select user_full_name into v_user_full_name from tmm.tmm_web_user
							where email_id=v_email_id;

								 p_data	:= '{
								 "user_full_name":"'||coalesce(v_user_full_name,'')||'",
								 "status": "1",
								 "message": "Success",
								 "otp_duration": "120",
								"template": "{OTP} is your One Time Password (OTP) to login to your profile of TMM 2022 at https://tatamumbaimarathon.procam.in",
								"sender":"PROCMM",
								 "api_type":"1"}';

						elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

							delete from tmm.tmm_otp_details
							where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;

							insert into tmm.tmm_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	   
							values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
								   current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app);

			select user_full_name into v_user_full_name from tmm.tmm_web_user
							where email_id=v_email_id;

								 p_data	:= '{
								 "user_full_name":"'||coalesce(v_user_full_name,'')||'",
								 "status": "1",
								 "message": "Success",
								 "otp_duration": "120",
								 "template": "{OTP} is your One Time Password (OTP) to login to your profile of TMM 2022 at https://tatamumbaimarathon.procam.in",
								 "sender":"PROCMM",
								 "api_type":"1"}';
						else
								p_data	:= '{"status": "2",
											"message": "attempt exceeded"
											}';

						end if;		

					else
							p_data := '{"status": "0","message": "OTP not Expired"}';
					end if;	
				 else
                      p_data := '{"status": "0","message": "OTP Already Sent"}';
				end if;

			elseif v_opt = 3 then

				select count(1) into v_count  from tmm.tmm_otp_details
				where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type ;	

				select max(created_date) into v_created_date from tmm.tmm_otp_details
				where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
				and type = v_type;

				if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
														 or v_created_date is null )then

					insert into tmm.tmm_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	   
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app);

			select user_full_name into v_user_full_name from tmm.tmm_web_user
							where email_id=v_email_id;

					p_data	:= '{
								"user_full_name":"'||coalesce(v_user_full_name,'')||'",
								"status": "1",
								"message": "Success",
								"otp_duration": "120",
								"template": "{OTP} is your One Time Password (OTP) to login to your profile of TMM 2022 at https://tatamumbaimarathon.procam.in",
								"sender":"PROCMM",
								 "api_type":"1"}';

				elseif 	current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then

					delete from tmm.tmm_otp_details
					where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id); 

					insert into tmm.tmm_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)	   
					values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
					current_timestamp at time zone 'utc' + '600 seconds'::interval,0,v_type,v_user_guid,v_is_app);

				select user_full_name into v_user_full_name from tmm.tmm_web_user
							where email_id=v_email_id;

							p_data	:= '{
										"user_full_name":"'||coalesce(v_user_full_name,'')||'",
										"status": "1",
										"message": "Success",
										"otp_duration": "120",
										"template": "{OTP} is your One Time Password (OTP) to login to your profile of TMM 2022 at https://tatamumbaimarathon.procam.in",
										"sender":"PROCMM",
								 		"api_type":"1"}';
				else						
							p_data	:= '{"status": "2",
										"message": "attempt exceeded."}';
				end if;

			end if;
			
		
end;
$$;


--
