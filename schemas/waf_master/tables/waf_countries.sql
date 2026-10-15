-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_countries
-- Type: TABLE

-- Name: waf_countries; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_countries (
    country_id numeric NOT NULL,
    short_name text,
    name text,
    phone_code numeric
);


--
