-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: labspz_v1_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: labspz_v1; Owner: -
--

CREATE FUNCTION labspz_v1.labspz_v1_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
v_email_busi_id jsonb;
 v_user_info jsonb;
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
		   p_json->'data'->>'captcha',
			p_json->'data'->'user_info'->>'email_id',
			p_json->'data'->'user_info'
			
         
into 
	v_module_name,
	v_captcha,
	v_email_id,
	v_user_info;
	
	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
	log_error_message,log_guid,error_json,created_date,client_name,log_type)
	values ((select nextval('siwaf.seq_siwaf_api_error_log_id')),'spz_ins_upd_custom',
	'{"exception":""}',uuid_generate_v4(),p_json,CURRENT_TIMESTAMP,'labspz_v1','db-error');

	
		v_email_busi_id := jsonb_build_object(
	'is_business', jsonb_build_object(
		'filepath', 'email-templates/inquiry.html',
		'subject', 'Enquiry Details - Contact Us Form.',
		'email_id_biz','aZ1OklF2dZkCOZg+bWVBR1FPDWEb9hV+TKpVGPNg2ubM74no31lDzQ1xtjyMT3OelO+CnSXNtgKGPbhLkaKGskw9UzqVPGUOpSfFBzzduvU='
	),
	'filepath', 'email-templates/thank-you.html',
	'subject', 'Enquiry Details Received.',
	'email_id', to_jsonb(v_email_id)
);

		
		
	raise notice '%',v_email_id;
			
			if v_module_name = 'newsletter' then
			
							v_custom_id:=nextval('labspz_v1.seq_labspz_v1_custom_id');
			
							insert into labspz_v1.labspz_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_email_id);

							p_data:='{
							"data": {
							"status":"1"
							}
							}';	
						  
					
							
			elsif v_module_name = 'careers' then
			
							v_custom_id:=nextval('labspz_v1.seq_labspz_v1_custom_id');
			
							insert into labspz_v1.labspz_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_email_id);

							p_data:='{
							"data": {
							"status":"1"
							}
							}';	
						  
				
							
		elsif v_module_name = 'contactus' then
			
							v_custom_id:=nextval('labspz_v1.seq_labspz_v1_custom_id');
			
							insert into labspz_v1.labspz_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_email_id);

							p_data:='{
							"data": {
							"status":"1"
							}
							}';
							v_email_busi_id:=jsonb_set(v_email_busi_id, '{email_id}',to_jsonb(v_email_id), true);
							p_data := jsonb_set(p_data, '{data,email_body}', to_jsonb(v_email_busi_id), true);
							p_data := jsonb_set(p_data, '{data,user_info}', coalesce(v_user_info, '{}'::jsonb), true);

		elsif v_module_name = 'ebook' then
			
							v_custom_id:=nextval('labspz_v1.seq_labspz_v1_custom_id');
			
							insert into labspz_v1.labspz_v1_custom_web_json
							values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json,v_email_id);

							p_data:='{
							"data": {
							"status":"1"
							}
							}';
							--v_email_busi_id:=jsonb_set(v_email_busi_id, '{email_id}',to_jsonb(v_email_id), true);
							--p_data := jsonb_set(p_data, '{data,email_body}', to_jsonb(v_email_busi_id), true);
							p_data := jsonb_set(p_data, '{data,user_info}', coalesce(v_user_info, '{}'::jsonb), true);

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
