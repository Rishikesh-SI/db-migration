-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_poll_response
-- Type: TABLE

-- Name: waf_poll_response; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_poll_response (
    poll_response_id numeric NOT NULL,
    poll_id numeric NOT NULL,
    response_option_id character varying(500),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    poll_response_guid character varying(256) NOT NULL,
    response_count numeric
);


--
