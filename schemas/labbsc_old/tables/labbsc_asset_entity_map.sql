-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_asset_entity_map
-- Type: TABLE

-- Name: labbsc_asset_entity_map; Type: TABLE; Schema: labbsc_old; Owner: -
--

CREATE TABLE labbsc_old.labbsc_asset_entity_map (
    asset_entity_map_id numeric NOT NULL,
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
    aemap_guid character varying(256),
    is_required numeric
);


--
