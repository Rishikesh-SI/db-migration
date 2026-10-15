-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_ins_topics_for_league_subscription(numeric, numeric, refcursor)
-- Type: FUNCTION

-- Name: gpn_ins_topics_for_league_subscription(numeric, numeric, refcursor); Type: FUNCTION; Schema: gpn; Owner: -
--

CREATE FUNCTION gpn.gpn_ins_topics_for_league_subscription(p_client_id numeric, p_opt_type numeric, p_topic_detail refcursor) RETURNS SETOF refcursor
    LANGUAGE plpgsql
    AS $$

declare
	
    v_league_id numeric;
--    v_match_id numeric;
--    v_team_a_id numeric;
--    v_team_b_id numeric;
    v_current_timestamp timestamp without time zone := current_timestamp;
    v_ENVIRONMENT_TOPIC_SUFFIX varchar(256);
    
begin
    select  ENVIRONMENT_TOPIC_SUFFIX into v_ENVIRONMENT_TOPIC_SUFFIX 
   from gpn.gpn_environment where environment_id=1;
   
   
    IF p_opt_type = 1 THEN
        select league_id into v_league_id from gpn.gpn_client_league_map where client_id=p_client_id;
        
        insert into gpn.gpn_topic(topic_id, topic_name, topic_arn, application_id, league_id, match_id, team_id, event_id, subscription_id, language_id,
                                  status, created_date, updated_date, is_active, is_deleted)
      select nextval('gpn.seq_gpn_topic_id') topic_id,
             'TOPIC-'||application_id||'-'||league_id||'-'||match_id||'-'||team_id||'-'||event_id||'-'||subscription_id||'-'||language_id||'-'||v_ENVIRONMENT_TOPIC_SUFFIX topic_name,
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
            
          --  where  clm.league_id = v_league_id
            where    cam.client_id = p_client_id
            and    aesm.is_active=1 and aesm.is_deleted=0
           
        ) tab
        where (application_id, league_id, match_id, team_id, event_id, subscription_id, language_id) not in
        (
            select application_id, league_id, match_id, team_id, event_id, subscription_id, language_id
            from   gpn.gpn_topic
            where  league_id = v_league_id
        );
        
        perform 1;
        
    --    insert into gpn.gpn_user_topic_map(user_topic_map_id, user_id, topic_id, status, subscription_arn, created_date, updated_date, is_active,
    --                                       is_deleted)
    --    select nextval('gpn.seq_gpn_user_topic_map_id'), user_id, topic_id, 0 status, null, 
    --    v_current_timestamp, v_current_timestamp, 1, 0
    --    from
    --   ( select distinct u.user_id, t.topic_id
    --    from   gpn.gpn_topic t
    --    join   gpn.gpn_match m
    --    on     m.match_id = t.match_id
    --    and    m.league_id = t.league_id
    --    join   gpn.gpn_user_event_subscription_map uesm
    --    on     uesm.event_id = t.event_id
    --    and    uesm.subscription_id = t.subscription_id
    --    and    uesm.league_id =t.league_id
    --    and    ( (m.team_a_id =
    --              case when uesm.subscription_id=2 then uesm.data_value else m.team_a_id end)
    --            OR
    --             (m.team_b_id =
    --              case when uesm.subscription_id=2 then uesm.data_value else m.team_b_id end)
    --           )
    --    join   gpn.gpn_user u
    --    on     u.user_id = uesm.user_id
    --    where  t.league_id = v_league_id
    --    and    t.topic_arn = 'na'
    --    and    t.status = 0
    --   -- and    m.match_id = v_match_id
    --    and    u.application_id=t.application_id
    --    and    u.notification_enabled = 1) ad;
        
        perform 2;
        
        open p_topic_detail for
        select topic_id topicid, topic_name topicname
        from   gpn.gpn_topic
        where  league_id = v_league_id
        and    topic_arn = 'na'
        and    status = 0;
    end if;
    
end;

$$;


--
