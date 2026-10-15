-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_entity_image_map
-- Type: TABLE

-- Name: labpkl_entity_image_map; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_entity_image_map (
    entity_image_map_id numeric NOT NULL,
    resolution_id numeric,
    entity_master_id numeric,
    image character varying(4000),
    priority numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric
);


--
