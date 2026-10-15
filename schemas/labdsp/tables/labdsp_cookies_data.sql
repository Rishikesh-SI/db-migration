-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_cookies_data
-- Type: TABLE

-- Name: labdsp_cookies_data; Type: TABLE; Schema: labdsp; Owner: -
--

CREATE TABLE labdsp.labdsp_cookies_data (
    cookies_id numeric,
    ip_alabdspress character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
