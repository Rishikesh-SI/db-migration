-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_dynamic_content_asset_map
-- Type: TABLE

-- Name: labrr_dynamic_content_asset_map; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_dynamic_content_asset_map (
    dynamic_content_asset_map_id numeric NOT NULL,
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
    aamap_guid character varying(256),
    is_cover numeric
);


--
