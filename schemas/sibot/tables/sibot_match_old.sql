-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_match_old
-- Type: TABLE

-- Name: sibot_match_old; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_match_old (
    match_id numeric,
    match_name text,
    match_start_date timestamp without time zone,
    match_end_date timestamp without time zone,
    gmt_offset text,
    team_a_id numeric,
    team_b_id numeric,
    league_id numeric,
    venue_id numeric,
    day_id numeric,
    source_id text,
    status numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
