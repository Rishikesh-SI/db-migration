-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_video
-- Type: TABLE

-- Name: abp_video; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_video (
    video_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    title text,
    title_alias text,
    short_title text,
    video_meta jsonb,
    video_desc text,
    duration text,
    partner_id numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric NOT NULL,
    video_url text,
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    video_guid character varying(256) NOT NULL,
    published_date timestamp without time zone,
    show_copyright numeric,
    content_source_link text,
    order_number numeric,
    image_id numeric,
    slug_url text,
    checked_out_by numeric,
    checked_out_date timestamp without time zone,
    hls_url text
);


--
