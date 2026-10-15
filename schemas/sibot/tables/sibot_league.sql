-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_league
-- Type: TABLE

-- Name: sibot_league; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_league (
    league_id numeric,
    league_name text,
    league_short_name text,
    league_start_date date,
    league_end_date date,
    league_payload_text text,
    sport_id numeric,
    is_active numeric,
    has_teams numeric DEFAULT 0,
    meta_data text,
    created_date date,
    updated_date date
);


--
