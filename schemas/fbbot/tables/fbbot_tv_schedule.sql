-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_tv_schedule
-- Type: TABLE

-- Name: fbbot_tv_schedule; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_tv_schedule (
    schedule_date date,
    sport_id numeric,
    sport_name text,
    league_id numeric,
    league_name text,
    match_id numeric,
    match_name text,
    team_a_id numeric,
    team_a_name text,
    team_b_id numeric,
    team_b_name text,
    start_time timestamp without time zone,
    channel_id numeric,
    channel_name text
);


--
