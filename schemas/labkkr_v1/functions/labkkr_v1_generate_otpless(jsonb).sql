-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_generate_otpless(jsonb)
-- Type: FUNCTION

-- Name: labkkr_v1_generate_otpless(jsonb); Type: FUNCTION; Schema: labkkr_v1; Owner: -
--

CREATE FUNCTION labkkr_v1.labkkr_v1_generate_otpless(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
	v_client_code character varying(1000);
	v_unique_id text;
	v_max_request_count numeric;
	v_date numeric;
	v_country_code numeric;
begin

-- insert into siwaf.siwaf_client_logs(api_error_log_id,log_method_name,
-- log_error_message,log_guid,error_json,created_date,client_name,log_type)
-- values (nextval('siwaf.seq_siwaf_api_error_log_id'),'generate-otpless','logs',uuid_generate_v4(),p_inputjson,current_timestamp,'labkkr_v1','logs');
  
	select p_inputjson->'data'->>'mobile_no',
		p_inputjson->'data'->>'country_code'
	
	into   v_mobile_no,
				v_country_code;
    
    select count(mobile_no) into v_attempt from labkc_v1.labkc_v1_otpless_details where 
	mobile_no=v_mobile_no  and country_code=v_country_code and created_date::date=current_date group by mobile_no; 
	
    v_attempt:=coalesce(v_attempt,0)+1;

		
if v_attempt<=10 then 

	insert into labkc_v1.labkc_v1_otpless_details values (v_mobile_no,v_created_date,'labkkr_v1',null,v_country_code) ;	

	p_data:='{
	"status":"1",
	"message":"Success",
	"attempt": "'||v_attempt||'/10",
    "current_attempt":"'||v_attempt||'",
    "max_attempt":"10"
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
