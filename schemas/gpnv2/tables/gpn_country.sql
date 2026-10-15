-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_country
-- Type: TABLE

-- Name: gpn_country; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_country (
    country_id numeric NOT NULL,
    country_name character varying(100),
    country_code character varying(10)
);


--
