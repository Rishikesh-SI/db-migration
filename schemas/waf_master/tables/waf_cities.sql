-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_cities
-- Type: TABLE

-- Name: waf_cities; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_cities (
    city_id numeric NOT NULL,
    name text,
    state_id numeric
);


--
