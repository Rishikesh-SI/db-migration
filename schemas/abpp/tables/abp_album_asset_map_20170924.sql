-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_album_asset_map_20170924
-- Type: TABLE

-- Name: abp_album_asset_map_20170924; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_album_asset_map_20170924 (
    album_asset_map_id numeric,
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
