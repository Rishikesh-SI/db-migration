-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_ins_upd_custom_web_model_bckup_10may2023(jsonb)
-- Type: FUNCTION

-- Name: lablsg_v1_ins_upd_custom_web_model_bckup_10may2023(jsonb); Type: FUNCTION; Schema: lablsg_v1; Owner: -
--

CREATE FUNCTION lablsg_v1.lablsg_v1_ins_upd_custom_web_model_bckup_10may2023(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
           p_json->'data'->'user_info'->>'mobile_no'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id,
    v_mobile_no;

--if lower(v_module_name) = 'luckydraw' then
   
--  if not exists(select 1 from lablsg_v1.lablsg_v1_custom_web_json
			-- where datajson->'data'->'user_info'->>'email_id'=v_email_id and module_name='luckydraw')
			 
			-- then
            if not exists(select 1 from lablsg_v1.lablsg_v1_custom_web_json where 
                          datajson->'data'->'user_info'->>'email_id'=v_email_id or 
                          datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no) then
			
					v_custom_id:=nextval('lablsg_v1.seq_lablsg_v1_custom_id');

					insert into lablsg_v1.lablsg_v1_custom_web_json
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
   

	if not exists (select 1 from lablsg_v1.lablsg_v1_custom_web_json where user_guid = v_user_guid and lower(module_name) = 'virtualplayermeet')
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
