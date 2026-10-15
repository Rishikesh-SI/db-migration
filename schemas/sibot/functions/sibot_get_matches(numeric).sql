-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_matches(numeric)
-- Type: FUNCTION

-- Name: sibot_get_matches(numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_matches(p_application_id numeric, OUT p_count numeric, OUT p_matches numeric[]) RETURNS record
    LANGUAGE plpgsql
    AS $$

begin
    
    select array(select m.match_id
                 from sibot.sibot_match m
                 join sibot.sibot_league l
                 on l.league_id = m.league_id
                 join sibot.sibot_application_league_map alm
                 on alm.league_id = l.league_id
                 join sibot.sibot_application_match_map amm
                 on amm.application_id = alm.application_id
                 where alm.application_id = p_application_id
                 and amm.match_id = m.match_id
                 and m.status =1
                 and current_timestamp at time zone 'utc' between (m.match_start_date - '10 minutes'::interval) and m.match_start_date
                 and amm.match_alert_status = 0
                )
    into p_matches;
    
    select coalesce(array_length(p_matches,1),0) into p_count;
    
end;

$$;


--
