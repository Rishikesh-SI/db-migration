-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_update_sites
-- Type: TABLE

-- Name: zeven_update_sites; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_update_sites (
    update_site_id numeric NOT NULL,
    name character varying(100),
    type character varying(20),
    location text NOT NULL,
    enabled numeric,
    last_check_timestamp numeric,
    si_client_id numeric
);


--
