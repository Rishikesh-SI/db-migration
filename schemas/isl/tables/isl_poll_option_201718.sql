-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_poll_option_201718
-- Type: TABLE

-- Name: isl_poll_option_201718; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_poll_option_201718 (
    poll_option_id numeric,
    poll_id numeric,
    option text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    poll_option_guid character varying(256),
    option_order numeric
);


--
