-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_venue_type
-- Type: TABLE

-- Name: zeven_venue_type; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_venue_type (
    zeven_venue_typeid numeric NOT NULL,
    venue_type character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
