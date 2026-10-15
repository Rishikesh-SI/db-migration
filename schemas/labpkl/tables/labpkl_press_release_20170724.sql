-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_press_release_20170724
-- Type: TABLE

-- Name: labpkl_press_release_20170724; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_press_release_20170724 (
    press_release_id numeric,
    title character varying(4000),
    short_title character varying(4000),
    image_id numeric,
    image_zip_path character varying(4000),
    image_zip_name character varying(2000),
    image_zip_file_name character varying(2000),
    image_zip_size character varying(2000),
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    press_release_date timestamp without time zone,
    published_date timestamp without time zone,
    is_trashed numeric,
    press_release_guid character varying(256),
    image_name character varying(1024),
    image_path character varying(1024)
);


--
