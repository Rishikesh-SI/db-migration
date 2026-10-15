-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr
-- Object: labkkr_otp_details_13032023
-- Type: TABLE

-- Name: labkkr_otp_details_13032023; Type: TABLE; Schema: labkkr; Owner: -
--

CREATE TABLE labkkr.labkkr_otp_details_13032023 (
    mobile_no character varying(1000),
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric,
    user_guid character varying,
    type numeric,
    opt numeric,
    failed_attempt numeric,
    is_app numeric
);


--
