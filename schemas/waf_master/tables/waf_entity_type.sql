-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_entity_type
-- Type: TABLE

-- Name: waf_entity_type; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_entity_type (
    entity_type_id numeric NOT NULL,
    entity_type_name character varying(1500) NOT NULL,
    entity_type_desc character varying(3000) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    entity_type_identifier character varying(1500),
    search_priority numeric,
    entity_url_type numeric
);


--
