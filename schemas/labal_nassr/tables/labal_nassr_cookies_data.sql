-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labal_nassr
-- Object: labal_nassr_cookies_data
-- Type: TABLE

-- Name: labal_nassr_cookies_data; Type: TABLE; Schema: labal_nassr; Owner: -
--

CREATE TABLE labal_nassr.labal_nassr_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
