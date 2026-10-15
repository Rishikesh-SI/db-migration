-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_country
-- Type: TABLE

-- Name: zeven_country; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_country (
    countryid numeric NOT NULL,
    country_name character varying(100) NOT NULL,
    country_short_code character varying(5),
    continent character varying(20),
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
