-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_entity_role_08112017
-- Type: TABLE

-- Name: isl_entity_role_08112017; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_entity_role_08112017 (
    entity_role_id numeric,
    entity_type_id numeric,
    entity_group_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
