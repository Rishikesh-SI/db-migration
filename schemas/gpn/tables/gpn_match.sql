-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_match
-- Type: TABLE

-- Name: gpn_match; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_match (
    match_id numeric NOT NULL,
    match_name character varying(100) NOT NULL,
    match_start_date timestamp without time zone NOT NULL,
    match_end_date timestamp without time zone,
    gmt_offset character varying(20) NOT NULL,
    match_venue character varying(100),
    league_id numeric NOT NULL,
    team_a_id numeric NOT NULL,
    team_b_id numeric NOT NULL,
    source_object_id character varying(100),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
