-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_match_dump
-- Type: TABLE

-- Name: sibot_match_dump; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_match_dump (
    match_id numeric,
    match_name text,
    match_start_date timestamp without time zone,
    match_end_date timestamp without time zone,
    gmt_offset text,
    match_venue text,
    team_a_id numeric,
    team_b_id numeric,
    league_id numeric,
    channels text
);


--
