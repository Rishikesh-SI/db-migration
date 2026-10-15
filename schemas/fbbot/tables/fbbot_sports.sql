-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_sports
-- Type: TABLE

-- Name: fbbot_sports; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_sports (
    sport_id numeric NOT NULL,
    sport_name text NOT NULL,
    payload_text text
);


--
