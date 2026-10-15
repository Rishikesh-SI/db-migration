-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_ins_upd_user_preferences(jsonb)
-- Type: FUNCTION

-- Name: labdms_ins_upd_user_preferences(jsonb); Type: FUNCTION; Schema: labdms; Owner: -
--

CREATE FUNCTION labdms.labdms_ins_upd_user_preferences(p_input_json jsonb, OUT p_result numeric, OUT p_user_preferences jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_guid character varying(500);
	v_guest_guid character varying(500);
	v_data json;
	v_user_id numeric;
	v_json jsonb;
	v_option numeric;
	v_type numeric;
	v_value numeric;
	v_result numeric;
	
begin
	
	p_result := 0;
	
	select p_input_json->>'user_guid', p_input_json->>'guest_guid', p_input_json->'data'
	into v_user_guid, v_guest_guid, v_data;
	
	begin
		select user_id
		into v_user_id
		from labdms.labdms_web_user
		where user_guid = v_user_guid;
	exception
		when no_data_found then
			v_user_id := 0;
	end;
	
	for v_json in select * from json_array_elements(v_data)
	loop
		
		select v_json->>'opt', v_json->>'type', v_json->>'id'
		into v_option, v_type, v_value;
		
		if v_option = 1 then
			
			if not exists(select 1 from labdms.labdms_user_preferences
						  where ((user_guid = v_user_guid and v_user_guid!='')
								 or (guest_guid = v_guest_guid and v_guest_guid!=''))
						  and type_id = v_type
						  and value = v_value) then
				
				insert into labdms.labdms_user_preferences(user_id, user_guid, guest_guid, type_id, type_name, value)
				select v_user_id, v_user_guid, v_guest_guid, v_type, case v_type when 18 then 'team' else null end, v_value;
				
			end if;
			
		elsif v_option = 2 then
			
			delete from labdms.labdms_user_preferences
			where ((user_guid = v_user_guid and v_user_guid!='')
				   or (guest_guid = v_guest_guid and v_guest_guid!=''))
			and type_id = v_type
			and value = v_value;
			
		end if;
		
	end loop;
	
	select * from labdms.labdms_get_user_preferences_r(p_input_json)
	into v_result, p_user_preferences;
	
	if v_result = 1 then
		p_result := 1;
	end if;
	
/*exception
	when others then
		p_result := -1;*/
end;
$$;


--
