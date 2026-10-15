-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_template
-- Type: TABLE

-- Name: waf_template; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_template (
    template_id numeric NOT NULL,
    page_id numeric NOT NULL,
    template_name character varying(300),
    template_desc character varying(1000),
    layout_id numeric NOT NULL,
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
    template_html text
);


--
