-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_upd_user_email_mobile(jsonb)
-- Type: FUNCTION

-- Name: labmi_v1_upd_user_email_mobile(jsonb); Type: FUNCTION; Schema: labmi_v1; Owner: -
--

CREATE FUNCTION labmi_v1.labmi_v1_upd_user_email_mobile(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 
/*
{
"data": {
"user_guid": "string"  // add valid user guid function from api to social api and use it,
"mobile_no": "string"// accept from js and validate in backnd also encrypt it before sedning to dp,
"otp": "string" // accept from front end pass same to db,
"email_id": "string""string"// accept from front end  and validate in backnd also encrypt it before sedning to dp,
"password": "string"//accept from front end  and encrypt it before sedning to dp,
"opt": ""//if changging mail then 2 if changing mobile number then 1 ,
"is_app": "1"// if in query param is_app=1 then set 1 else ,
"app_type": ""// if is_ap=1 the take value from header 2- android ,3-ios ,else browser
}
}
*/
		   v_user_guid character varying(500);
		   v_emailid character varying(1000);
		   v_mobile_no character varying(1000);
		   v_opt numeric;
		   v_password character varying(1000);
		   v_status numeric;
		   v_message text;
		   v_otp numeric;
		   v_created_date timestamp;
		
begin
	
	select p_json->'data'->>'user_guid',
		   p_json->'data'->>'email_id',
		   p_json->'data'->>'mobile_no',
		   p_json->'data'->>'opt',
		   p_json->'data'->>'password',
		   p_json->'data'->>'otp'
		   
	into   v_user_guid,
		   v_emailid,
		   v_mobile_no,
		   v_opt,
		   v_password,
		   v_otp;
		   
	select max(created_date) into v_created_date from labmi_v1.labmi_v1_otp_details
	where mobile_no =coalesce( v_mobile_no,v_emailid) and user_guid = v_user_guid
	and opt = v_opt;	   
		   
	if v_mobile_no is not null then 
	  
			  if not exists(select 1 from labmi_v1.labmi_v1_web_user 
						   where mobile_no = v_mobile_no and client_id = 5 and mobile_verified = 1 and is_active = 1 and is_deleted = 0) then
						   
					if	exists(select 1 from labmi_v1.labmi_v1_web_user 
						   where user_guid = v_user_guid 
						   --and user_password = v_password 
						   and client_id = 5 and is_active = 1 and is_deleted = 0) then	 

							if exists(select 1 from labmi_v1.labmi_v1_otp_details
						 			where mobile_no =v_mobile_no and otp=v_otp
									and expiry_date > current_timestamp at time zone 'utc'
						  			      and created_date = v_created_date and is_verified=0
										  ) then
							
								 insert into labmi_v1.labmi_v1_web_user_history 
								 select *  from labmi_v1.labmi_v1_web_user  where user_guid = v_user_guid;
								 
								 update labmi_v1.labmi_v1_otp_details
								 set is_verified= 1
								 where mobile_no =v_mobile_no
								 and otp=v_otp and created_date = v_created_date;

								 update labmi_v1.labmi_v1_web_user
								 set mobile_no = v_mobile_no
								 where user_guid = v_user_guid;

								 v_status = 1;
								 v_message = 'Mobile Number Updated.';
								 
							else
								
								v_status = 0;
								v_message = 'Invalid OTP';
							
							end if;
						
					else	
						 v_status = 0;
						 v_message = 'Invalid Password.';
						 
					end if;	 

				else

					v_status = 2;
					v_message = 'Mobile Number already exists.';

				end if;

	 elseif v_emailid is not null then 
	 			
				if not exists(select 1 from labmi_v1.labmi_v1_web_user 
						   where email_id = v_emailid and client_id = 5 and is_verified=1 and is_active = 1 and is_deleted = 0) then
						   
					if	exists(select 1 from labmi_v1.labmi_v1_web_user 
						   where user_guid = v_user_guid 
						   --and user_password = v_password 
						   and client_id = 5 and is_active = 1 and is_deleted = 0) then	 

							if exists(select 1 from labmi_v1.labmi_v1_otp_details
						 			   where mobile_no =v_emailid and otp=v_otp 
									   and expiry_date > current_timestamp at time zone 'utc'
						  			         and created_date = v_created_date and is_verified=0) then	   

										 insert into labmi_v1.labmi_v1_web_user_history 
										 select *  from labmi_v1.labmi_v1_web_user  where user_guid = v_user_guid;
										 
										 update labmi_v1.labmi_v1_otp_details
										 set is_verified= 1
										 where mobile_no =v_mobile_no
										 and otp=v_otp and created_date = v_created_date;
										
										 update labmi_v1.labmi_v1_web_user
										 set email_id = v_emailid,
										 	 upper_email_id = v_emailid
										 where user_guid = v_user_guid;

										 v_status = 1;
										 v_message = 'Email Updated.';
										 
										 if exists(select 1 from labmi_v1.labmi_v1_web_user 
						                     where email_id = v_emailid and client_id = 5 and user_guid!=v_user_guid) then
											 
											 update labmi_v1.labmi_v1_web_user
										     set is_active = 0,
										 	 is_deleted = 1
										     where email_id = v_emailid and client_id = 5 and user_guid!=v_user_guid;
											 
											 end if;
										 
										 
										 
							else
								
								v_status = 0;
								v_message = 'Invalid OTP.';
							
							end if;
						
					else	
						 v_status = 0;
						 v_message = 'Invalid Password.';
						 
					end if;				 

				else

					v_status = 2;
					v_message = 'Email already exists.';

				end if;
	 
	 
	 end if;
	 
	 p_data := '{
	 			 "status": "'||coalesce(v_status::varchar,'')||'" ,
				  "message": "'||coalesce(v_message,'')||'" 
	            }';
	
end;
$$;


--
