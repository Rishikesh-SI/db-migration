-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmao_bkp
-- Object: labmao_poll_response
-- Type: TABLE

-- Name: labmao_poll_response; Type: TABLE; Schema: labmao_bkp; Owner: -
--

CREATE TABLE labmao_bkp.labmao_poll_response (
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
