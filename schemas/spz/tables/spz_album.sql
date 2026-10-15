-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_album
-- Type: TABLE

-- Name: spz_album; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_album (
    album_id numeric NOT NULL,
    content_source_id numeric,
    album_meta jsonb,
    album_type numeric,
    title character varying(4000),
    title_alias character varying(4000),
    short_title character varying(2000),
    album_desc character varying(4000),
    partner_id numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    cover_image character varying(4000),
    total_assets numeric,
    published_version_number numeric,
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    album_guid character varying(256),
    published_date timestamp without time zone,
    show_copyright numeric,
    content_source_link character varying(4000),
    order_number numeric,
    slug_url character varying(4000),
    checked_out_by numeric,
    checked_out_date timestamp without time zone
);


--
