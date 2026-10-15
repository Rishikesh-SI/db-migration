-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_city
-- Type: TABLE

-- Name: zeven_city; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_city (
    cityid numeric NOT NULL,
    city_name character varying(100) NOT NULL,
    city_short_code character varying(5),
    stateid numeric NOT NULL,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
