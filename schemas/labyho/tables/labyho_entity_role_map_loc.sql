-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_entity_role_map_loc
-- Type: TABLE

-- Name: labyho_entity_role_map_loc; Type: TABLE; Schema: labyho; Owner: -
--

CREATE TABLE labyho.labyho_entity_role_map_loc (
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
