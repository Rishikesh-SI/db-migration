-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_download_master
-- Type: TABLE

-- Name: labhsl_download_master; Type: TABLE; Schema: labhsl; Owner: -
--

CREATE TABLE labhsl.labhsl_download_master (
    download_master_id numeric,
    title text,
    description text,
    is_cover numeric,
    image_id numeric,
    image_path text,
    image_name text,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    published_date timestamp without time zone,
    download_guid text,
    version_number numeric,
    created_by numeric,
    updated_by numeric
);


--
