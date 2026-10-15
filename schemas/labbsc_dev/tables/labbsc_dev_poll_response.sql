-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_poll_response
-- Type: TABLE

-- Name: labbsc_dev_poll_response; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_poll_response (
    poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    till_date timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    poll_response_guid character varying(256),
    response_count numeric
);


--
