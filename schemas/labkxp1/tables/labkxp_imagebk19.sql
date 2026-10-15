-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_imagebk19
-- Type: TABLE

-- Name: labkxp_imagebk19; Type: TABLE; Schema: labkxp1; Owner: -
--

CREATE TABLE labkxp1.labkxp_imagebk19 (
    image_id numeric,
    content_source_id numeric,
    image_caption character varying(2000),
    image_meta jsonb,
    image_desc text,
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
    asset_type_id numeric
);


--
