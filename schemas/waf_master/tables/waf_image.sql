-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_image
-- Type: TABLE

-- Name: waf_image; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_image (
    image_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    image_caption character varying(2000),
    image_meta jsonb,
    image_desc character varying(2000),
    image_path character varying(2000),
    copyright_text character varying(2000),
    image_file_name character varying(2000),
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    image_guid character varying(256) NOT NULL
);


--
