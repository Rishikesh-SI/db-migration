-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labadkr
-- Object: labadkr_cookies_data
-- Type: TABLE

-- Name: labadkr_cookies_data; Type: TABLE; Schema: labadkr; Owner: -
--

CREATE TABLE labadkr.labadkr_cookies_data (
    cookies_id numeric,
    ip_address character varying,
    created_date timestamp without time zone,
    privacy_version character varying(2000),
    terms_conditions_version character varying(2000),
    cookies_policy_version character varying(2000)
);


--
