-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_otpless_lockout_log_15092025
-- Type: TABLE

-- Name: labkc_v1_otpless_lockout_log_15092025; Type: TABLE; Schema: labkc_v1; Owner: -
--

CREATE TABLE labkc_v1.labkc_v1_otpless_lockout_log_15092025 (
    id bigint,
    mobile_no character varying(1000),
    lock_time timestamp without time zone,
    country_code numeric,
    unlock_time timestamp without time zone,
    unlock_type numeric
);


--
