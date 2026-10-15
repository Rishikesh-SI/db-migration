-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_get_matches(numeric)
-- Type: FUNCTION

-- Name: fbbot_get_matches(numeric); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_get_matches(p_match_id numeric, OUT p_matches_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
	select ('{"matches":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
    from (select *
          from (select match_id,match_name,match_start_date,(select array_to_json(array_agg(a))
                                                             from(select t.team_id,t.team_name,t.payload_text
                                                                  from fbbot.fbbot_matches m1
                                                                  join fbbot.fbbot_teams t
                                                                  on (t.team_id = m1.team_a_id or t.team_id = m1.team_b_id)
                                                                  where m1.match_id = m.match_id)a)teams
                from fbbot.fbbot_matches m
                where m.match_id = coalesce(p_match_id, match_id)
                and m.status = 0
                and m.alert_status = 0
                and current_timestamp at time zone 'utc' <= m.match_start_date
			)b
			where current_timestamp at time zone 'utc' >= (b.match_start_date - interval '30 minutes')
		)row
	into p_matches_json;
	
end;

$$;


--
