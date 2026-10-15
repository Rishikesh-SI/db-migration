-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_otp_details
-- Type: TABLE

-- Name: labbsc_otp_details; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_otp_details (
    email_id text,
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric
);


--
