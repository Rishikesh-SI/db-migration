-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_video_02082019
-- Type: TABLE

-- Name: labpkl_v1_video_02082019; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_video_02082019 (
    video_id numeric,
    content_source_id numeric,
    title character varying(4000),
    title_alias character varying(4000),
    short_title character varying(2000),
    video_meta jsonb,
    video_desc character varying(1000),
    duration character varying(1000),
    partner_id numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric,
    video_url character varying(4000),
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    video_guid character varying(256),
    published_date timestamp without time zone,
    show_copyright numeric,
    content_source_link character varying(4000),
    order_number numeric,
    image_id numeric,
    slug_url character varying(4000),
    checked_out_by numeric,
    checked_out_date timestamp without time zone,
    video_views numeric,
    hls_url character varying(4000),
    azure_id numeric
);


--
