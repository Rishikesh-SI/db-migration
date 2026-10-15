-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_migration_asset_log_temp
-- Type: TABLE

-- Name: labisp_migration_asset_log_temp; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_migration_asset_log_temp (
    asset_id numeric,
    asset_type_id numeric,
    asset_slug text,
    image_count numeric,
    has_featured_image numeric,
    is_asset_saved numeric,
    error_if_any text,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
