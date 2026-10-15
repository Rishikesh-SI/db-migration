-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_states
-- Type: TABLE

-- Name: waf_states; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_states (
    state_id numeric NOT NULL,
    name text,
    country_id numeric,
    is_active_v1 numeric
);


--
