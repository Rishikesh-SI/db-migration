-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_login_admin_user(jsonb, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gpn_login_admin_user(jsonb, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: gpnv2; Owner: -
--

CREATE FUNCTION gpnv2.gpn_login_admin_user(p_input_json jsonb, p_user_cur refcursor, p_event_cur refcursor, p_sport_cur refcursor, p_language_cur refcursor, p_country_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$
/*
SELECT * from gpnv2.gpn_login_admin_user(
	'{"client_code":"","username":"","password":""}',-- <p_input_json jsonb>, 
	'a',-- <p_user_cur refcursor>, 
	'b',-- <p_event_cur refcursor>, 
	'c',-- <p_sport_cur refcursor>, 
	'd',-- <p_language_cur refcursor>, 
	'e'-- <p_country_cur refcursor>
);
fetch all in "a";
*/
declare
	
	v_client_code character varying(10);
	v_user_name character varying(100);
	v_user_password character varying(100);
	v_client_id numeric;
	v_admin_user_id numeric;
	v_is_locked numeric;
	v_current_timestamp timestamp := current_timestamp at time zone 'utc';
	v_login_success numeric := 0;
	v_failed_attempts numeric;
	v_unlock_date timestamp;
	
begin
	
	select p_input_json->>'client_code', p_input_json->>'username', p_input_json->>'password'
	into v_client_code, v_user_name, v_user_password;
	
	if v_client_code is not null and v_client_code <> '' then
		
		select client_id
		into strict v_client_id
		from gpnv2.gpn_client
		where lower(client_code) = lower(v_client_code);
		
	end if;
	
	if v_user_name is not null and v_user_name <> '' and v_user_password is not null
		and v_user_password <> '' and v_client_id is not null then
		
		select admin_user_id
		into strict v_admin_user_id
		from gpnv2.gpn_admin_user
		where user_name = v_user_name
		and user_password = v_user_password
		and client_id = v_client_id;
		
		select 1
		into v_is_locked
		from gpnv2.gpn_admin_user
		where admin_user_id = v_admin_user_id
		and unlock_date >= v_current_timestamp;
		
		if v_is_locked is null then
			
			update gpnv2.gpn_admin_user
			set failed_attempts = 0,
				unlock_date = null
			where admin_user_id = v_admin_user_id;
			
			v_login_success := 1;
			
		else
			
			select failed_attempts
			into v_failed_attempts
			from gpnv2.gpn_admin_user
			where admin_user_id = v_admin_user_id;
			
			v_failed_attempts := coalesce(v_failed_attempts,0) + 1;
			
			v_unlock_date := v_current_timestamp + interval '15 minutes';
			
			update gpnv2.gpn_admin_user
			set failed_attempts = v_failed_attempts,
				unlock_date = case when v_failed_attempts = v_max_failed_attempts then v_unlock_date
								else unlock_date end
			where admin_user_id = v_admin_user_id;
			
		end if;
		
	end if;
	
	if v_login_success = 1 then
		
		open p_user_cur for
		select v_login_success login_success, au.admin_user_id, au.user_name, au.display_name, au.full_name,
				au.client_id, c.client_name
	  	from gpnv2.gpn_admin_user au
	  	join gpnv2.gpn_client c
	  	on au.client_id = c.client_id
	  	where au.admin_user_id = v_admin_user_id;
		
		open p_event_cur for
	  	select e.event_id, e.event_name, e.content_type, cesm.event_id as parent_event_id
	  	from gpnv2.gpn_client_event_subscription_map cesm
	  	join gpnv2.gpn_event e
	  	on cesm.child_event_id = e.event_id
	  	where cesm.client_id = v_client_id
	  	and e.for_admin_notification = 1
	  	order by e.event_name;
		
		open p_sport_cur for
	  	select row_number() over(order by s.sport_id, l.league_id) sport_league_id, s.sport_id,
				s.sport_name||' ('||l.league_name||')' sport_name, l.league_id, l.league_name, l.source_object_id league_code
	  	from gpnv2.gpn_client c
	  	join gpnv2.gpn_client_league_map clm
	  	on clm.client_id = c.client_id
	  	join gpnv2.gpn_league l
	  	on l.league_id = clm.league_id
	  	join gpnv2.gpn_sport s
	  	on s.sport_id = l.sport_id
	  	where c.client_id = v_client_id
	  	and l.for_admin_notification = 1
	  	order by s.sport_name;
		
		open p_language_cur for
	  	select l.language_id, l.language_name
	  	from gpnv2.gpn_language l
		join gpnv2.gpn_client_language_map clm
		on clm.language_id = l.language_id
		where clm.client_id = v_client_id
		order by l.language_name;
		
		open p_country_cur for
		select t.country_id, c.country_name
		from gpnv2.gpn_country c
		join gpnv2.gpn_topic t
		on t.country_id = c.country_id
		join gpnv2.gpn_application a
		on a.application_id = t.application_id
		where a.client_id = v_client_id
		group by t.country_id, c.country_name;
		
	else
		
		open p_user_cur for
		select v_login_success login_success, null admin_user_id, null user_name, null display_name, null full_name,
				null client_id, null client_name
		where 1 = 2;
		
		open p_event_cur for
	  	select null event_id, null event_name, null content_type, null parent_event_id
		where 1 = 2;
		
		open p_sport_cur for
	  	select null sport_league_id, null sport_id, null sport_name, null league_id, null league_name, null league_code
		where 1 = 2;
		
		open p_language_cur for
	  	select null language_id, null language_name
		where 1 = 2;
		
		open p_country_cur for
		select null country_id, null country_name
		where 1 = 2;
		
	end if;
	
/*exception
	when others then
		
		open p_user_cur for
		select v_login_success login_success, null admin_user_id, null user_name, null display_name, null full_name,
				null client_id, null client_name
		where 1 = 2;
		
		open p_event_cur for
	  	select null event_id, null event_name, null content_type, null parent_event_id
		where 1 = 2;
		
		open p_sport_cur for
	  	select null sport_league_id, null sport_id, null sport_name, null league_id, null league_name, null league_code
		where 1 = 2;
		
		open p_language_cur for
	  	select null language_id, null language_name
		where 1 = 2;
		
		open p_country_cur for
		select null country_id, null country_name
		where 1 = 2;*/
		
end;
$$;


--
