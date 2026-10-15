-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_match_predictor
-- Type: TABLE

-- Name: isl_match_predictor; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_match_predictor (
    match_predictor_id numeric NOT NULL,
    team_id numeric NOT NULL,
    match_id character varying NOT NULL,
    created_date timestamp without time zone NOT NULL,
    captch character varying,
    json jsonb
);


--
