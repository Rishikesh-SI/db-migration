-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_dimension
-- Type: TABLE

-- Name: stn_dimension; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_dimension (
    dimension_id numeric NOT NULL,
    dimension_name text,
    points numeric,
    is_locked numeric,
    dimension_unlock_date timestamp without time zone
);


--
