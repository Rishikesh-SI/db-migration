-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_emailer_type
-- Type: TABLE

-- Name: labbsc_emailer_type; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_emailer_type (
    emailer_type_id numeric NOT NULL,
    emailer_name character varying(500),
    number_of_records numeric,
    is_active numeric
);


--
