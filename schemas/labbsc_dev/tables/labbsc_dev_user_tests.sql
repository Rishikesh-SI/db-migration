-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_tests
-- Type: TABLE

-- Name: labbsc_dev_user_tests; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_tests (
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
    updated_date timestamp without time zone,
    professional_score character varying(50),
    passion_score character varying(50),
    personality_code character varying(50),
    personality_code2 character varying(50),
    report_type numeric,
    communication_score character varying(50),
    planning_score character varying(50),
    problem_score character varying(50),
    observation_score character varying(50),
    verification_score character varying(50)
);


--
