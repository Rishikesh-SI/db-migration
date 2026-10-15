-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_get_user_list_changes(refcursor, refcursor)
-- Type: FUNCTION

-- Name: fbbot_get_user_list_changes(refcursor, refcursor); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_get_user_list_changes(p_subscribe_cur refcursor, p_unsubscribe_cur refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
	v_row_limit numeric := 100;
	v_subscribe_arr numeric[];
	v_unsubscribe_arr numeric[];
	
begin
    
	select array(select user_team_map_id from fbbot.fbbot_user_team_map where status = 0 limit v_row_limit) into v_subscribe_arr;
    
	update fbbot.fbbot_user_team_map set status = 1 where user_team_map_id in(select unnest(v_subscribe_arr));
	-- ==========================================================================================================================
    insert into fbbot.fbbot_user_team_map
    select nextval('fbbot.seq_fbbot_user_team_map_id'),user_id,team_id,0
    from fbbot.fbbot_user_list_change ulc
    join fbbot.fbbot_list_team_map ltm
    on ltm.list_id = ulc.list_id
    where status = 2 and (current_timestamp at time zone 'utc')::date > alert_stopped_till;
    
	delete from fbbot.fbbot_user_list_change
    where status = 2 and (alert_stopped_till is null or (current_timestamp at time zone 'utc')::date > alert_stopped_till);
    
	select array(select user_list_change_id from fbbot.fbbot_user_list_change ulc where status = 0 order by alert_stopped_till limit v_row_limit) into v_unsubscribe_arr;
    
	update fbbot.fbbot_user_list_change set status = 1 where user_list_change_id in(select unnest(v_unsubscribe_arr));
	
	open p_subscribe_cur for
	select l.list_unique_id, u.receiver_id, u.user_id
	from fbbot.fbbot_user_team_map utm
	join fbbot.fbbot_list_team_map ltm
	on ltm.team_id = utm.team_id
	join fbbot.fbbot_list l
	on l.list_id = ltm.list_id
	join fbbot.fbbot_users u
	on u.user_id = utm.user_id
	where utm.status = 1;
	
	open p_unsubscribe_cur for
	select l.list_unique_id, u.receiver_id, u.user_id
	from fbbot.fbbot_user_list_change ulc
	join fbbot.fbbot_list l
	on l.list_id = ulc.list_id
	join fbbot.fbbot_users u
	on u.user_id = ulc.user_id
	where ulc.status = 1;
	
end;

$$;


--
