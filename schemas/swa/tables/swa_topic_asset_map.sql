-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_topic_asset_map
-- Type: TABLE

-- Name: swa_topic_asset_map; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_topic_asset_map (
    topic_asset_map_id numeric NOT NULL,
    topic_id numeric NOT NULL,
    asset_order numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    is_cover numeric,
    tamap_guid character varying(256)
);


--
