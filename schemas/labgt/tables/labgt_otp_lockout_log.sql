-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_otp_lockout_log
-- Type: TABLE

-- Name: labgt_otp_lockout_log; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone,
    country_code numeric
);


--
