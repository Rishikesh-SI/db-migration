-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_image
-- Type: TABLE

-- Name: yho_image; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_image (
    image_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    image_caption text,
    image_meta jsonb,
    image_desc text,
    image_path text,
    copyright_text text,
    image_file_name text,
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    image_guid character varying(256) NOT NULL,
    show_copyright numeric,
    content_source_link character varying(4000),
    order_number numeric,
    title_alias character varying(1000)
);


--
