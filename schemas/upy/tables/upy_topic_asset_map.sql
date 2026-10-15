-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_topic_asset_map
-- Type: TABLE

-- Name: upy_topic_asset_map; Type: TABLE; Schema: upy; Owner: -
--

CREATE TABLE upy.upy_topic_asset_map (
    topic_asset_map_id numeric NOT NULL,
    topic_id numeric,
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
    is_cover numeric,
    tamap_guid character varying(256)
);


--
