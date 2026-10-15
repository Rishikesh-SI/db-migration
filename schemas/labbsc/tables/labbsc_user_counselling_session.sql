-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_counselling_session
-- Type: TABLE

-- Name: labbsc_user_counselling_session; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_user_counselling_session (
    session_id numeric NOT NULL,
    user_id numeric,
    counseller_id numeric,
    session_date date,
    session_slot character varying(500),
    prev_date date,
    prev_slot character varying(500),
    status numeric,
    is_rescheduled numeric,
    feedback jsonb,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone,
    is_requested numeric,
    feedback_status numeric,
    schedule_json jsonb,
    before_48 numeric,
    before_1 numeric,
    video_detail_json jsonb
);


--
