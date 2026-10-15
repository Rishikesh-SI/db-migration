-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_match
-- Type: TABLE

-- Name: gpn_match; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_match (
    match_id numeric,
    match_name text,
    match_start_date timestamp without time zone,
    match_end_date timestamp without time zone,
    gmt_offset character varying(10),
    match_venue text,
    league_id numeric,
    team_a_id numeric,
    team_b_id numeric,
    source_object_id character varying(50),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
