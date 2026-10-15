-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_updates
-- Type: TABLE

-- Name: zeven_updates; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_updates (
    update_id numeric NOT NULL,
    update_site_id numeric,
    extension_id numeric,
    cateryid numeric,
    name character varying(100),
    description text,
    element character varying(100),
    type character varying(20),
    folder character varying(20),
    client_id numeric,
    version character varying(10),
    data text,
    detailsurl text,
    si_client_id numeric
);


--
