-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_article_consolidated_data
-- Type: TABLE

-- Name: isl_article_consolidated_data; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_article_consolidated_data (
    title character varying(4000),
    title_alias character varying(4000),
    browser_title character varying(4000),
    highlights jsonb,
    full_text text,
    intro_text text,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_published numeric,
    is_trashed numeric,
    published_date timestamp without time zone,
    content_source_link character varying(4000),
    short_title character varying(2000),
    entities text,
    primary_entity character varying(3000),
    secondary_entity character varying(3000),
    language_entity character varying(3000),
    seo_meta_desc text,
    seo_focus_key text,
    seo_custom_meta text,
    seo_meta_fields text,
    seo_keywords text,
    seo_meta_robots text,
    seo_canonical_url text,
    authors text,
    short_desc character varying(4000),
    tags character varying(4000),
    image_path text,
    image_file_name character varying(2000),
    url text,
    focus_entities text,
    article_id numeric
);


--
