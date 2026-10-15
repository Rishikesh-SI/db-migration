-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_league_team_player_map_old
-- Type: TABLE

-- Name: sibot_application_league_team_player_map_old; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_league_team_player_map_old (
    application_league_team_player_map_id numeric,
    application_id numeric,
    league_id numeric,
    team_id numeric,
    player_id numeric,
    player_image_url text,
    player_profile_url text
);


--
