-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_leagues
-- Type: TABLE

-- Name: fbbot_leagues; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_leagues (
    league_id numeric NOT NULL,
    league_name text NOT NULL,
    payload_text text NOT NULL,
    sport_id numeric NOT NULL,
    league_start_date timestamp without time zone,
    league_end_date timestamp without time zone,
    league_short_code text
);


--
