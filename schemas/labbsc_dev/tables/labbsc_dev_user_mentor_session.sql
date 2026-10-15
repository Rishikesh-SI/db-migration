-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_user_mentor_session
-- Type: TABLE

-- Name: labbsc_dev_user_mentor_session; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_user_mentor_session (
    session_id numeric NOT NULL,
    user_id numeric,
    mentor_id numeric,
    module_name character varying(250),
    session_name character varying(250),
    session_date date,
    session_slot character varying(500),
    prev_date date,
    prev_slot character varying(500),
    status numeric,
    is_rescheduled numeric,
    is_requested numeric,
    feedback jsonb,
    feedback_status numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
