-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsg
-- Object: labdsg_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labdsg_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labdsg; Owner: -
--

CREATE FUNCTION labdsg.labdsg_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
		   p_json->'data'->>'captcha'

         
into 
	v_module_name,
	v_captcha;
	
			
			if v_module_name = 'fanarmyrecruitment' then
			
							v_custom_id:=nextval('labdsg.seq_labdsg_custom_id');
			
							insert into labdsg.labdsg_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							p_data:='{
							"data": {
							"status":"1"
							}
							}';	
							
			elsif v_module_name = 'superfans' then
						v_custom_id:=nextval('labdsg.seq_labdsg_custom_id');
			
							insert into labdsg.labdsg_custom_web_json
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
