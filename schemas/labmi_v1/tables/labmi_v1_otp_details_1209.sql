-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_otp_details_1209
-- Type: TABLE

-- Name: labmi_v1_otp_details_1209; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_otp_details_1209 (
    mobile_no character varying(1000),
    otp numeric,
    created_date timestamp without time zone,
    expiry_date timestamp without time zone,
    is_verified numeric,
    type numeric,
    user_guid character varying(1000),
    is_app numeric,
    failed_attempt numeric
);


--
