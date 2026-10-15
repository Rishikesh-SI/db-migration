-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_league_schedule
-- Type: TABLE

-- Name: fbbot_league_schedule; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_league_schedule (
    schedule_date date NOT NULL,
    sport_id numeric NOT NULL,
    league_id numeric NOT NULL,
    match_id numeric NOT NULL,
    schedule_image_url text NOT NULL,
    created_date timestamp without time zone NOT NULL
);


--
