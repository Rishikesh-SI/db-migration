-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: cfc
-- Object: cfc_entity_group
-- Type: TABLE

-- Name: cfc_entity_group; Type: TABLE; Schema: cfc; Owner: -
--

CREATE TABLE cfc.cfc_entity_group (
    entity_group_id numeric NOT NULL,
    waf_entity_group_id numeric,
    client_id numeric,
    group_name character varying(300),
    group_desc character varying(2000),
    created_date timestamp without time zone,
    update_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric
);


--
