-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_application_match_map_old
-- Type: TABLE

-- Name: sibot_application_match_map_old; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_application_match_map_old (
    application_match_map_id numeric,
    application_id numeric,
    match_id numeric,
    match_alert_image_url text,
    match_alert_status numeric,
    match_schedule_image_url text,
    matchcentre_url text,
    matchstory_url text
);


--
