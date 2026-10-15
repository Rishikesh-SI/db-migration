-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_entity_type
-- Type: TABLE

-- Name: labgfg_entity_type; Type: TABLE; Schema: labgfg; Owner: -
--

CREATE TABLE labgfg.labgfg_entity_type (
    entity_type_id numeric,
    waf_entity_type_id numeric,
    client_id numeric,
    entity_type_name character varying(1500),
    entity_type_desc character varying(3000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    entity_type_identifier character varying(1500),
    search_priority numeric,
    is_child numeric,
    entity_url_type numeric
);


--
