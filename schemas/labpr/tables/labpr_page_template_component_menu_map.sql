-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: labpr_page_template_component_menu_map
-- Type: TABLE

-- Name: labpr_page_template_component_menu_map; Type: TABLE; Schema: labpr; Owner: -
--

CREATE TABLE labpr.labpr_page_template_component_menu_map (
    page_template_component_menu_map_id numeric NOT NULL,
    page_id numeric,
    template_component_map_id numeric,
    menu_id numeric,
    is_trashed numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    asset_guid character varying(256),
    template_id numeric
);


--
