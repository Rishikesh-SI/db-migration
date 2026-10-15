-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_template_component_asset_map
-- Type: TABLE

-- Name: dd_template_component_asset_map; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_template_component_asset_map (
    template_component_asset_map_id numeric NOT NULL,
    template_component_map_id numeric,
    asset_order numeric,
    asset_id numeric,
    asset_type_id numeric,
    asset_meta jsonb,
    show_in_web numeric,
    show_in_mobile numeric,
    show_in_app numeric,
    published_version_number numeric,
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
    asset_json jsonb
);


--
