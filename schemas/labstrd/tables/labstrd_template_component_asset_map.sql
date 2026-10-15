-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labstrd
-- Object: labstrd_template_component_asset_map
-- Type: TABLE

-- Name: labstrd_template_component_asset_map; Type: TABLE; Schema: labstrd; Owner: -
--

CREATE TABLE labstrd.labstrd_template_component_asset_map (
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
    asset_guid character varying(256)
);


--
