-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_lsg
-- Object: lablsg_cookies_data
-- Type: TABLE

-- Name: lablsg_cookies_data; Type: TABLE; Schema: fanxp_lsg; Owner: -
--

CREATE TABLE fanxp_lsg.lablsg_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
