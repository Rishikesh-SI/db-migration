-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_entity_role_map_08112017
-- Type: TABLE

-- Name: isl_entity_role_map_08112017; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_entity_role_map_08112017 (
    entity_role_map_id numeric,
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
