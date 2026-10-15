-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_album_asset_map
-- Type: TABLE

-- Name: isl_album_asset_map; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_album_asset_map (
    album_asset_map_id numeric NOT NULL,
    album_id numeric,
    asset_order numeric,
    asset_id numeric,
    asset_type_id numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_cover numeric
);


--
