-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_asset_entity_map
-- Type: TABLE

-- Name: utt_asset_entity_map; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_asset_entity_map (
    asset_entity_map_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    entity_role_map_id numeric NOT NULL,
    is_linkable numeric NOT NULL,
    is_visible numeric NOT NULL,
    priority numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    aemap_guid character varying(256) NOT NULL,
    is_required numeric
);


--
