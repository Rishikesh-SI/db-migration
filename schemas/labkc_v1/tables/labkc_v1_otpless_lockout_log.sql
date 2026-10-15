-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_otpless_lockout_log
-- Type: TABLE

-- Name: labkc_v1_otpless_lockout_log; Type: TABLE; Schema: labkc_v1; Owner: -
--

CREATE TABLE labkc_v1.labkc_v1_otpless_lockout_log (
    id bigint NOT NULL,
    mobile_no character varying(1000) NOT NULL,
    lock_time timestamp without time zone DEFAULT now() NOT NULL,
    country_code numeric NOT NULL,
    unlock_time timestamp without time zone,
    unlock_type numeric
);


--
