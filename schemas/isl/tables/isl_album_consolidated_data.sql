-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_album_consolidated_data
-- Type: TABLE

-- Name: isl_album_consolidated_data; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_album_consolidated_data (
    title character varying(4000),
    title_alias character varying(4000),
    album_desc character varying(1000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_published numeric,
    is_trashed numeric,
    published_date timestamp without time zone,
    entities text,
    primary_entity character varying(3000),
    secondary_entity character varying(3000),
    language_entity character varying(3000),
    seo_browser_title text,
    seo_meta_desc text,
    seo_keywords text,
    seo_focus_key text,
    seo_custom_meta text,
    seo_canonical_url text,
    authors text,
    cover_image character varying(4000),
    total_assets numeric,
    url text,
    focus_entities text,
    other_images text,
    album_id numeric
);


--
