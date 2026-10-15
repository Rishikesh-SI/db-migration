-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_gallery_resolution_map
-- Type: TABLE

-- Name: labmi_gallery_resolution_map; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_gallery_resolution_map (
    gallery_resolution_map_id numeric NOT NULL,
    gallery_id numeric NOT NULL,
    gallery_type numeric NOT NULL,
    file_name character varying(100) NOT NULL,
    file_path character varying(500) NOT NULL,
    grm_guid character varying(256),
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL
);


--
