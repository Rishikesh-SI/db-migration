-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_ins_upd_custom_web_model_16february2026(jsonb)
-- Type: FUNCTION

-- Name: labrr_ins_upd_custom_web_model_16february2026(jsonb); Type: FUNCTION; Schema: labrr; Owner: -
--

CREATE FUNCTION labrr.labrr_ins_upd_custom_web_model_16february2026(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
v_custom_id numeric;
v_captcha character varying;
v_module_name character varying;
v_mobile_no character varying;
v_user_guid character varying;
v_email_id character varying;
v_datajson jsonb;
v_login numeric;
v_multiple_response numeric;

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
		   p_json->'data'->>'is_login',
		   p_json->'data'->>'multiple_response',
		   p_json->'data'->'user_info'->>'email_id',
		   p_json->'data'->'user_info'->>'mobile_no'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_login,
	v_multiple_response,
	v_email_id,
	v_mobile_no
	;
	
	
-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'insert-custom_web_model','logs',uuid_generate_v4(),p_json,current_timestamp,'labrr','logs');

if v_login=1 and v_module_name not in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter') then
raise notice ' v_login=1 ';
select coalesce(user_guid,null) into v_user_guid from labrr.labrr_web_user where user_guid=v_user_guid;

if v_user_guid is not null and v_user_guid<>'' then

if v_multiple_response=0 then

	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_set(p_json, '{data,status}', '1'::jsonb, true);
				p_data := jsonb_set(p_json, '{data,message}', '"successful"'::jsonb, true);

	else
	--raise notice ' 2v_module_name %',v_module_name;
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';	

	end if;
	
else 

				v_custom_id:=nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
				values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_set(p_json, '{data,status}', '1'::jsonb, true);
				p_data := jsonb_set(p_json, '{data,message}', '"successful"'::jsonb, true);

end if;

else 

					p_data:='{
						"data": {
							"status":"0",
							"message":"Unable to locate user information"
						}
					}';	

end if;

elsif v_login=0 and v_module_name not in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter') THEN
raise notice ' v_login=0 ';

if not exists(select 1 from labrr.labrr_custom_web_json where module_name=lower(v_module_name) and datajson->'data'->'user_info'->>'mobile_no'=v_mobile_no) AND
not exists(select 1 from labrr.labrr_custom_web_json where module_name=lower(v_module_name) and datajson->'data'->'user_info'->>'email_id'=v_email_id) and v_multiple_response=0 then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_set(p_json, '{data,status}', '1'::jsonb, true);
				p_data := jsonb_set(p_json, '{data,message}', '"successful"'::jsonb, true);
				
elsif v_multiple_response=1 THEN

						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_set(p_json, '{data,status}', '1'::jsonb, true);
				p_data := jsonb_set(p_json, '{data,message}', '"successful"'::jsonb, true);

else

	p_data:='{
						"data": {
						"status":"0"
						}
						}';					
				
end if;

else
raise notice ' elseeeeee  ';
if v_module_name in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1','royalsmatchdayscoop','newsletter','rr_sponsors') then
raise notice 'hrre';
	--raise notice 'v_module_name %',v_module_name;
	if lower(v_module_name) = 'royalsmatchdayscoop' then
   
	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

				insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_set(p_json, '{data,status}', '1'::jsonb, true);
				p_data := jsonb_set(p_json, '{data,message}', '"successful"'::jsonb, true);

	else
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';	

	end if;
	   
	elsif lower(v_module_name) in ('newsletter','rr_sponsors') then
				
								v_custom_id:=nextval('labrr.seq_labrr_custom_id');
				
								insert into labrr.labrr_custom_web_json
								values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

								p_data:='{
								"data": {
								"status":"1"
								}}';	

	elsif lower(v_module_name) in ('ipl_2025_contest_1','ipl_2025_contest_2','alan_walker_ticket_contest','send_a_wish_2','send_a_wish_3',
'send_a_wish_4','send_a_wish_5','send_a_wish_6','sign_up_matchday_jersey','lucky_draw_1') then
--raise notice 'v_module_name %',v_module_name;
	if not exists(select 1 from labrr.labrr_custom_web_json where user_guid=v_user_guid and module_name=lower(v_module_name)) then
--raise notice ' 2v_module_name %',v_module_name;
						v_custom_id:=nextval('labrr.seq_labrr_custom_id');

						insert into labrr.labrr_custom_web_json
						values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

							
				p_data := jsonb_set(p_json, '{data,status}', '1'::jsonb, true);
				p_data := jsonb_set(p_json, '{data,message}', '"successful"'::jsonb, true);

	else
	--raise notice ' 2v_module_name %',v_module_name;
				p_data:='{
					"data": {
					"status":"0",
					"message":"only single entry Allowed"
					}
					}';	

	end if;
	
	end if;

end if;

end if;						  

end;
$$;


--
