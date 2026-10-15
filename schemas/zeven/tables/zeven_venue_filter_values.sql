-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_venue_filter_values
-- Type: TABLE

-- Name: zeven_venue_filter_values; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_venue_filter_values (
    zeven_venue_filter_valuesid numeric NOT NULL,
    venue_masterid character varying(500) NOT NULL,
    zeven_filter_masterid character varying(500) NOT NULL,
    venue_filter_value character varying(1000),
    is_deleted numeric,
    is_published numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
