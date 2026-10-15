-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_sync_guest_login_users(jsonb)
-- Type: FUNCTION

-- Name: labyho_sync_guest_login_users(jsonb); Type: FUNCTION; Schema: labyho; Owner: -
--

CREATE FUNCTION labyho.labyho_sync_guest_login_users(p_input_json jsonb, OUT p_result numeric, OUT p_output_json jsonb) RETURNS record
    LANGUAGE plpgsql
    AS $$
declare
	
	v_user_guid character varying(500);
	v_guest_guid character varying(500);
	v_user_id numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_year_month numeric := to_char(v_current_timestamp,'YYYYMM')::numeric;
	
begin
	
	select p_input_json->>'user_guid', p_input_json->>'guest_guid'
	into v_user_guid, v_guest_guid;
	
	begin
		select user_id
		into v_user_id
		from labyho.labyho_web_user
		where user_guid = v_user_guid;
	exception
		when no_data_found then
			v_user_id := 0;
	end;
	
	if not exists(select 1 from labyho.labyho_guest_login_user_map
				  where guest_guid = v_guest_guid) then
		
		insert into labyho.labyho_guest_login_user_map(guest_guid, user_guid, user_id, created_date, updated_date)
		select v_guest_guid, v_user_guid, v_user_id, v_current_timestamp, v_current_timestamp;
		
	end if;
	
	update labyho.labyho_user_preferences
	set user_guid = v_user_guid,
		user_id = v_user_id
	where guest_guid = v_guest_guid;
	
	update labyho.labyho_user_action_tracking
	set user_guid = v_user_guid
	where action_year_month = v_year_month
	and guest_guid = v_guest_guid;
	
exception
	when others then
		p_result := -1;
	
end;
$$;


--
