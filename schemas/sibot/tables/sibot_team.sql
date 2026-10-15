-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_team
-- Type: TABLE

-- Name: sibot_team; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_team (
    team_id numeric,
    team_name text,
    team_payload_text text,
    meta_data text,
    source_id numeric,
    status numeric,
    created_date date,
    updated_date date
);


--
