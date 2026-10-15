-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_content_source
-- Type: TABLE

-- Name: labdv_content_source; Type: TABLE; Schema: labdv; Owner: -
--

CREATE TABLE labdv.labdv_content_source (
    content_source_id numeric NOT NULL,
    source_name character varying(300),
    source_display_name character varying(300),
    source_desc character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    content_source_guid character varying(256),
    copyright_text character varying(4000)
);


--
