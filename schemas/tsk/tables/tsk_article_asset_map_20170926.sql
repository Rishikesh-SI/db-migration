-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tsk
-- Object: tsk_article_asset_map_20170926
-- Type: TABLE

-- Name: tsk_article_asset_map_20170926; Type: TABLE; Schema: tsk; Owner: -
--

CREATE TABLE tsk.tsk_article_asset_map_20170926 (
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
