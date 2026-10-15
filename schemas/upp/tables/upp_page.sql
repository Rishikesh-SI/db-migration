-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_page
-- Type: TABLE

-- Name: upp_page; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_page (
    page_id numeric NOT NULL,
    alias character varying(300) NOT NULL,
    title character varying(300),
    page_level numeric NOT NULL,
    upfront numeric NOT NULL,
    upfront_app numeric NOT NULL,
    upfront_mobile numeric NOT NULL,
    is_wrapper numeric NOT NULL,
    parent_id numeric,
    visible numeric NOT NULL,
    visible_app numeric NOT NULL,
    visible_mobile numeric NOT NULL,
    scheduled_publish timestamp without time zone,
    scheduled_unpublish timestamp without time zone,
    ordering numeric NOT NULL,
    title_mobile character varying(300),
    title_app character varying(300),
    is_redirect numeric NOT NULL,
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    page_guid character varying(256) NOT NULL,
    asset_type_id numeric,
    breadcrumbs character varying(100),
    is_custom_menu numeric,
    is_amp numeric
);


--
