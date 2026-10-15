-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: zeven
-- Object: zeven_extensions
-- Type: TABLE

-- Name: zeven_extensions; Type: TABLE; Schema: zeven; Owner: -
--

CREATE TABLE zeven.zeven_extensions (
    extension_id numeric NOT NULL,
    name character varying(100) NOT NULL,
    type character varying(20) NOT NULL,
    element character varying(100) NOT NULL,
    folder character varying(100) NOT NULL,
    client_id numeric NOT NULL,
    enabled numeric NOT NULL,
    access_ numeric NOT NULL,
    protected numeric NOT NULL,
    manifest_cache text NOT NULL,
    params text NOT NULL,
    custom_data text NOT NULL,
    system_data text NOT NULL,
    checked_out numeric NOT NULL,
    checked_out_time timestamp without time zone NOT NULL,
    ordering numeric,
    state numeric,
    si_client_id numeric
);


--
