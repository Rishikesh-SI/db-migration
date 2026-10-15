-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_tests
-- Type: TABLE

-- Name: labbsc_user_tests; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_tests (
    test_id numeric NOT NULL,
    user_id numeric,
    cart_id numeric,
    description jsonb,
    valid_till timestamp without time zone,
    is_attempted numeric,
    attempted_on timestamp without time zone,
    test_duration numeric,
    report_url text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
