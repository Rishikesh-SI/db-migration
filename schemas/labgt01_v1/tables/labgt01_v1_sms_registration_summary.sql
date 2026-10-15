-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_sms_registration_summary
-- Type: TABLE

-- Name: labgt01_v1_sms_registration_summary; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_sms_registration_summary (
    sms_id bigint NOT NULL,
    date date,
    web_sms_out numeric,
    app_sms_out numeric,
    total_sms_out numeric,
    web_registered_count numeric,
    app_registered_count numeric,
    total_registered_count numeric,
    web_completed_profile_count numeric,
    app_completed_profile_count numeric,
    total_completed_profile_count numeric
);


--
