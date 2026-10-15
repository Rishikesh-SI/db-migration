-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr_01082024
-- Object: labgmr_layout
-- Type: TABLE

-- Name: labgmr_layout; Type: TABLE; Schema: labgmr_01082024; Owner: -
--

CREATE TABLE labgmr_01082024.labgmr_layout (
    layout_id numeric NOT NULL,
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
    master_template_id numeric,
    image_file_name character varying(2000),
    image_path character varying(4000)
);


--
