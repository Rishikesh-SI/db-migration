-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrs
-- Object: labrs_user_poll_response
-- Type: TABLE

-- Name: labrs_user_poll_response; Type: TABLE; Schema: labrs; Owner: -
--

CREATE TABLE labrs.labrs_user_poll_response (
    user_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone,
    is_flag numeric,
    gratification_seq numeric
);


--
