-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_city_master
-- Type: TABLE

-- Name: stn_city_master; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_city_master (
    city_id numeric NOT NULL,
    city_name text,
    city_short_code text,
    state_id numeric
);


--
