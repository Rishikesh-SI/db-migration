-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_imagebk03122019
-- Type: TABLE

-- Name: labyho_imagebk03122019; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_imagebk03122019 (
    image_id numeric,
    content_source_id numeric,
    image_caption text,
    image_meta jsonb,
    image_desc text,
    image_path character varying(2000),
    copyright_text text,
    image_file_name character varying(2000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    image_guid character varying(256),
    show_copyright numeric,
    content_source_link character varying(4000),
    order_number numeric,
    title_alias character varying(1000),
    asset_type_id numeric,
    image_ratio text,
    image_size text,
    image_height text,
    image_width text
);


--
