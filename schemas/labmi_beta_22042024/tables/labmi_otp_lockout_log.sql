-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_otp_lockout_log
-- Type: TABLE

-- Name: labmi_otp_lockout_log; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
