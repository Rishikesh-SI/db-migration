-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_poll_option
-- Type: TABLE

-- Name: labkkr_poll_option; Type: TABLE; Schema: labkkr; Owner: -
--

CREATE TABLE labkkr.labkkr_poll_option (
    poll_option_id numeric NOT NULL,
    poll_id numeric,
    option character varying,
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
