-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_layout
-- Type: TABLE

-- Name: swa_layout; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_layout (
    layout_id numeric NOT NULL,
    layout_html text NOT NULL,
    layout_name character varying(500),
    layout_desc character varying(1000),
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    layout_guid character varying(256) NOT NULL,
    is_master numeric,
    master_template_id numeric,
    image_file_name text,
    image_path text
);


--
