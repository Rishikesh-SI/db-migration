-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_page_20180620
-- Type: TABLE

-- Name: tmmimg_upd_page_20180620; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_page_20180620 (
    page_id numeric,
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
    asset_type_id numeric
);


--
