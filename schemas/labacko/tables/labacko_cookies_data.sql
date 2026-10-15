-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labacko
-- Object: labacko_cookies_data
-- Type: TABLE

-- Name: labacko_cookies_data; Type: TABLE; Schema: labacko; Owner: -
--

CREATE TABLE labacko.labacko_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
