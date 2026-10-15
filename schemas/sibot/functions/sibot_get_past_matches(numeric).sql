-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_get_past_matches(numeric)
-- Type: FUNCTION

-- Name: sibot_get_past_matches(numeric); Type: FUNCTION; Schema: sibot; Owner: -
--

CREATE FUNCTION sibot.sibot_get_past_matches(p_application_id numeric, OUT p_match_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
    select '{"matches":['||string_agg(row_to_json(row)::text,',')||']}'
    from (select m.match_id,m.match_name
          from sibot.sibot_match m
          join sibot.sibot_league l
          on l.league_id = m.league_id
          join sibot.sibot_application_league_map alm
          on alm.league_id = l.league_id
          join sibot.sibot_application_match_map amm
          on amm.match_id = m.match_id
          where alm.application_id = p_application_id
          and amm.application_id = alm.application_id
          and m.match_end_date <= current_timestamp at time zone 'utc'
          and amm.matchstory_url is null
        )row
	into p_match_json;
    
end;

$$;


--
