-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_module_league_team_map
-- Type: TABLE

-- Name: sibot_application_module_league_team_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_module_league_team_map (
    application_module_league_team_map_id numeric,
    application_id numeric,
    module_id numeric,
    league_id numeric,
    team_id numeric,
    team_text text,
    team_image_url text
);


--
