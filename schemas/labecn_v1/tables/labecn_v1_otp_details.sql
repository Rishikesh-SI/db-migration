-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_otp_details
-- Type: TABLE

-- Name: labecn_v1_otp_details; Type: TABLE; Schema: labecn_v1; Owner: -
--

CREATE TABLE labecn_v1.labecn_v1_otp_details (
    mobile_no character varying(1000),
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric,
    type numeric,
    user_guid character varying(1000),
    is_app numeric,
    failed_attempt numeric,
    opt numeric
);


--
