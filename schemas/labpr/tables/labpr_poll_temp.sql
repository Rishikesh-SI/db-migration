-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_poll_temp
-- Type: TABLE

-- Name: labpr_poll_temp; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_poll_temp (
    answer_id numeric,
    answer_display_value text,
    poll_option_id numeric,
    poll_id numeric,
    question text
);


--
