-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_state_master
-- Type: TABLE

-- Name: stn_state_master; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_state_master (
    state_id numeric NOT NULL,
    state_name text,
    state_short_code text,
    region_id numeric
);


--
