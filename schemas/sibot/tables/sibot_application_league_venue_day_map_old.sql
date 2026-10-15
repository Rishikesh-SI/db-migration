-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_league_venue_day_map_old
-- Type: TABLE

-- Name: sibot_application_league_venue_day_map_old; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_league_venue_day_map_old (
    application_league_venue_day_map_id numeric,
    application_id numeric,
    league_id numeric,
    venue_id numeric,
    day_id numeric,
    day_title text,
    day_image_url text,
    tickets_url text
);


--
