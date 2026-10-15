-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_topic_asset_map_15mar2017del
-- Type: TABLE

-- Name: swa_topic_asset_map_15mar2017del; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_topic_asset_map_15mar2017del (
    topic_asset_map_id numeric,
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
