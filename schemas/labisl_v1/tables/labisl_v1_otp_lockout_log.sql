-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_otp_lockout_log
-- Type: TABLE

-- Name: labisl_v1_otp_lockout_log; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
