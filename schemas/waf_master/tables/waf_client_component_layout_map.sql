-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: waf_master
-- Object: waf_client_component_layout_map
-- Type: TABLE

-- Name: waf_client_component_layout_map; Type: TABLE; Schema: waf_master; Owner: -
--

CREATE TABLE waf_master.waf_client_component_layout_map (
    client_component_layout_map_id numeric NOT NULL,
    client_id numeric NOT NULL,
    component_layout_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    cclmap_guid character varying(256) NOT NULL
);


--
