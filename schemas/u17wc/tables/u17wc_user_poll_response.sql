-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: u17wc
-- Object: u17wc_user_poll_response
-- Type: TABLE

-- Name: u17wc_user_poll_response; Type: TABLE; Schema: u17wc; Owner: -
--

CREATE TABLE u17wc.u17wc_user_poll_response (
    user_poll_response_id numeric NOT NULL,
    poll_id numeric,
    response_option_id numeric,
    user_id numeric,
    response_date timestamp without time zone
);


--
