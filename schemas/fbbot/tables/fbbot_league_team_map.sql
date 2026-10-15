-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_league_team_map
-- Type: TABLE

-- Name: fbbot_league_team_map; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_league_team_map (
    league_team_map_id numeric NOT NULL,
    league_id numeric NOT NULL,
    team_id numeric NOT NULL,
    is_team_common numeric NOT NULL
);


--
