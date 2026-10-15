-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpcm
-- Object: labpcm_entity_role_map
-- Type: TABLE

-- Name: labpcm_entity_role_map; Type: TABLE; Schema: labpcm; Owner: -
--

CREATE TABLE labpcm.labpcm_entity_role_map (
    entity_role_map_id numeric NOT NULL,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric
);


--
