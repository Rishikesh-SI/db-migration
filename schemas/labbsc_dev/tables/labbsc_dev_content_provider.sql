-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_content_provider
-- Type: TABLE

-- Name: labbsc_dev_content_provider; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_content_provider (
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
    copyright_text character varying(4000)
);


--
