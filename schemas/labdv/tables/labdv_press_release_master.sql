-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdv
-- Object: labdv_press_release_master
-- Type: TABLE

-- Name: labdv_press_release_master; Type: TABLE; Schema: labdv; Owner: -
--

CREATE TABLE labdv.labdv_press_release_master (
    press_release_id numeric,
    title character varying(2000),
    status numeric,
    published_date timestamp without time zone,
    guid text,
    version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    image_id numeric,
    is_cover numeric,
    image_name character varying(2000),
    image_path character varying(2000),
    press_release_json jsonb,
    zip_id numeric,
    zip_name text,
    zip_path text,
    zip_size text,
    is_trashed numeric,
    tagged_entity integer[]
);


--
