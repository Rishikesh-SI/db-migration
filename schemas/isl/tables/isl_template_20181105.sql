-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_template_20181105
-- Type: TABLE

-- Name: isl_template_20181105; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_template_20181105 (
    template_id numeric,
    page_id numeric,
    template_name character varying(300),
    template_desc character varying(1000),
    layout_id numeric,
    is_inherited numeric,
    parent_id numeric,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    template_guid character varying(256),
    is_master numeric,
    template_html text,
    is_responsive numeric,
    mobile_html text,
    use_default_bg_color numeric,
    use_default_bg_image numeric,
    bg_color character varying(256),
    bg_image_id numeric
);


--
