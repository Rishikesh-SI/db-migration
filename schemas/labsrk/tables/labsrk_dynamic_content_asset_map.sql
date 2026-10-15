-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsrk
-- Object: labsrk_dynamic_content_asset_map
-- Type: TABLE

-- Name: labsrk_dynamic_content_asset_map; Type: TABLE; Schema: labsrk; Owner: -
--

CREATE TABLE labsrk.labsrk_dynamic_content_asset_map (
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
