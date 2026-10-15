-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_get_user_subscription_data_17122020(jsonb)
-- Type: FUNCTION

-- Name: gpn_get_user_subscription_data_17122020(jsonb); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_get_user_subscription_data_17122020(p_input_json jsonb, OUT p_user_subscription_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_application_id numeric;
	v_device_token text;
	v_user_id numeric;
	
begin
	
	p_result := 1;
	
	select p_input_json->>'applicationID', p_input_json->>'token'
	into v_application_id, v_device_token;
	
	select user_id
	into strict v_user_id
	from gpnv2.gpn_user
	where application_id = v_application_id
	and device_token = v_device_token;
	
	select ('{"user_settings":['||string_agg(row_to_json(row)::text,',')||']}')::jsonb
	from (select uesm.subscription_id, uesm.data_value as source_object_id, uesm.event_id
		  from gpnv2.gpn_user_event_subscription_map uesm
		  where uesm.application_id = v_application_id
		  and uesm.user_id = v_user_id
		 ) as row
	into p_user_subscription_json;
	
	if p_user_subscription_json is null then
		p_result := 0;
	end if;
	
exception
	when others then
		p_user_subscription_json := '{"user_settings":[]}'::jsonb;
end;
$$;


--
