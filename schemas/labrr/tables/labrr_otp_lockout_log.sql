-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_otp_lockout_log
-- Type: TABLE

-- Name: labrr_otp_lockout_log; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone,
    country_code character varying
);


--
