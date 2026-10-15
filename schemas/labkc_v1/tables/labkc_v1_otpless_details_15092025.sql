-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_otpless_details_15092025
-- Type: TABLE

-- Name: labkc_v1_otpless_details_15092025; Type: TABLE; Schema: labkc_v1; Owner: -
--

CREATE TABLE labkc_v1.labkc_v1_otpless_details_15092025 (
    mobile_no character varying,
    created_date timestamp without time zone,
    client_code character varying,
    unique_id character varying,
    country_code numeric
);


--
