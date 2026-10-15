-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gpn_v2
-- Object: gpn_application
-- Type: TABLE

-- Name: gpn_application; Type: TABLE; Schema: gpn_v2; Owner: -
--

CREATE TABLE gpn_v2.gpn_application (
    application_id numeric,
    application_name text,
    environment character varying(20),
    platform character varying(10),
    application_arn text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
