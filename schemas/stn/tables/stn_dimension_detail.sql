-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_dimension_detail
-- Type: TABLE

-- Name: stn_dimension_detail; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_dimension_detail (
    dimension_detail_id numeric NOT NULL,
    dimension_id numeric,
    day_number numeric,
    day_name text,
    event_id numeric,
    event_name text,
    event_priority numeric,
    event_type numeric,
    is_day_locked numeric,
    day_unlock_date timestamp without time zone
);


--
