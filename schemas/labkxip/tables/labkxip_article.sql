-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_article
-- Type: TABLE

-- Name: labkxip_article; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_article (
    article_id numeric NOT NULL,
    content_source_id numeric,
    asset_meta jsonb,
    title character varying(4000),
    title_alias character varying(4000),
    browser_title character varying(4000),
    highlights jsonb,
    content_source character varying,
    place character varying,
    country character varying,
    show_in_app numeric,
    disclaimer_text text,
    checked_out_by numeric,
    full_text text,
    intro_text text,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_trashed numeric,
    article_guid character varying(256),
    published_date timestamp without time zone,
    show_copyright numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    content_source_link character varying(4000),
    order_number numeric,
    slug_url character varying(4000),
    checked_out_date timestamp without time zone,
    short_title character varying(2000)
);


--
