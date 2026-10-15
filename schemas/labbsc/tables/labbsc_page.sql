-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_page
-- Type: TABLE

-- Name: labbsc_page; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_page (
    page_id numeric NOT NULL,
    alias character varying(300),
    title character varying(300),
    page_level numeric,
    upfront numeric,
    upfront_app numeric,
    upfront_mobile numeric,
    is_wrapper numeric,
    parent_id numeric,
    visible numeric,
    visible_app numeric,
    visible_mobile numeric,
    scheduled_publish timestamp without time zone,
    scheduled_unpublish timestamp without time zone,
    ordering numeric,
    title_mobile character varying(300),
    title_app character varying(300),
    is_redirect numeric,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    page_guid character varying(256),
    asset_type_id numeric,
    breadcrumbs character varying(100),
    is_custom_menu numeric,
    is_amp numeric,
    show_in_sitemap numeric,
    meta_info jsonb
);


--
