-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: potptemp
-- Object: potptemp_ins_upd_custom_web_model(jsonb)
-- Type: FUNCTION

-- Name: potptemp_ins_upd_custom_web_model(jsonb); Type: FUNCTION; Schema: potptemp; Owner: -
--

CREATE FUNCTION potptemp.potptemp_ins_upd_custom_web_model(p_json jsonb, OUT p_data jsonb) RETURNS jsonb
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
v_school_code character varying;
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
		   p_json->'data'->'user_info'->>'name_of_school_representative',
		   p_json->'data'->>'school_code'
         
into 
	v_module_name,
	v_user_guid,
	v_captcha,
	v_email_id,
	v_first_name,
	v_school_code;

	
--	select v_module_name,
	case v_module_name
	when 'schoolregisteration' then
	
	if v_school_code is not null  then
	
		if not exists(select 1 from potptemp.potptemp_custom_web_json
					 where datajson->'data'->>'school_code'=v_school_code
					 and datajson->'data'->'user_info'->>'email_id'=v_email_id) then
					 
					v_custom_id:=nextval('potptemp.seq_potptemp_custom_id');

					insert into potptemp.potptemp_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"email_body": {
					"email_id": "'|| coalesce(v_email_id,'') ||'" ,
					"filepath": "none" ,
					"first_name": "'|| coalesce(v_first_name,'') ||'" ,
					"subject": "Registration Successful" 
					}
					}
					}';	

					else
					p_data:='{
					"data": {
					"status":"-1"
					}
					}';
		end if;

elseif v_school_code is null or v_school_code!='' then
	
--raise notice 'school_code-1 %',v_school_code;
--select * from a;

		if not exists(select 1 from potptemp.potptemp_custom_web_json
					 where datajson->'data'->'user_info'->>'email_id'=v_email_id) then 

					v_custom_id:=nextval('potptemp.seq_potptemp_custom_id');

					insert into potptemp.potptemp_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"email_body": {
					"email_id": "'|| coalesce(v_email_id,'') ||'" ,
					"filepath": "none" ,
					"first_name": "'|| coalesce(v_first_name,'') ||'" ,
					"subject": "Registration Successful" 
					}
					}
					}';	

					else
					p_data:='{
					"data": {
					"status":"-1"
					}
					}';
			end if;

	end if;

	
	when 'contactus' then
	
		if not exists(select 1 from potptemp.potptemp_custom_web_json
			 where datajson->'data'->>'school_code'=v_school_code and v_school_code is not null and v_school_code!='' )then
			
					v_custom_id:=nextval('potptemp.seq_potptemp_custom_id');

					insert into potptemp.potptemp_custom_web_json
					values(v_custom_id,v_captcha,current_timestamp,current_timestamp,v_user_guid,v_module_name,p_json);

					p_data:='{
					"data": {
					"status":"1",
					"email_body": {
					"email_id": "'|| coalesce(v_email_id,'') ||'" ,
					"filepath": "email-templates/schoolregistration.html" ,
					"first_name": "'|| coalesce(v_first_name,'') ||'" ,
					"subject": "Registration Successful" 
					}
					}
					}';	
					
					else
					p_data:='{
					"data": {
					"status":"-1"
					}
					}';

			
					
	end if;

else 
 					p_data:='{
					"data": {
					"status":"-1"
					}
					}';


	end case;
	
end;
$$;


--
