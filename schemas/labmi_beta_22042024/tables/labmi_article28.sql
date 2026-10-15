-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_article28
-- Type: TABLE

-- Name: labmi_article28; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_article28 (
    article_id numeric,
    content_source_id numeric,
    asset_meta jsonb,
    title character varying(4000),
    title_alias character varying(4000),
    browser_title character varying(4000),
    highlights jsonb,
    content_source character varying(1000),
    place character varying(1000),
    country character varying(1000),
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
