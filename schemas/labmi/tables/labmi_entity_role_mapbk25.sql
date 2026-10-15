-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_entity_role_mapbk25
-- Type: TABLE

-- Name: labmi_entity_role_mapbk25; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_entity_role_mapbk25 (
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
