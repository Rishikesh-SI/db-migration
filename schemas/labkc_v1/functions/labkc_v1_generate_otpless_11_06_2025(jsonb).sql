-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_generate_otpless_11_06_2025(jsonb)
-- Type: FUNCTION

-- Name: labkc_v1_generate_otpless_11_06_2025(jsonb); Type: FUNCTION; Schema: labkc_v1; Owner: -
--

CREATE FUNCTION labkc_v1.labkc_v1_generate_otpless_11_06_2025(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
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
begin
	select p_inputjson->'data'->>'mobile_no',
			p_inputjson->'data'->>'client_code'
	into   v_mobile_no,
			v_client_code;
    
    select count(mobile_no) into v_attempt from labkc_v1.labkc_v1_otpless_details where 
	mobile_no=v_mobile_no and client_code='labkc_v1' and created_date::date=current_date group by mobile_no; 
	
    select case when v_attempt is null then 0 
		when  v_attempt > 2 then 2
		else v_attempt end into v_max_request_count;
	
		v_unique_id:=concat(v_mobile_no::text,v_date::text,v_max_request_count::text);
		
    v_attempt:=coalesce(v_attempt,0)+1;

		
if v_attempt<=3 then 

	insert into labkc_v1.labkc_v1_otpless_details values (v_mobile_no,v_created_date,'labkc_v1',v_unique_id) ;	

	p_data:='{
	"status":"1",
	"message":"Success",
	"attempt": "'||v_attempt||'/3",
    "current_attempt":"'||v_attempt||'",
    "max_attempt":"3"
	}';

else

	p_data:='{
	"status":"0",
	"message":"You have exhausted the daily limit of OTP request, Please try again after 24 hours"
	}';	

end if;
exception when others
then
       
p_data	:= '{"status": "2",
				"message": "Failed to send otp"}';
	
end;
$$;


--
