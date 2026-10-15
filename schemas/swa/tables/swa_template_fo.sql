-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_template_fo
-- Type: TABLE

-- Name: swa_template_fo; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_template_fo (
    template_id bigint,
    template_name text,
    template_desc text,
    layout_id numeric,
    is_inherited numeric,
    parent_id integer,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    template_guid uuid,
    is_master numeric,
    template_html text
);


--
