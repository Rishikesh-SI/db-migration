-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_match_ak23aug2017
-- Type: TABLE

-- Name: gpn_match_ak23aug2017; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_match_ak23aug2017 (
    match_id numeric,
    match_name character varying(100),
    match_start_date timestamp without time zone,
    match_end_date timestamp without time zone,
    gmt_offset character varying(20),
    match_venue character varying(100),
    league_id numeric,
    team_a_id numeric,
    team_b_id numeric,
    source_object_id character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
