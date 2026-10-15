-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_content_provider
-- Type: TABLE

-- Name: labos_content_provider; Type: TABLE; Schema: labos; Owner: -
--

CREATE TABLE labos.labos_content_provider (
    content_provider_id numeric NOT NULL,
    content_provider_name character varying(256),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    content_provider_display_name character varying(300),
    content_provider_desc character varying(3000),
    is_published numeric,
    content_provider_guid character varying(256),
    copyright_text character varying(4000),
    logo character varying(500),
    link character varying(500)
);


--
