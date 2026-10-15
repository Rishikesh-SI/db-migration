-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: labpkl_v1_entity_role_map_bakv1
-- Type: TABLE

-- Name: labpkl_v1_entity_role_map_bakv1; Type: TABLE; Schema: labpkl_v1; Owner: -
--

CREATE TABLE labpkl_v1.labpkl_v1_entity_role_map_bakv1 (
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
