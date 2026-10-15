-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_entity_type
-- Type: TABLE

-- Name: dd_entity_type; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_entity_type (
    entity_type_id numeric NOT NULL,
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
