-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkr
-- Object: labtkr_user_poll_response
-- Type: TABLE

-- Name: labtkr_user_poll_response; Type: TABLE; Schema: labtkr; Owner: -
--

CREATE TABLE labtkr.labtkr_user_poll_response (
    user_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone,
    is_flag numeric,
    gratification_seq numeric
);


--
