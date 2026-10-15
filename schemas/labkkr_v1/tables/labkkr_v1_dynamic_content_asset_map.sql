-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_dynamic_content_asset_map
-- Type: TABLE

-- Name: labkkr_v1_dynamic_content_asset_map; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_dynamic_content_asset_map (
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
