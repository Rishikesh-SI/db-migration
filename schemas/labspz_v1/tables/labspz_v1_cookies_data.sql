-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labspz_v1
-- Object: labspz_v1_cookies_data
-- Type: TABLE

-- Name: labspz_v1_cookies_data; Type: TABLE; Schema: labspz_v1; Owner: -
--

CREATE TABLE labspz_v1.labspz_v1_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
