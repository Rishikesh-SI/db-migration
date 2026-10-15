-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_ins_upd_activitytoken(jsonb)
-- Type: FUNCTION

-- Name: siwaf_ins_upd_activitytoken(jsonb); Type: FUNCTION; Schema: siwaf; Owner: -
--

CREATE FUNCTION siwaf.siwaf_ins_upd_activitytoken(p_json jsonb, OUT p_result numeric) RETURNS numeric
    LANGUAGE plpgsql
    AS $$

declare
v_clientid text;
v_platform text;
v_activitytoken text;
v_devicetoken text;
v_client_atid numeric;
v_flag boolean;
v_json jsonb;
begin

for v_json in (select * from jsonb_array_elements(p_json)) 
loop

select v_json->>'clientid',
v_json->>'platform',
v_json->>'activitytoken',
v_json->>'devicetoken',
v_json->>'flag'
into 
v_clientid,
v_platform,
v_activitytoken,
v_devicetoken,
v_flag;

if not exists (select 1 from siwaf.siwaf_client_activitytoken where client_id=v_clientid and activity_token=v_activitytoken and device_token=v_devicetoken) THEN

	v_client_atid:= nextval('siwaf.seq_siwaf_client_atid');

	insert into siwaf.siwaf_client_activitytoken(client_atid,client_id,platform,activity_token,device_token,created_date,updated_date,input_json,is_flag)
		values (v_client_atid,v_clientid,v_platform,v_activitytoken,v_devicetoken,current_timestamp,current_timestamp,v_json,v_flag);

else

	update siwaf.siwaf_client_activitytoken set 
	updated_date=current_timestamp,is_flag=v_flag 
	where client_id=v_clientid and 
	activity_token=v_activitytoken and 
	device_token=v_devicetoken;

end if;

end loop;

p_result:=1;

end;

$$;


--
