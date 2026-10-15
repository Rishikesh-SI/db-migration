-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_matches
-- Type: TABLE

-- Name: fbbot_matches; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_matches (
    match_id numeric NOT NULL,
    match_name text NOT NULL,
    league_id numeric NOT NULL,
    match_start_date timestamp without time zone NOT NULL,
    match_end_date timestamp without time zone NOT NULL,
    gmt_offset text NOT NULL,
    team_a_id numeric NOT NULL,
    team_b_id numeric NOT NULL,
    match_venue text,
    status numeric,
    alert_image_url text,
    alert_status numeric
);


--
