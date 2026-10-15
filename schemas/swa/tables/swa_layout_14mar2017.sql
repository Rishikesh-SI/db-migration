-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_layout_14mar2017
-- Type: TABLE

-- Name: swa_layout_14mar2017; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_layout_14mar2017 (
    layout_id numeric,
    layout_html text,
    layout_name character varying(500),
    layout_desc character varying(1000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    layout_guid character varying(256),
    is_master numeric,
    master_template_id numeric
);


--
