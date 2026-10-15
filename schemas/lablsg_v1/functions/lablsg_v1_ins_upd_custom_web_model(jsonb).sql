-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_first_name character varying;
	v_last_name character varying;
	v_email_id character varying;
    v_mobile_no character varying;
	v_fan_club_name character varying;
	v_captcha character varying;
v_module_name character varying;
v_user_guid character varying;
v_datajson jsonb;
v_poll_id numeric;
begin
/*
{
  "data": {
    "module": "luckydraw",
    "user_info": {
      "first_name": "Abu",
      "last_name": "Dan",
      "email_id": "ab@gmail.com",
      "mobile_no": ""
    },
    "captcha": ""
  }
}
*/

 select    p_json->'data'->>'module',
		   p_json->'data'->>'user_guid',
		   p_json->'data'->>'captcha',
		   p_json->'data'->'user_info'->>'email_id',
           p_json->'data'->'user_info'->>'mobile_no',
		   p_json->'data'->'user_info'->>'first_name',
		   p_json->'data'->'user_info'->>'last_name',
		   p_json->'data'->'user_info'->>'email_id',
			p_json->'data'->'user_info'->>'mobile_no'         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id,
    v_mobile_no,
	v_first_name,
	v_last_name,
	v_email_id,
	v_mobile_no
	;

-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'input-lablsg_v1_ins_upd_custom_web_model1','logs',uuid_generate_v4(),p_json,current_timestamp,'lablsg_v1','logs');
  

--if lower(v_module_name) = 'luckydraw' then
   
--  if not exists(select 1 from lablsg_v1.lablsg_v1_custom_web_json
			-- where datajson->'data'->'user_info'->>'email_id'=v_email_id and module_name='luckydraw')
			 
			-- then
			
			if v_module_name in ('quiz','predictor') then
			
					if not exists(select 1 from lablsg_v1.lablsg_v1_custom_web_json
								 where mobile_no=v_mobile_no 
								  and p_json->'data'->>'day'=datajson->'data'->>'day'
								 and module_name=v_module_name) then
							v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

							insert into lablsg_v1.lablsg_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_mobile_no);

							p_data:='{
							"data": {
							"status":"1"
							}
							}';	
						  
					else
					
				   p_data:='{
							"data": {
							"status":"0"
							}
							}';					
			   end if;
			
-- 			else
			
-- 				if not exists(select 1 from lablsg_v1.lablsg_v1_custom_web_json where 
-- 							  (datajson->'data'->'user_info'->>'email_id'=v_email_id or 
-- 							  datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no) 
-- 							  and module_name=v_module_name) then
				
-- 						v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

-- 						insert into lablsg_v1.lablsg_v1_custom_web_json
-- 						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

-- 						p_data:='{
-- 						"data": {
-- 						"status":"1"
-- 						}
-- 						}';	
						
-- 				else
				
-- 			   p_data:='{
-- 						"data": {
-- 						"status":"0"
-- 						}
-- 						}';					
-- 		   end if;	
	   
-- 	   end if;
		elsif lower(v_module_name) = 'preregistration' then
		
		raise notice 'v_module_name %',v_module_name;
			v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');
			
			insert into lablsg_v1.lablsg_v1_custom_web_json
			values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_mobile_no);
		p_data:='{
							"data": {
							"status":"1",
							"message":"Success"
							}
							}';
-- 			else 
-- 				p_data:='{
-- 							"data": {
-- 							"status":"0",
-- 							"message":"mobile_number or email_id is already present"
-- 							}
-- 							}';
							
	elsif lower(v_module_name) = 'brigade' then
	
   		if ((v_first_name is not null and v_first_name <> '') and (v_last_name is not null and v_last_name <>'') and (v_email_id is not null and v_email_id <> '') and (v_mobile_no is not null and v_mobile_no <> '')) THEN
		
				v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

							insert into lablsg_v1.lablsg_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							p_data:='{
							"data": {
							"status":"1",
							"message":"Success"
							}
							}';
-- 		
	else
		p_data:='{
						"data": {
						"status":"0",
						"message":"Some of required field is empty"
						}
						}';
	end if;
	
		elsif lower(v_module_name) = 'lsgpracticematch' then
	
		v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');
		
		insert into lablsg_v1.lablsg_v1_custom_web_json
		values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_mobile_no);
		p_data:='{
							"data": {
							"status":"1",
							"message":"Success"
							}
							}';	
							
	    elsif lower(v_module_name) = 'academy-registration' then
	
		v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');
		
		insert into lablsg_v1.lablsg_v1_custom_web_json
		values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_mobile_no);
		p_data:='{
							"data": {
							"status":"1",
							"message":"Success"
							}
							}';
							
		elsif lower(v_module_name) = 'brigadeform' then
	
--    		if ((v_first_name is not null and v_first_name <> '') and (v_last_name is not null and v_last_name <>'') and (v_email_id is not null and v_email_id <> '') and (v_mobile_no is not null and v_mobile_no <> '') and (v_country is not null and v_country <> '') and (v_state is not null and v_state <>'') and (v_city is not null and v_city <>'')) then
			--if not exists(select 1 from lablsg_v1.lablsg_v1_custom_web_json where datajson->'data'->'user_info'->>'mobile_no'= v_mobile_no and lower(module_name) = 'brigade') then
				v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

							insert into lablsg_v1.lablsg_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							p_data:='{
							"data": {
							"status":"1",
							"message":"Success"
							}
							}';
	
	else
		p_data:='{
						"data": {
						"status":"0",
						"message":"Some error occured"
						}
						}';

	end if;   
		/*	else
					
					
					

p_data:='{
					"data": {
					"status":"0"
					}
					}';					
       end if;
      
	 
  elseif lower(v_module_name) = 'playerofthematch' then
   

	if not exists (select 1 from lablsg_v1.lablsg_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'playerofthematch')
	then
 
 					v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

					insert into lablsg_v1.lablsg_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';				
					
	
	end if;
	elseif lower(v_module_name) = 'virtualplayermeet' then
   

	--if not exists (select 1 from lablsg_v1.lablsg_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'virtualplayermeet')
	then
 
 					v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

					insert into lablsg_v1.lablsg_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';				
					
	
	end if;

	elseif lower(v_module_name) = 'fantership' then
   

	if not exists (select 1 from lablsg_v1.lablsg_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fantership')
	then
 
 					v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

					insert into lablsg_v1.lablsg_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';				
					
	
	end if;

	elseif lower(v_module_name) = 'fanticket' then
   

	if not exists (select 1 from lablsg_v1.lablsg_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fanticket')
	then
 
 					v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

					insert into lablsg_v1.lablsg_v1_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
					
		else 
		     
			 p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
			
		
		end if;			
	  
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
	  
	  
			
		
	  end if;
*/
--end if;

end;
$$;


--
