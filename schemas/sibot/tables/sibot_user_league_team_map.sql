-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_user_league_team_map
-- Type: TABLE

-- Name: sibot_user_league_team_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_user_league_team_map (
    user_league_team_map_id numeric,
    user_id numeric,
    league_id numeric,
    team_id numeric,
    alert_status numeric,
    alert_stopped_till timestamp without time zone
);


--
