-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_entity_role_map_22062017
-- Type: TABLE

-- Name: swa_entity_role_map_22062017; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_entity_role_map_22062017 (
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
