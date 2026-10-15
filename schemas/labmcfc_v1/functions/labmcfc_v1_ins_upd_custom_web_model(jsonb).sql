-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmcfc_v1
-- Object: labmcfc_v1_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labmcfc_v1_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labmcfc_v1; Owner: -
--

CREATE FUNCTION labmcfc_v1.labmcfc_v1_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
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
		   p_json->'data'->>'captcha'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha
	;

if lower(v_module_name) = 'contestpage' then
			
		v_custom_id:=nextval('labmcfc_v1.seq_labmcfc_v1_custom_id');

		insert into labmcfc_v1.labmcfc_v1_custom_web_json
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

end;
$$;


--
