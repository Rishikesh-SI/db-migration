-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_cookies_data
-- Type: TABLE

-- Name: labpkl_cookies_data; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
