-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: siwaf
-- Object: siwaf_records_static_otp
-- Type: TABLE

-- Name: siwaf_records_static_otp; Type: TABLE; Schema: siwaf; Owner: -
--

CREATE TABLE siwaf.siwaf_records_static_otp (
    mobile_no character varying(1000) NOT NULL,
    otp numeric,
    client_name character varying,
    is_active numeric,
    first_login numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    phone_code numeric
);


--
