-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_template_component_map_20180620
-- Type: TABLE

-- Name: tmmimg_upd_template_component_map_20180620; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_template_component_map_20180620 (
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
    parent_container_id character varying(256),
    parent_tcmap_id numeric,
    meta_info jsonb,
    menu_id numeric
);


--
