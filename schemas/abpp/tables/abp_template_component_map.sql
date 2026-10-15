-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_template_component_map
-- Type: TABLE

-- Name: abp_template_component_map; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_template_component_map (
    template_component_map_id numeric NOT NULL,
    template_id numeric NOT NULL,
    component_id numeric NOT NULL,
    title character varying(500),
    display_title character varying(500),
    title_mobile character varying(500),
    title_app character varying(500),
    show_in_web numeric NOT NULL,
    show_in_mobile numeric NOT NULL,
    show_in_app numeric NOT NULL,
    fetch_from numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    tcmap_guid character varying(256) NOT NULL,
    parent_container_id character varying(256),
    parent_tcmap_id numeric,
    meta_info jsonb,
    menu_id numeric
);


--
