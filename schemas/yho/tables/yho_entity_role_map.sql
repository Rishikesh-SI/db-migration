-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_entity_role_map
-- Type: TABLE

-- Name: yho_entity_role_map; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_entity_role_map (
    entity_role_map_id numeric NOT NULL,
    entity_role_id numeric NOT NULL,
    entity_master_id numeric NOT NULL,
    priority numeric NOT NULL,
    is_active numeric NOT NULL,
    source_object_id character varying(3000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    hyperlink numeric
);


--
