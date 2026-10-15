-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_ins_topics(character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_topics(character varying, character varying, character varying, character varying, character varying, character varying, character varying, timestamp without time zone, timestamp without time zone, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_ins_topics(p_league_id character varying, p_match_id character varying, p_team_a_id character varying, p_team_b_id character varying, p_match_name character varying, p_gmtoffset character varying, p_match_venue character varying, p_match_start_date timestamp without time zone, p_match_end_date timestamp without time zone, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_league_id numeric;
    v_match_id numeric;
    v_team_a_id numeric;
    v_team_b_id numeric;
    v_current_timestamp timestamp without time zone := current_timestamp;
    
begin
	
    select league_id
    into   v_league_id
    from   gpn.gpn_league
    where  source_object_id = p_league_id;
    
    select ltm.team_id
    into   v_team_a_id
    from   gpn.gpn_team t
    join   gpn.gpn_league_team_map ltm
    on     ltm.team_id = t.team_id
    where  ltm.league_id = v_league_id
    and    t.source_object_id = p_team_a_id;
    
    select ltm.team_id
    into   v_team_b_id
    from   gpn.gpn_team t
    join   gpn.gpn_league_team_map ltm
    on     ltm.team_id = t.team_id
    where  ltm.league_id = v_league_id
    and    t.source_object_id = p_team_b_id;
    
    select match_id
    into   v_match_id
    from   gpn.gpn_match
    where  league_id = v_league_id
--    and  source_object_id = p_match_id;   
    and    team_a_id in (v_team_a_id,v_team_b_id)   
    and    team_b_id in (v_team_a_id,v_team_b_id)   
    and    team_a_id <>team_b_id;
    
    if v_match_id is null then
    	
        v_match_id := nextval('gpn.seq_gpn_match_id');
        
        insert into gpn.gpn_match(match_id, match_name, match_start_date, gmt_offset, match_venue, league_id, team_a_id, team_b_id, created_date,
                                  updated_date, is_active, is_deleted, source_object_id, match_end_date)
        select v_match_id, p_match_name, p_match_start_date, p_gmtoffset, p_match_venue, v_league_id, v_team_a_id, v_team_b_id, v_current_timestamp,
        	   v_current_timestamp, 1, 0, p_match_id, p_match_end_date;
    else
        update gpn.gpn_match
        set match_name=p_match_name,
            match_start_date=p_match_start_date,
            gmt_offset=p_gmtoffset,
            match_venue=p_match_venue,
            -- team_a_id=
            source_object_id=p_match_id,
            match_end_date=p_match_end_date,
            updated_date=v_current_timestamp
        where match_id=v_match_id and league_id=v_league_id;
    end if;
    
    insert into gpn.gpn_topic(topic_id, topic_name, topic_arn, application_id, league_id, match_id, team_id, event_id, subscription_id, language_id,
                              status, created_date, updated_date, is_active, is_deleted)
	select nextval('gpn.seq_gpn_topic_id') topic_id,
    	   'TOPIC-'||application_id||'-'||league_id||'-'||match_id||'-'||team_id||'-'||event_id||'-'||subscription_id||'-'||language_id topic_name,
           'na' topic_arn, application_id, league_id, match_id, team_id, event_id, subscription_id, language_id, 0 status,
           v_current_timestamp created_date, v_current_timestamp updated_date, 0 is_active, 0 is_deleted
	from
    (
        select cam.application_id, v_league_id league_id, 0 match_id, 0 team_id, aesm.event_id, aesm.subscription_id, alangm.language_id
        from   gpn.gpn_client_league_map clm
        join   gpn.gpn_client_application_map cam
        on     cam.client_id = clm.client_id
        join   gpn.gpn_application_event_subscription_map aesm
        on     aesm.application_id = cam.application_id
        and    aesm.subscription_id = 1
        join   gpn.gpn_application_language_map alangm
        on     alangm.application_id = cam.application_id
        where  clm.league_id = v_league_id
        and    aesm.is_active=1 and aesm.is_deleted=0
        union
        select cam.application_id, v_league_id league_id, v_match_id, 0 team_id, aesm.event_id, aesm.subscription_id, alangm.language_id
        from   gpn.gpn_client_league_map clm
        join   gpn.gpn_client_application_map cam
        on     cam.client_id = clm.client_id
        join   gpn.gpn_match m
        on     m.league_id = clm.league_id
        join   gpn.gpn_application_event_subscription_map aesm
        on     aesm.application_id = cam.application_id
        and    aesm.subscription_id = 2
        join   gpn.gpn_application_language_map alangm
        on     alangm.application_id = cam.application_id
        where  clm.league_id = v_league_id
        and    m.match_id = v_match_id
--        union
--        select cam.application_id, v_league_id league_id, v_match_id, t.team_id, aesm.event_id, aesm.subscription_id, alangm.language_id
--        from   gpn.gpn_client_league_map clm
--        join   gpn.gpn_client_application_map cam
--        on     cam.client_id = clm.client_id
--        join   gpn.gpn_match m
--        on     m.league_id = clm.league_id
--        join   gpn.gpn_team t
--        on     (t.team_id = m.team_a_id
--                or t.team_id = m.team_b_id)
--        join   gpn.gpn_application_event_subscription_map aesm
--        on     aesm.application_id = cam.application_id
--        and    aesm.subscription_id = 3
--        join   gpn.gpn_application_language_map alangm
--        on     alangm.application_id = cam.application_id
--        where  clm.league_id = v_league_id
--        and    m.match_id = v_match_id
    ) tab
    where (application_id, league_id, match_id, team_id, event_id, subscription_id, language_id) not in
    (
        select application_id, league_id, match_id, team_id, event_id, subscription_id, language_id
        from   gpn.gpn_topic
        where  league_id = v_league_id
    );
    
    perform 1;
    
    insert into gpn.gpn_user_topic_map(user_topic_map_id, user_id, topic_id, status, subscription_arn, created_date, updated_date, is_active,
                                       is_deleted)
    select nextval('gpn.seq_gpn_user_topic_map_id'), user_id, topic_id, 0 status, null, 
    v_current_timestamp, v_current_timestamp, 1, 0
    from
   ( select distinct u.user_id, t.topic_id
    from   gpn.gpn_topic t
    join   gpn.gpn_match m
    on     m.match_id = t.match_id
    and    m.league_id = t.league_id
    join   gpn.gpn_user_event_subscription_map uesm
    on     uesm.event_id = t.event_id
    and    uesm.subscription_id = t.subscription_id
    and    uesm.league_id =t.league_id
    and    ( (m.team_a_id =
              case when uesm.subscription_id=2 then uesm.data_value else m.team_a_id end)
            OR
             (m.team_b_id =
              case when uesm.subscription_id=2 then uesm.data_value else m.team_b_id end)
           )
    join   gpn.gpn_user u
    on     u.user_id = uesm.user_id
    where  t.league_id = v_league_id
    and    t.topic_arn = 'na'
    and    t.status = 0
    and    m.match_id = v_match_id
    and    u.application_id=t.application_id
    and    u.notification_enabled = 1) ad;
    
    perform 2;
    
    open p_topic_detail for
    select topic_id topicid, topic_name topicname
    from   gpn.gpn_topic
    where  league_id = v_league_id
    and    topic_arn = 'na'
    and    status = 0;
    
end;

$$;


--
