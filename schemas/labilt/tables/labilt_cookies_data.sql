-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labilt
-- Object: labilt_cookies_data
-- Type: TABLE

-- Name: labilt_cookies_data; Type: TABLE; Schema: labilt; Owner: -
--

CREATE TABLE labilt.labilt_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
