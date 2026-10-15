-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_gallery_resolution_map
-- Type: TABLE

-- Name: labmi_v1_gallery_resolution_map; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_gallery_resolution_map (
    gallery_resolution_map_id numeric NOT NULL,
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
