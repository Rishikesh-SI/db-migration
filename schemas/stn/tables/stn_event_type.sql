-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_event_type
-- Type: TABLE

-- Name: stn_event_type; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_event_type (
    event_type_id numeric NOT NULL,
    event_type_name text,
    bonus_points numeric,
    base_units numeric,
    base_points numeric,
    time_limit text
);


--
