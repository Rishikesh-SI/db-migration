-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_otp_details
-- Type: TABLE

-- Name: labkc_otp_details; Type: TABLE; Schema: labkc; Owner: -
--

CREATE TABLE labkc.labkc_otp_details (
    mobile_no character varying(1000),
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric
);


--
