-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_get_teams(numeric)
-- Type: FUNCTION

-- Name: fbbot_get_teams(numeric); Type: FUNCTION; Schema: fbbot; Owner: -
--

CREATE FUNCTION fbbot.fbbot_get_teams(p_league_id numeric, OUT p_teams_json jsonb) RETURNS jsonb
    LANGUAGE plpgsql
    AS $$

begin
	
	select ('{"teams":['||string_agg((row_to_json(row))::text,',')||']}')::jsonb
	from (select t.team_id, t.team_name
			from fbbot.fbbot_league_team_map ltm
			join fbbot.fbbot_teams t
			on t.team_id = ltm.team_id
			where ltm.league_id = p_league_id
		)row
	into p_teams_json;
	
end;

$$;


--
