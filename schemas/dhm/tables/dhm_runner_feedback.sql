-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dhm
-- Object: dhm_runner_feedback
-- Type: TABLE

-- Name: dhm_runner_feedback; Type: TABLE; Schema: dhm; Owner: -
--

CREATE TABLE dhm.dhm_runner_feedback (
    runner_feedback_id numeric NOT NULL,
    first_name character varying(100) NOT NULL,
    last_name character varying(100) NOT NULL,
    contact_number character varying(20),
    email_id character varying(300),
    experience text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
