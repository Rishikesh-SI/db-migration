-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_poll_response
-- Type: TABLE

-- Name: utt_poll_response; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_poll_response (
    poll_response_id numeric NOT NULL,
    poll_id numeric NOT NULL,
    response_option_id numeric,
    till_date timestamp without time zone,
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
