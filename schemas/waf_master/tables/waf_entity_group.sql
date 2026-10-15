-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_entity_group
-- Type: TABLE

-- Name: waf_entity_group; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_entity_group (
    entity_group_id numeric NOT NULL,
    group_name character varying(300) NOT NULL,
    group_desc character varying(2000) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    update_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL
);


--
