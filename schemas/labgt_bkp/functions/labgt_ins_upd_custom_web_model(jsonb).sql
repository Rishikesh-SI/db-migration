-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_bkp
-- Object: labgt_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labgt_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labgt_bkp; Owner: -
--

CREATE FUNCTION labgt_bkp.labgt_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_first_name character varying;
	v_last_name character varying;
	v_email_id character varying;
	v_fan_club_name character varying;
	v_captcha character varying;
v_module_name character varying;
v_mobile_no character varying;
v_user_guid character varying;
v_datajson jsonb;
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
		   p_json->'data'->'user_info'->>'email_id'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id;
/*
if v_captcha is null or v_captcha ='' then
p_data:='{
				"data": {
				"Message": "Invalid request.",
				"status":"0"
				}
				}';
 

else
*/

	 
if lower(v_module_name) = 'luckydraw' then
   
   if not exists(select 1 from labgt.labgt_custom_web_json
			 where datajson->'data'->'user_info'->>'email_id'=v_email_id )then
			
					v_custom_id:=nextval('labgt.seq_labgt_custom_id');

					insert into labgt.labgt_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

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
      
	 
  elseif lower(v_module_name) = 'playerofthematch' then
   

	if not exists (select 1 from labgt.labgt_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'playerofthematch')
	then
 
 					v_custom_id:=nextval('labgt.seq_labgt_custom_id');

					insert into labgt.labgt_custom_web_json
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
   

	if not exists (select 1 from labgt.labgt_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'virtualplayermeet')
	then
 
 					v_custom_id:=nextval('labgt.seq_labgt_custom_id');

					insert into labgt.labgt_custom_web_json
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
	
	
	/*elseif lower(v_module_name) = 'signedmerchandisedata' then
   

	if not exists(select 1 from labgt.labgt_custom_web_json
			 where datajson->'data'->'user_info'->>'email_id'=v_email_id and lower(module_name) = 'signedmerchandisedata')then
 
 					v_custom_id:=nextval('labgt.seq_labgt_custom_id');

					insert into labgt.labgt_custom_web_json
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
					
	
	end if;*/
	
		elseif lower(v_module_name) = 'fantership' then
   

	if not exists (select 1 from labgt.labgt_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fantership')
	then
 
 					v_custom_id:=nextval('labgt.seq_labgt_custom_id');

					insert into labgt.labgt_custom_web_json
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
   

	if not exists (select 1 from labgt.labgt_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'fanticket')
	then
 
 					v_custom_id:=nextval('labgt.seq_labgt_custom_id');

					insert into labgt.labgt_custom_web_json
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
		--end if;
	  
	else  
	  p_data:='{
					"data": {
					"status":"0",
					"message":"Only Single Entry Allowed"
					}
					}';
	  
	  
			
		
	  end if;

--end if;

end;
$$;


--
