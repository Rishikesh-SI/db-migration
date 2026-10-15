-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_entity_map_19042017
-- Type: TABLE

-- Name: swa_asset_entity_map_19042017; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_asset_entity_map_19042017 (
    asset_entity_map_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    entity_role_map_id numeric,
    is_linkable numeric,
    is_visible numeric,
    priority numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    aemap_guid character varying(256)
);


--
