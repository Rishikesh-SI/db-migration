-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_league_map
-- Type: TABLE

-- Name: sibot_application_league_map; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_league_map (
    application_league_map_id numeric,
    application_id numeric,
    league_id numeric,
    show_in_buddy numeric DEFAULT 0,
    league_schedule_image_url text,
    league_schedule_image_attachment_id text,
    league_image_url text,
    bat_bowl_mode numeric
);


--
