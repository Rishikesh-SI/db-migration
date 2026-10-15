-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_academy
-- Type: TABLE

-- Name: labjdtest_academy; Type: TABLE; Schema: labjdtest; Owner: -
--

CREATE TABLE labjdtest.labjdtest_academy (
    academy_id numeric NOT NULL,
    academy_name character varying(300),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric
);


--
