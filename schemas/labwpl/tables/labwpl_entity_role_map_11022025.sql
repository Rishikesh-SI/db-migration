-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_entity_role_map_11022025
-- Type: TABLE

-- Name: labwpl_entity_role_map_11022025; Type: TABLE; Schema: labwpl; Owner: -
--

CREATE TABLE labwpl.labwpl_entity_role_map_11022025 (
    entity_role_map_id numeric,
    entity_role_id numeric,
    entity_master_id numeric,
    priority numeric,
    is_active numeric,
    source_object_id character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    hyperlink numeric,
    tour_id numeric
);


--
