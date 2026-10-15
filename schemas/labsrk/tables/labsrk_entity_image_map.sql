-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_entity_image_map
-- Type: TABLE

-- Name: labsrk_entity_image_map; Type: TABLE; Schema: labsrk; Owner: -
--

CREATE TABLE labsrk.labsrk_entity_image_map (
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
