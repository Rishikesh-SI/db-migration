-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_article
-- Type: TABLE

-- Name: waf_article; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_article (
    article_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    asset_meta jsonb,
    slug_title character varying(4000),
    title_alias character varying(4000),
    browser_title character varying(4000),
    short_headline character varying(1000),
    content_source character varying(1000),
    place character varying(1000),
    country character varying(1000),
    show_in_app numeric NOT NULL,
    disclaimer_text text,
    checked_out_by numeric,
    full_text text NOT NULL,
    intro_text text NOT NULL,
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    is_trashed numeric NOT NULL,
    article_guid character varying(256) NOT NULL,
    published_date timestamp without time zone,
    slug_url character varying(4000)
);


--
