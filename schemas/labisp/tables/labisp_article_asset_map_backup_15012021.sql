-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_article_asset_map_backup_15012021
-- Type: TABLE

-- Name: labisp_article_asset_map_backup_15012021; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_article_asset_map_backup_15012021 (
    article_asset_map_id numeric,
    article_id numeric,
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
