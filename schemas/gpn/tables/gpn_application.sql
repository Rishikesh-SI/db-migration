-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn
-- Object: gpn_application
-- Type: TABLE

-- Name: gpn_application; Type: TABLE; Schema: gpn; Owner: -
--

CREATE TABLE gpn.gpn_application (
    application_id numeric NOT NULL,
    application_name character varying(100) NOT NULL,
    application_code character varying(20) NOT NULL,
    application_password character varying(100),
    application_stage character varying(20) NOT NULL,
    file_path character varying(500),
    platform_id numeric NOT NULL,
    os_version character varying(10),
    application_arn character varying(500),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
