-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_university_student
-- Type: TABLE

-- Name: labbsc_dev_university_student; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_university_student (
    university_student_id numeric NOT NULL,
    email_id text,
    university_name text,
    module_name character varying(500),
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    university_code text
);


--
