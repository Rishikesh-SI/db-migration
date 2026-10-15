-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_page_template_component_menu_map
-- Type: TABLE

-- Name: yho_page_template_component_menu_map; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_page_template_component_menu_map (
    page_template_component_menu_map_id numeric NOT NULL,
    page_id numeric NOT NULL,
    template_component_map_id numeric NOT NULL,
    menu_id numeric NOT NULL,
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    asset_guid character varying(256)
);


--
