-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpnv2
-- Object: gpn_application
-- Type: TABLE

-- Name: gpn_application; Type: TABLE; Schema: gpnv2; Owner: -
--

CREATE TABLE gpnv2.gpn_application (
    application_id numeric NOT NULL,
    application_name character varying(100) NOT NULL,
    application_arn character varying(500) NOT NULL,
    environment_id numeric NOT NULL,
    platform_id numeric NOT NULL,
    client_id numeric NOT NULL,
    app_version character varying(5) DEFAULT '0'::character varying NOT NULL
);


--
