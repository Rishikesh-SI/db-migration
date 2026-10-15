-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_album
-- Type: TABLE

-- Name: waf_album; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_album (
    album_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    album_meta jsonb,
    album_type numeric,
    title character varying(4000),
    title_alias character varying(4000),
    short_title character varying(2000),
    album_desc character varying(1000),
    partner_id numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    cover_image character varying(4000),
    total_assets numeric,
    published_version_number numeric NOT NULL,
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    album_guid character varying(256) NOT NULL,
    published_date timestamp without time zone,
    slug_url character varying(4000)
);


--
