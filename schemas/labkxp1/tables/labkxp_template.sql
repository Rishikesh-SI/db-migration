-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxp1
-- Object: labkxp_template
-- Type: TABLE

-- Name: labkxp_template; Type: TABLE; Schema: labkxp1; Owner: -
--

CREATE TABLE labkxp1.labkxp_template (
    template_id numeric NOT NULL,
    page_id numeric NOT NULL,
    template_name character varying(300),
    template_desc character varying(1000),
    layout_id numeric,
    is_inherited numeric NOT NULL,
    parent_id numeric,
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    template_guid character varying(256) NOT NULL,
    is_master numeric,
    template_html text,
    is_responsive numeric,
    mobile_html text,
    use_default_bg_color numeric,
    use_default_bg_image numeric,
    bg_color character varying,
    bg_image_id numeric
);


--
