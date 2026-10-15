-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc
-- Object: labkc_cookies_data
-- Type: TABLE

-- Name: labkc_cookies_data; Type: TABLE; Schema: labkc; Owner: -
--

CREATE TABLE labkc.labkc_cookies_data (
    cookies_id numeric,
    ip_address character varying,
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
