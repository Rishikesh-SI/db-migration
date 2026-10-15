-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_login_admin_user(jsonb, refcursor, refcursor, refcursor, refcursor, refcursor)
-- Type: FUNCTION

-- Name: gpn_login_admin_user(jsonb, refcursor, refcursor, refcursor, refcursor, refcursor); Type: FUNCTION; Schema: gpn_v2; Owner: -
--

CREATE FUNCTION gpn_v2.gpn_login_admin_user(p_input_json jsonb, p_user_cur refcursor, p_event_cur refcursor, p_sport_cur refcursor, p_language_cur refcursor, p_country_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
     v_user_name character varying(50);
     v_password character varying(50);
     v_client_code character varying(10);
     v_client_id numeric;
     v_admin_user_id numeric;
     v_is_locked numeric;
     v_current_timestamp timestamp := current_timestamp at time zone 'utc';
     v_success numeric;
     v_failed_attempts numeric;
     v_unlock_date timestamp;
     v_result numeric;
     
     
begin
	
     select p_input_json->>'username', p_input_json->>'password', lower(p_input_json->>'client_code')
	into v_user_name, v_password, v_client_code;
     
     select client_id into strict v_client_id
     from gpn_v2.gpn_client
     where lower(client_code) = v_client_code;
     
     select admin_user_id into strict v_admin_user_id
	from gpn_v2.gpn_admin_user
	where user_name = v_user_name
     and user_password = v_password
     and client_id = v_client_id;
     
     select count(1) into v_is_locked
	from gpn_v2.gpn_admin_user
	where admin_user_id = v_admin_user_id
     and unlock_date >= v_current_timestamp;
     
     if v_admin_user_id is not null and v_is_locked = 0 then
		
          update gpn_v2.gpn_admin_user
          set failed_attempts = 0, unlock_date = null
          where admin_user_id = v_admin_user_id;
          
		v_success := 1;
          
	else
     	
		select admin_user_id, failed_attempts into v_admin_user_id, v_failed_attempts
		from gpn_v2.gpn_admin_user
		where user_name = v_username;
          
		v_failed_attempts := coalesce(v_failed_attempts,0) + 1;
		v_unlock_date := v_current_timestamp + interval '15 minutes';
          
		update gpn_v2.gpn_admin_user
		set failed_attempts = v_failed_attempts,
          	unlock_date = case when v_failed_attempts = v_max_failed_attempts then v_unlock_date else unlock_date end
		where admin_user_id = v_admin_user_id;
          
		v_success := 0;
          
	end if;
     
     if v_success = 1 then
		v_result := 1;
	elsif v_is_locked = 1 then
		v_result := 2;
	else
        v_result := 0;
	end if;
     
     if v_success = 1 then
     	
          open p_user_cur for
	  	select v_result as success_status, au.user_name, au.display_name, au.full_name, c.client_id, c.client_name
	  	from gpn_v2.gpn_admin_user au
	  	join gpn_v2.gpn_client c
	  	on au.client_id = c.client_id
	  	where au.admin_user_id = v_admin_user_id;
	  	
	  	open p_event_cur for
	  	select e.event_id, e.event_name, e.content_type
	  	from gpn_v2.gpn_client_event_map cem
	  	join gpn_v2.gpn_event e
	  	on cem.event_id = e.event_id
	  	where cem.client_id = v_client_id
	  	and e.is_editorial = 1
	  	order by e.event_name;
	  	
	  	open p_sport_cur for
	  	select s.sport_id, s.sport_name||' ('||l.league_name||')' as sport_name, l.league_id, l.league_name, l.source_object_id
	  	from gpn_v2.gpn_client c
	  	join gpn_v2.gpn_client_league_map clm
	  	on c.client_id = clm.client_id
	  	join gpn_v2.gpn_league l
	  	on clm.league_id = l.league_id
	  	join gpn_v2.gpn_sport s
	  	on l.sport_id = s.sport_id
	  	where c.client_id = v_client_id
	  	and l.is_editorial = 1
	  	order by s.sport_name;
	  	
	  	open p_language_cur for
	  	select l.language_id, l.language_name
	  	from gpn_v2.gpn_language l
          join gpn_v2.gpn_client_language_map clm
          on clm.language_id = l.language_id
	  	where clm.client_id = v_client_id
		order by l.language_name;
		
          open p_country_cur for
          select c.country_id, c.country_name
          from gpn_v2.gpn_client_country_map ccm
          join gpn_v2.gpn_country c
          on c.country_id = ccm.country_id
          where ccm.client_id = v_client_id
          order by country_id;
		
	else
     	
          open p_user_cur for
		select v_result as success_status;
		open p_event_cur for
		select null;
		open p_sport_cur for
		select null;
		open p_language_cur for
		select null;
		open p_country_cur for
		select null;
		
	end if;
     
end;

$$;


--
