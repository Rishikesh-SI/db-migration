-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_poll_response_201718
-- Type: TABLE

-- Name: isl_user_poll_response_201718; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_user_poll_response_201718 (
    user_poll_response_id numeric,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone
);


--
