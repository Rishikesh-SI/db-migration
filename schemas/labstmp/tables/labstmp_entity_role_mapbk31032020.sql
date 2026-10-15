-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstmp
-- Object: labstmp_entity_role_mapbk31032020
-- Type: TABLE

-- Name: labstmp_entity_role_mapbk31032020; Type: TABLE; Schema: labstmp; Owner: -
--

CREATE TABLE labstmp.labstmp_entity_role_mapbk31032020 (
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
