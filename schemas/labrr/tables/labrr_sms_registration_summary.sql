-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_sms_registration_summary
-- Type: TABLE

-- Name: labrr_sms_registration_summary; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_sms_registration_summary (
    date date NOT NULL,
    web_sms_out integer DEFAULT 0,
    app_sms_out integer DEFAULT 0,
    total_sms_out integer DEFAULT 0,
    web_registered_count integer DEFAULT 0,
    app_registered_count integer DEFAULT 0,
    total_registered_count integer DEFAULT 0,
    web_completed_profile_count integer DEFAULT 0,
    app_completed_profile_count integer DEFAULT 0,
    total_completed_profile_count integer DEFAULT 0,
    created_at timestamp without time zone DEFAULT CURRENT_TIMESTAMP
);


--
