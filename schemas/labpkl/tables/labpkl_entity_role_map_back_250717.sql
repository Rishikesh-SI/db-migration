-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_entity_role_map_back_250717
-- Type: TABLE

-- Name: labpkl_entity_role_map_back_250717; Type: TABLE; Schema: labpkl; Owner: -
--

CREATE TABLE labpkl.labpkl_entity_role_map_back_250717 (
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
