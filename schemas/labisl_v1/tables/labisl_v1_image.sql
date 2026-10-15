-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_image
-- Type: TABLE

-- Name: labisl_v1_image; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_image (
    image_id numeric NOT NULL,
    content_source_id numeric,
    image_caption character varying(2000),
    image_meta jsonb,
    image_desc character varying(2000),
    image_path character varying(2000),
    copyright_text character varying(2000),
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
    file_type_id numeric,
    is_displayed numeric,
    asset_type_id numeric
);


--
