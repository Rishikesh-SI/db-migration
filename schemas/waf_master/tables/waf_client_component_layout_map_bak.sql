-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_component_layout_map_bak
-- Type: TABLE

-- Name: waf_client_component_layout_map_bak; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_client_component_layout_map_bak (
    client_component_layout_map_id numeric,
    client_id numeric,
    component_layout_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    cclmap_guid character varying(256)
);


--
