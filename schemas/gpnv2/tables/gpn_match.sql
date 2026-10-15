-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_match
-- Type: TABLE

-- Name: gpn_match; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_match (
    match_id numeric NOT NULL,
    match_name character varying(100) NOT NULL,
    match_start_date timestamp without time zone NOT NULL,
    match_end_date timestamp without time zone NOT NULL,
    gmt_offset character varying(10) NOT NULL,
    match_venue character varying(100) NOT NULL,
    league_id numeric NOT NULL,
    team_a_id numeric NOT NULL,
    team_b_id numeric NOT NULL,
    source_object_id character varying(50) NOT NULL,
    created_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    updated_date timestamp without time zone DEFAULT timezone('utc'::text, CURRENT_TIMESTAMP) NOT NULL,
    is_active numeric DEFAULT 0 NOT NULL,
    match_status character varying(1)
);


--
