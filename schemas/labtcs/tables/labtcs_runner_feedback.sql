-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_runner_feedback
-- Type: TABLE

-- Name: labtcs_runner_feedback; Type: TABLE; Schema: labtcs; Owner: -
--

CREATE TABLE labtcs.labtcs_runner_feedback (
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
