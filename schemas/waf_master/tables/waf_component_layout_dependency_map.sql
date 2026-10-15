-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_component_layout_dependency_map
-- Type: TABLE

-- Name: waf_component_layout_dependency_map; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_component_layout_dependency_map (
    component_layout_dependency_map_id numeric NOT NULL,
    component_layout_id numeric NOT NULL,
    child_component_layout_id numeric NOT NULL,
    order_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    cldmap_guid character varying(256),
    meta_info jsonb,
    child_comp text,
    child_position text,
    child_responsive numeric
);


--
