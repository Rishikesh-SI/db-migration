-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_entity_role_map_21082017
-- Type: TABLE

-- Name: abp_entity_role_map_21082017; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_entity_role_map_21082017 (
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
