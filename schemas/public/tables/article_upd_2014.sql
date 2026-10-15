-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: article_upd_2014
-- Type: TABLE

-- Name: article_upd_2014; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.article_upd_2014 (
    article_id numeric NOT NULL,
    content_source_id numeric NOT NULL,
    asset_meta jsonb,
    title character varying(4000),
    title_alias character varying(4000),
    browser_title character varying(4000),
    highlights jsonb,
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
    show_copyright numeric,
    show_in_web numeric,
    show_in_mobile numeric,
    content_source_link character varying(4000),
    order_number numeric,
    slug_url character varying(4000),
    checked_out_date timestamp without time zone,
    short_title character varying(2000),
    is_live_blog numeric,
    expiry_date timestamp without time zone,
    year text
);


--
