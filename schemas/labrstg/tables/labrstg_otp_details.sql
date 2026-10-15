-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_otp_details
-- Type: TABLE

-- Name: labrstg_otp_details; Type: TABLE; Schema: labrstg; Owner: -
--

CREATE TABLE labrstg.labrstg_otp_details (
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
