-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt01_v1
-- Object: labgt01_v1_otp_details
-- Type: TABLE

-- Name: labgt01_v1_otp_details; Type: TABLE; Schema: labgt01_v1; Owner: -
--

CREATE TABLE labgt01_v1.labgt01_v1_otp_details (
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
    request_ip character varying,
    country_code numeric,
    client_code character varying,
    is_used numeric,
    updated_date timestamp without time zone,
    mobile_no_cc character varying
);


--
