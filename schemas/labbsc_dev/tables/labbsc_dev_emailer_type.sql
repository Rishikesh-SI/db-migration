-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_emailer_type
-- Type: TABLE

-- Name: labbsc_dev_emailer_type; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_emailer_type (
    emailer_type_id numeric NOT NULL,
    emailer_name character varying(500),
    number_of_records numeric,
    is_active numeric
);


--
