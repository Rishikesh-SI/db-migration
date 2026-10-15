-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: fanxp_wf
-- Object: labwf_image
-- Type: TABLE

-- Name: labwf_image; Type: TABLE; Schema: fanxp_wf; Owner: -
--

CREATE TABLE fanxp_wf.labwf_image (
    image_id numeric NOT NULL,
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
    asset_type_id numeric,
    image_ratio text,
    image_size text,
    image_height text,
    image_width text
);


--
