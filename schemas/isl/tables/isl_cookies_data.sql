-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_cookies_data
-- Type: TABLE

-- Name: isl_cookies_data; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_cookies_data (
    cookies_id numeric,
    ip_address character varying(2000),
    created_date timestamp without time zone
);


--
