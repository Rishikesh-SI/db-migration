-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_otp_lockout_log
-- Type: TABLE

-- Name: labmi_otp_lockout_log; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
