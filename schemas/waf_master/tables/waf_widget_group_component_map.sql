-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_widget_group_component_map
-- Type: TABLE

-- Name: waf_widget_group_component_map; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_widget_group_component_map (
    widget_group_component_map_id numeric NOT NULL,
    widget_group_id numeric NOT NULL,
    component_id numeric NOT NULL,
    order_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    wgcmap_guid character varying(256)
);


--
