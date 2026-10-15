-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_get_topic_change(refcursor)
-- Type: FUNCTION

-- Name: gpn_get_topic_change(refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_get_topic_change(p_user_topic_change_delete refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_current_timestamp timestamp := current_timestamp at time zone 'utc';

begin
	
    delete
    from   gpn.gpn_user_topic_change utc
    where not exists(
        select 1
        from   gpn.gpn_user_topic_map utm
        where  utm.user_id = utc.user_id
        and    utm.topic_id = utc.topic_id
    )
    and    option = 2
    and    utc.topic_id in(
        select topic_id
        from   gpn.gpn_topic
    );
    
    delete
    from   gpn.gpn_user_topic_map
    where  (user_id, topic_id) in(
        select user_id, topic_id
        from   gpn.gpn_user_topic_change
        where  option = 2
    )
    and    topic_id in(
        select topic_id
        from   gpn.gpn_topic
    )
    and    status <> 4;
    
    insert into gpn.gpn_user_topic_map(user_topic_map_id, user_id, topic_id, status, subscription_arn, created_date, updated_date, is_active,
                                       is_deleted)
    /*select nextval('gpn.seq_gpn_user_topic_map_id'), u.user_id, t.topic_id, 0, null, v_current_timestamp, v_current_timestamp, 0, 0
    from   gpn.gpn_topic t
    join   gpn.gpn_user_event_subscription_map uesm
    on     uesm.event_id = t.event_id
    and    uesm.subscription_id = t.subscription_id
    and    uesm.league_id = t.league_id
    join   gpn.gpn_user u
    on     u.user_id = uesm.user_id
    and    u.application_id = t.application_id
    and    u.language_id = t.language_id
    and    u.notification_enabled = 1
    and    case
    		when uesm.subscription_id = 1 then t.league_id
            when uesm.subscription_id = 2 then t.match_id
            when uesm.subscription_id = 3 then t.team_id
           end = uesm.data_value
    where  not exists(select 1
                      from   gpn.gpn_user_topic_map utm
                      where  utm.user_id  = u.user_id
                      and    utm.topic_id = t.topic_id);*/
	select nextval('gpn.seq_gpn_user_topic_map_id'), user_id, topic_id, 0, null, v_current_timestamp, v_current_timestamp, 0, 0
    from
    (
    	select distinct u.user_id, t.topic_id
		from   gpn.gpn_topic t
		join   gpn.gpn_user u
		on     u.application_id = t.application_id
		and    u.language_id = t.language_id
		join   gpn.gpn_user_event_subscription_map uesm
		on     uesm.user_id = u.user_id
		and    uesm.event_id = t.event_id
		and    uesm.subscription_id = t.subscription_id
		and    uesm.league_id = t.league_id
		join   gpn.gpn_match  m
		on     (m.league_id = uesm.league_id or uesm.subscription_id=3)
		and    (m.match_id = t.match_id
                or (m.source_object_id = '0' and t.match_id = 0))
		and    case uesm.subscription_id
        		when 1 then t.league_id = uesm.data_value
        		when 2 then (m.team_a_id = uesm.data_value
                             or m.team_b_id = uesm.data_value)
				when 3 then t.team_id = uesm.data_value
        	   end
        where  not exists(select 1
                          from   gpn.gpn_user_topic_map utm
                          where  utm.user_id  = u.user_id
                          and    utm.topic_id = t.topic_id)
	)tab;
	
    perform 1;
    
    open p_user_topic_change_delete for
    select t.topic_arn, u.device_token, t.application_id, utc.subscription_arn, a.application_arn, a.platform_id, a.application_stage
    from   gpn.gpn_user_topic_change utc
    join   gpn.gpn_topic t
    on     t.topic_id = utc.topic_id
    join   gpn.gpn_application a
    on     a.application_id = t.application_id
    join   gpn.gpn_user u
    on     u.user_id = utc.user_id
    where  utc.option = 2;
    
end;

$$;


--
