-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fbbot
-- Object: fbbot_teams
-- Type: TABLE

-- Name: fbbot_teams; Type: TABLE; Schema: fbbot; Owner: -
--

CREATE TABLE fbbot.fbbot_teams (
    team_id numeric NOT NULL,
    team_name text NOT NULL,
    team_selection_text text,
    payload_text text,
    team_short_code text
);


--
