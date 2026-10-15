-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_get_topic_change(numeric, refcursor)
-- Type: FUNCTION

-- Name: gpn_get_topic_change(numeric, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_get_topic_change(p_league_id numeric, p_user_topic_change_delete refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

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
        where  league_id = p_league_id
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
        where  league_id = p_league_id
    );
    
    insert into gpn.gpn_user_topic_map(user_topic_map_id, user_id, topic_id, status)
    select nextval('gpn.seq_gpn_user_topic_map_id'), u.user_id, t.topic_id, 0 status
    from   gpn.gpn_topic t
    join   gpn.gpn_user_event_subscription_map uesm
    on     uesm.event_subscription_map_id = t.event_subscription_map_id
    and    uesm.league_id = t.league_id
    join   gpn.gpn_user u
    on     u.user_id = uesm.user_id
    and    u.application_id = t.application_id
    and    u.language_id = t.language_id
    and    u.notification_enabled = 1
    join   gpn.gpn_event_subscription_map esm
    on     esm.event_subscription_map_id = uesm.event_subscription_map_id
    and    case
    		when esm.subscription_id = 1 then t.league_id
            when esm.subscription_id = 2 then t.match_id
            when esm.subscription_id = 3 then t.team_id
           end = uesm.datavalue
    where  t.league_id = p_league_id
    and    not exists(select 1
                      from   gpn.gpn_user_topic_map utm
                      where  utm.user_id  = u.user_id
                      and    utm.topic_id = t.topic_id);
	
    perform 1;
    
    open p_user_topic_change_delete for
    select t.topic_arn, u.device_token, t.application_id, utc.subscription_arn, a.application_arn
    from   gpn.gpn_user_topic_change utc
    join   gpn.gpn_topic t
    on     t.topic_id = utc.topic_id
    join   gpn.gpn_application a
    on     a.application_id = t.application_id
    join   gpn.gpn_user u
    on     u.user_id = utc.user_id
    where  utc.option = 2
    and    t.league_id = p_league_id;
    
end;

$$;


--
