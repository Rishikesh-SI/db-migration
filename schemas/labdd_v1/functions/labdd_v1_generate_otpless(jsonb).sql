-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_generate_otpless(jsonb)
-- Type: FUNCTION

-- Name: labdd_v1_generate_otpless(jsonb); Type: FUNCTION; Schema: labdd_v1; Owner: -
--

CREATE FUNCTION labdd_v1.labdd_v1_generate_otpless(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare
	/*'{
  "data": {
    "mobile_no": "string"
  }
}'*/

	v_mobile_no character varying(1000);
	v_created_date timestamp:=current_timestamp at time zone 'utc';
	v_attempt numeric;
	v_country_code character varying;
begin

	insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
log_error_message,log_guid,error_json,created_date,client_name,log_type)
values (nextval('siwaf.seq_siwaf_api_error_log_id'),'labdd_v1_otpless','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labdd_v1','logs');

	select p_inputjson->'data'->>'mobile_no',
			p_inputjson->'data'->>'country_code'
	
	into   v_mobile_no,
			v_country_code;
    
    select count(mobile_no) into v_attempt from labdd_v1.labdd_v1_otpless_details where 
	mobile_no=v_mobile_no and created_date::date=current_date group by mobile_no; 
    
    v_attempt:=coalesce(v_attempt,0)+1;

		
if v_attempt<=4 then 

	insert into labdd_v1.labdd_v1_otpless_details values (v_mobile_no,v_created_date,v_country_code);	

	p_data:='{
	"status":"1",
	"message":"Success",
	"attempt": "'||v_attempt||'/4",
    "current_attempt":"'||v_attempt||'",
    "max_attempt":"4"
	}';

else

	p_data:='{
	"status":"0",
	"message":"You have exhausted the daily limit of OTP request, Please try again after 24 hours"
	}';	

end if;

	
end;
$$;


--
