-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_hero_rating_asset_map_19042017
-- Type: TABLE

-- Name: swa_hero_rating_asset_map_19042017; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_hero_rating_asset_map_19042017 (
    hero_rating_asset_map_id numeric,
    hero_rating_id numeric,
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
    asset_guid character varying(256),
    is_cover numeric,
    language_id numeric
);


--
