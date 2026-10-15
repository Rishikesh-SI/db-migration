-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_template_component_asset_map
-- Type: TABLE

-- Name: yho_template_component_asset_map; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_template_component_asset_map (
    template_component_asset_map_id numeric NOT NULL,
    template_component_map_id numeric NOT NULL,
    asset_order numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_meta jsonb,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric NOT NULL,
    is_trashed numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    asset_guid character varying(256),
    asset_json jsonb
);


--
