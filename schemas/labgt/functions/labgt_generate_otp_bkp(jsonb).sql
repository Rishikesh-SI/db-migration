-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_generate_otp_bkp(jsonb)
-- Type: FUNCTION

-- Name: labgt_generate_otp_bkp(jsonb); Type: FUNCTION; Schema: labgt; Owner: -
--

CREATE FUNCTION labgt.labgt_generate_otp_bkp(p_inputjson jsonb, OUT p_data jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare

/*'{
  "data": {
    "mobile_no": "string",
    "otp": "string",
    "email_id": "string",
    "opt": "string",
    "type": 0,
    "user_guid": "string",
    "is_app": "string"
  }
}'*/

v_mobile_no character varying(1000);
v_email_id character varying(1000);
v_otp numeric;
v_opt numeric;
v_type numeric;
v_user_guid character varying(1000);
v_is_app numeric;
v_count numeric ;
v_created_date timestamp;
v_user_full_name character varying(1000);
v_first_name character varying;
v_last_name character varying;

begin
select p_inputjson->'data'->>'mobile_no',
  p_inputjson->'data'->>'otp',
  p_inputjson->'data'->>'email_id' ,
  p_inputjson->'data'->>'opt' ,
  p_inputjson->'data'->>'type' ,
  p_inputjson->'data'->>'user_guid',
  p_inputjson->'data'->>'is_app'  
into   v_mobile_no,
  v_otp,
  v_email_id,
  v_opt,       
  v_type,
  v_user_guid,
  v_is_app;
 
if not exists(select 1 from labgt.labgt_web_user where (mobile_no = v_mobile_no
 and mobile_verified = 1 ) or (email_id = v_email_id and is_verified =1) ) then  
 
if v_type in (1,2) then

if not exists(select 1 from labgt.labgt_otp_details
where mobile_no =coalesce(v_mobile_no,v_email_id) and expiry_date - '90 seconds'::interval > current_timestamp at time zone 'utc') then

select count(1) into v_count  from labgt.labgt_otp_details
where  mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type ;

select max(created_date) into v_created_date from labgt.labgt_otp_details
where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;

if (v_count <= 9 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 hours'::interval
or v_created_date is null )then

insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)  
values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
  current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);

p_data := '{"status": "1",
"message": "Success",
"otp_duration": "120"}';

elseif current_timestamp at time zone 'utc' > v_created_date + '1 hours'::interval then

delete from labgt.labgt_otp_details
where mobile_no =coalesce( v_mobile_no,v_email_id) and type = v_type;

insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)  
values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
  current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);

p_data := '{"status": "1",
"message": "Success",
"otp_duration": "120"}';
else
p_data := '{"status": "2",
"message": "attempt exceeded"
}';

end if;

else

p_data := '{"status": "0",
"message": "OTP not Expired"}';
end if;

elseif v_type = 3 then

select count(1) into v_count  from labgt.labgt_otp_details
where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
and type = v_type ;

select max(created_date) into v_created_date from labgt.labgt_otp_details
where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id)
and type = v_type;

if (v_count <=2 or v_count is null) and (current_timestamp at time zone 'utc' < v_created_date + '1 day'::interval
or v_created_date is null )then

insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)  
values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);

p_data := '{"status": "1",
"message": "Success",
"otp_duration": "120",
"subject":"OTP for Email Verification"}';

elseif current_timestamp at time zone 'utc' > v_created_date + '1 day'::interval then

delete from labgt.labgt_otp_details
where user_guid = v_user_guid and mobile_no =coalesce( v_mobile_no,v_email_id);

insert into labgt.labgt_otp_details(mobile_no,otp,created_date,expiry_date,is_verified,type,user_guid,is_app)  
values(coalesce( v_mobile_no,v_email_id),v_otp,current_timestamp at time zone 'utc',
current_timestamp at time zone 'utc' + '120 seconds'::interval,0,v_type,v_user_guid,v_is_app);

p_data := '{"status": "1",
"message": "Success",
"otp_duration": "120",
"subject":"OTP for Email Verification"}';
else
p_data := '{"status": "2",
"message": "attempt exceeded."}';
end if;

end if;

select first_name,last_name into v_first_name,v_last_name  from labgt.labgt_web_user
where user_guid = v_user_guid;

p_data := jsonb_set(p_data, '{first_name}', ('"'||coalesce(v_first_name,'')||'"')::jsonb, true);
p_data := jsonb_set(p_data, '{last_name}', ('"'||coalesce(v_last_name,'')||'"')::jsonb, true);

else

p_data := '{"status": "3",
"message": "Already Verified"}';

end if;

-- p_data := jsonb_set(p_inputjson, '{data,status}', 1::text::jsonb, true);

end;
$$;


--
