-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_entity_type
-- Type: TABLE

-- Name: tmmimg_upd_entity_type; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_entity_type (
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
    is_url numeric
);


--
