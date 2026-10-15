-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_get_user_subscription(jsonb)
-- Type: FUNCTION

-- Name: gpn_get_user_subscription(jsonb); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_get_user_subscription(p_input_json jsonb, OUT p_user_subscription_json jsonb, OUT p_result numeric) RETURNS record
    LANGUAGE plpgsql
    AS $$

declare
	
     v_application_id numeric;
     v_device_token text;
     v_user_id numeric;
     
begin
	
     select p_input_json->>'applicationID', p_input_json->>'token' into v_application_id, v_device_token;
     
	begin
     	select user_id into strict v_user_id
     	from gpn_v2.gpn_user
     	where application_id = v_application_id
     	and device_token = v_device_token;
	exception
		when no_data_found then
			v_user_id = 0;
	end;
     
     select '{"user_settings":['||string_agg(row_to_json(row)::text,',')||']}'
     from (select 2 as subscription_id, m.source_object_id, string_agg(uesm.event_id::text,',') events
           from gpn_v2.gpn_user_event_subscription_map uesm
           join gpn_v2.gpn_match m
           on m.match_id = uesm.data_value
           where uesm.application_id = v_application_id
           and uesm.user_id = v_user_id
           and uesm.subscription_id = 2
           group by m.source_object_id
           union
           select 3 as subscription_id, t.source_object_id, string_agg(uesm.event_id::text,',') events
           from gpn_v2.gpn_user_event_subscription_map uesm
           join gpn_v2.gpn_team t
           on t.team_id = uesm.data_value
           where uesm.application_id = v_application_id
           and uesm.user_id = v_user_id
           and uesm.subscription_id = 3
           group by t.source_object_id
         ) as row
	into p_user_subscription_json;
     
     if p_user_subscription_json is not null then
     	p_result := 1;
     else
     	p_result := 1;
		p_user_subscription_json := '{"user_settings":[]}';
     end if;
     
exception
	when others then
     	p_result := -1;
		p_user_subscription_json := '{"user_settings":[]}';
end;

$$;


--
