-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_component_layout_dependency_map_bak
-- Type: TABLE

-- Name: waf_component_layout_dependency_map_bak; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_component_layout_dependency_map_bak (
    component_layout_dependency_map_id numeric,
    component_layout_id numeric,
    child_component_layout_id numeric,
    order_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    cldmap_guid character varying(256),
    meta_info jsonb,
    child_comp text,
    child_position text,
    child_responsive numeric
);


--
