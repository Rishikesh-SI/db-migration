-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_check_mobilenum_exist_r_bk(jsonb)
-- Type: FUNCTION

-- Name: labmi_check_mobilenum_exist_r_bk(jsonb); Type: FUNCTION; Schema: labmi; Owner: -
--

CREATE FUNCTION labmi.labmi_check_mobilenum_exist_r_bk(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

declare
/* input of function:-

select * from labmi.labmi_check_mobilenum_exist(
'{
  "mobile_no": "8108789945",
  "email_id": "abc@gmail.com",
}') */
v_mobile_no character varying(1000);
v_email_id character varying(1000);
v_status numeric;
v_type numeric;
v_msg text;
v_count numeric;
v_created_date timestamp;

begin
select  p_inputjson->>'mobile_no',
   p_inputjson->>'email_id',
p_inputjson->>'type'
into v_mobile_no,
v_email_id,
v_type;

-- raise notice '% ,% ',v_mobile_no,v_email_id;

if v_mobile_no is not null and v_email_id is not null then

v_status := -1 ;
       v_msg := 'Invalid Request';

elseif v_mobile_no is null and v_email_id is null then

v_status := -1 ;
      v_msg := 'Invalid Request';

elseif v_email_id is not null then

if v_type=3 then

if exists(select 1 from labmi.labmi_web_user
 where email_id = v_email_id and client_id=5 and is_verified=1 ) then --and is_active = 1 and is_deleted = 0
v_status := 0 ;
v_msg := 'email_id already exist';
else
v_status := 1 ;
v_msg := 'email_id do not exist';

end if;
else

if exists(select 1 from labmi.labmi_web_user
 where email_id = v_email_id and client_id=5 ) then --and is_active = 1 and is_deleted = 0
v_status := 0 ;
v_msg := 'email_id already exist';
else
v_status := 1 ;
v_msg := 'email_id do not exist';

end if;

end if;

elseif v_mobile_no is not null then

if  exists(select 1 from labmi.labmi_web_user
 where mobile_no = v_mobile_no and mobile_verified = 1 ) then --and is_active = 1 and is_deleted = 0
 
v_status := 0 ;
v_msg := 'mobile number already exist';
else

select count(1) into v_count  from labmi.labmi_otp_details
where mobile_no = v_mobile_no;

select max(created_date) into v_created_date from labmi.labmi_otp_details
where mobile_no = v_mobile_no;

if (v_count <= 9 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 hours'::interval
or v_created_date is null )then

v_status := 1 ;
v_msg := 'mobile number do not exist';

elseif current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

v_status := 1 ;
v_msg := 'mobile number do not exist';

else

v_status := 2 ;
v_msg := 'attempt exceeded';

end if;

end if;

end if;

p_data := '{
"status": "'|| coalesce(v_status::varchar,'')||'",
"message": "'|| coalesce(v_msg,'')||'"
  }';

   

end;

$$;


--
