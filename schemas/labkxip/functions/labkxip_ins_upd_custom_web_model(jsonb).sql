-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labkxip_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labkxip; Owner: -
--

CREATE FUNCTION labkxip.labkxip_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
		   p_json->'data'->>'captcha'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha;


 					v_custom_id:=nextval('labkxip.seq_labkxip_custom_id');

					insert into labkxip.labkxip_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"message":"Success"
					}
					}';
	

--end if;

end;
$$;


--
