-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdsp
-- Object: labdsp_content_providerbk
-- Type: TABLE

-- Name: labdsp_content_providerbk; Type: TABLE; Schema: labdsp; Owner: -
--

CREATE TABLE labdsp.labdsp_content_providerbk (
    content_provider_id numeric,
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
