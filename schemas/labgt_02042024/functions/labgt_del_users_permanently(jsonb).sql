-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_del_users_permanently(jsonb)
-- Type: FUNCTION

-- Name: labgt_del_users_permanently(jsonb); Type: FUNCTION; Schema: labgt_02042024; Owner: -
--

CREATE FUNCTION labgt_02042024.labgt_del_users_permanently(p_json jsonb, OUT p_ures_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	v_current_timestamp timestamp without time zone;
    v_opt_type numeric;
	v_expiry_date character varying;
	v_verification_key character varying;
	v_user_guid character varying;
	p_opttype numeric:=14;
	v_platform_type numeric;
	v_device_name character varying;
	v_platform_version numeric;
	v_status numeric;
	v_message character varying;
	v_is_app numeric;
	v_ipaddress character varying;
	v_reset_key character varying;
	v_subject character varying;
	v_json_array jsonb;
	v_data jsonb;
	v_user_id numeric;
begin

select p_json->>'items' into v_json_array;
for v_data in select * from jsonb_array_elements(v_json_array)
      loop
        select v_data->>'user_guid'
	   into
	   v_user_guid;
	   
	raise notice 'a %',v_user_guid;

	delete from labgt.labgt_web_user
	where user_guid=v_user_guid
	and is_deleted = 1;

 end loop;
		
		   p_ures_json:= '{
		   					"status":"1"
		   				  }';
	
		   p_result := 1  ;

        	insert into labgt.labgt_web_user_audit
            (audit_id, user_id, user_guid, ipaddress, option_type, audit_date,is_app,platform_type,device_name,platform_version)
            select nextval('labgt.seq_labgt_web_user_audit_id'), v_user_id,  v_user_guid, v_ipaddress, p_opttype, v_current_timestamp, coalesce(v_is_app,0),v_platform_type,v_device_name,v_platform_version ;

end;
$$;


--
