-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_otp_details
-- Type: TABLE

-- Name: labrr_otp_details; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_otp_details (
    mobile_no character varying(1000),
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric,
    type numeric,
    user_guid character varying(1000),
    is_app numeric,
    failed_attempt numeric,
    opt numeric,
    client_code character varying,
    country_code character varying,
    request_ip character varying,
    mobile_no_cc character varying(50)
);


--
