-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_template_component_mapbk06062018
-- Type: TABLE

-- Name: swa_template_component_mapbk06062018; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_template_component_mapbk06062018 (
    template_component_map_id numeric,
    template_id numeric,
    component_id numeric,
    title character varying(500),
    display_title character varying(500),
    title_mobile character varying(500),
    title_app character varying(500),
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    fetch_from numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    tcmap_guid character varying(256),
    parent_tcmap_id numeric,
    meta_info jsonb,
    parent_container_id character varying(256),
    menu_id numeric,
    layout_info jsonb
);


--
