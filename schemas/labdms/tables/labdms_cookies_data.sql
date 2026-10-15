-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdms
-- Object: labdms_cookies_data
-- Type: TABLE

-- Name: labdms_cookies_data; Type: TABLE; Schema: labdms; Owner: -
--

CREATE TABLE labdms.labdms_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
