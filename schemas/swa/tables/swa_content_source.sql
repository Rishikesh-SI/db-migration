-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_content_source
-- Type: TABLE

-- Name: swa_content_source; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_content_source (
    content_source_id numeric NOT NULL,
    source_name character varying(300) NOT NULL,
    source_display_name character varying(300) NOT NULL,
    source_desc character varying(3000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    content_source_guid character varying(256) NOT NULL,
    copyright_text character varying(4000)
);


--
