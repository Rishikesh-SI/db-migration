-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_locale_master
-- Type: TABLE

-- Name: zeven_locale_master; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_locale_master (
    locale_master_id numeric NOT NULL,
    shortname character varying(100) NOT NULL,
    longname character varying(500),
    created_date timestamp(0) without time zone,
    updated_date timestamp(0) without time zone,
    created_by numeric,
    updated_by numeric
);


--
