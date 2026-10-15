-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: sibot
-- Object: sibot_list
-- Type: TABLE

-- Name: sibot_list; Type: TABLE; Schema: sibot; Owner: -
--

CREATE TABLE sibot.sibot_list (
    list_id numeric,
    list_name text,
    list_key text,
    application_id numeric,
    list_type character varying(1),
    league_id numeric,
    match_id numeric,
    team_a_id numeric,
    team_b_id numeric,
    status numeric,
    created_date date,
    team_id numeric
);


--
