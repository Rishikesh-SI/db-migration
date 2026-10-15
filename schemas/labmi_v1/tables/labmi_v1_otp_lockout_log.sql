-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_otp_lockout_log
-- Type: TABLE

-- Name: labmi_v1_otp_lockout_log; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
