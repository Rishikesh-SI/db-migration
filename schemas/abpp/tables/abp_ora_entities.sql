-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_ora_entities
-- Type: TABLE

-- Name: abp_ora_entities; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_ora_entities (
    entity_name character varying(2000),
    entity_type_sport_map_id numeric,
    entity_type_name character varying(200),
    source_object_id character varying(500)
);


--
