-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_otp_lockout_log
-- Type: TABLE

-- Name: labgt01_v1_otp_lockout_log; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone,
    country_code numeric
);


--
