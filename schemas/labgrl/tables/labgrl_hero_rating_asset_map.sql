-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_hero_rating_asset_map
-- Type: TABLE

-- Name: labgrl_hero_rating_asset_map; Type: TABLE; Schema: labgrl; Owner: -
--

CREATE TABLE labgrl.labgrl_hero_rating_asset_map (
    hero_rating_asset_map_id numeric NOT NULL,
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
