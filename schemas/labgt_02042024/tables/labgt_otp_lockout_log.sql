-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_otp_lockout_log
-- Type: TABLE

-- Name: labgt_otp_lockout_log; Type: TABLE; Schema: labgt_02042024; Owner: -
--

CREATE TABLE labgt_02042024.labgt_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
