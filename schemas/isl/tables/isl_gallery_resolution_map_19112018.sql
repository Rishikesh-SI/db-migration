-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_gallery_resolution_map_19112018
-- Type: TABLE

-- Name: isl_gallery_resolution_map_19112018; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_gallery_resolution_map_19112018 (
    gallery_resolution_map_id numeric,
    gallery_id numeric,
    gallery_type numeric,
    file_name character varying(100),
    file_path character varying(500),
    grm_guid character varying(256),
    is_active numeric,
    is_deleted numeric,
    created_by numeric,
    updated_by numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
