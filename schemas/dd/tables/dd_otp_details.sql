-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_otp_details
-- Type: TABLE

-- Name: dd_otp_details; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_otp_details (
    email_id text,
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric
);


--
