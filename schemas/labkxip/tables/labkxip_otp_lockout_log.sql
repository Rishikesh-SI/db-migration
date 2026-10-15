-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_otp_lockout_log
-- Type: TABLE

-- Name: labkxip_otp_lockout_log; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_otp_lockout_log (
    mobile_no character varying(1000),
    lock_time timestamp without time zone
);


--
