-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_upd_password(jsonb)
-- Type: FUNCTION

-- Name: labfih_upd_password(jsonb); Type: FUNCTION; Schema: labfih; Owner: -
--

CREATE FUNCTION labfih.labfih_upd_password(pjson jsonb, OUT p_out jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$
declare 
	v_user_guid				varchar;
	v_old_password			varchar;
	v_new_password			varchar;
	v_message 				varchar;
	v_status 				numeric;
	v_option_type			numeric := 22;		--update password
	v_is_app				numeric;
	v_ipaddress				varchar;
	v_platform_version		numeric;
	v_device_name			varchar;
	v_platform_type			numeric;
	v_web_user_id 			numeric;
begin 
	select
		pjson->'data'->>'user_guid',
		pjson->'data'->>'old_password',
		pjson->'data'->>'confirm_password',
		pjson->'data'->>'isapp',
		pjson->'data'->>'ipaddress',
		pjson->'data'->>'platform_version',
		pjson->'data'->>'platform_type',
		pjson->'data'->>'device_name'
	into
		v_user_guid	,
		v_old_password ,
		v_new_password,
		v_is_app,
		v_ipaddress,
		v_platform_version,
		v_platform_type,
		v_device_name;
	if exists (select 1 from labfih.labfih_web_user where user_guid = v_user_guid) then
		--if exists(select 1 from labfih.labfih_web_user where user_password = v_old_password and user_guid = v_user_guid) then
			update labfih.labfih_web_user 
			set user_password = v_new_password 
			where user_guid = v_user_guid;
			v_message := 'Password Updated Successfully';
			v_status := 1;
			
			select user_id  into v_web_user_id from labfih.labfih_web_user where user_guid = v_user_guid;

			insert into labfih.labfih_web_user_audit
			(audit_id, user_id, user_guid, ipaddress,option_type, audit_date, is_app,platform_version,device_name,platform_type)
			select nextval('labfih.seq_labfih_web_user_audit_id'), v_web_user_id,  v_user_guid, v_ipaddress,v_option_type, current_timestamp, coalesce(v_is_app,0),v_platform_version,v_device_name,v_platform_type;
		-- else
		-- 	v_message := 'Wrong Password';
		-- 	v_status := 0;
		--end if;
	else
		v_message := 'user doesnot exist';
		v_status := 0;
	end if;
	
	p_out = '{"data":{
		"status": '||coalesce(v_status,0) ||',
		"message" : "'|| coalesce(v_message,'') ||'"
		}}';
end;
$$;


--
