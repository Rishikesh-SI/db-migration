-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labdv_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labdv; Owner: -
--

CREATE FUNCTION labdv.labdv_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
	
if lower(v_module_name) = 'fans' then
	if(v_email_id is not null and v_email_id != '') then
		v_custom_id:=nextval('labdv.seq_labdv_custom_id');
		
		insert into labdv.labdv_custom_web_json
		values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
		
		p_data:='{
					"data": {
					"status":"1",
					"message":"Pledge from a Fan"
					}
					}';
		
	end if;
	
elsif lower(v_module_name) = 'partners' then
	if(v_email_id is not null and v_email_id != '') then
		v_custom_id:=nextval('labdv.seq_labdv_custom_id');
		
		insert into labdv.labdv_custom_web_json
		values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
		
		p_data:='{
					"data": {
					"status":"1",
					"message":"Message Request from a Partner"
					}
					}';
		
	end if;
	
elsif lower(v_module_name) = 'newsletter' then
	if not exists(select 1 from labdv.labdv_custom_web_json where datajson->'data'->'user_info'->>'email_id' = v_email_id and module_name = v_module_name) then
		v_custom_id:=nextval('labdv.seq_labdv_custom_id');
		insert into labdv.labdv_custom_web_json
		values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);
		
		p_data:='{
					"data": {
					"status":"1"
					}
					}';
	else
		p_data:='{
					"data": {
					"status":"0",
					"message":"Email_id Already Exists"
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

end;
$$;


--
