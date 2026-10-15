-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_entity_image_map
-- Type: TABLE

-- Name: abp_entity_image_map; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_entity_image_map (
    entity_image_map_id numeric NOT NULL,
    resolution_id numeric NOT NULL,
    entity_master_id numeric NOT NULL,
    image character varying(4000),
    priority numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
