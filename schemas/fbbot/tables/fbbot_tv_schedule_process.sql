-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_tv_schedule_process
-- Type: TABLE

-- Name: fbbot_tv_schedule_process; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_tv_schedule_process (
    date text,
    channel_id numeric,
    network text,
    league_id numeric,
    programme text,
    match_id numeric,
    matchup text,
    team_a_id numeric,
    team_a text,
    team_b_id numeric,
    team_b text,
    start_time text,
    end_time text,
    sport_id numeric,
    genre text
);


--
