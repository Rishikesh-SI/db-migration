-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtri
-- Object: labtri_dynamic_content_asset_map
-- Type: TABLE

-- Name: labtri_dynamic_content_asset_map; Type: TABLE; Schema: labtri; Owner: -
--

CREATE TABLE labtri.labtri_dynamic_content_asset_map (
    dynamic_content_asset_map_id numeric,
    dynamic_content_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    aamap_guid character varying,
    is_cover numeric
);


--
