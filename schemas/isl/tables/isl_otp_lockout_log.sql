-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_otp_lockout_log
-- Type: TABLE

-- Name: isl_otp_lockout_log; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
