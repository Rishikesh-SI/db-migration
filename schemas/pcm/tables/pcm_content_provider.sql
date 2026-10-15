-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_content_provider
-- Type: TABLE

-- Name: pcm_content_provider; Type: TABLE; Schema: pcm; Owner: -
--

CREATE TABLE pcm.pcm_content_provider (
    content_provider_id numeric NOT NULL,
    content_provider_name character varying(256) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    content_provider_display_name character varying(300) NOT NULL,
    content_provider_desc character varying(3000),
    is_published numeric NOT NULL,
    content_provider_guid character varying(256) NOT NULL,
    copyright_text character varying(4000)
);


--
