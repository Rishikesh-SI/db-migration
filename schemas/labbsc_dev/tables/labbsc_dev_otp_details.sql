-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_otp_details
-- Type: TABLE

-- Name: labbsc_dev_otp_details; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_otp_details (
    email_id text,
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric
);


--
