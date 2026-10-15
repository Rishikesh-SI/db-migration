-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labecn_v1
-- Object: labecn_v1_article_asset_map_11092024
-- Type: TABLE

-- Name: labecn_v1_article_asset_map_11092024; Type: TABLE; Schema: labecn_v1; Owner: -
--

CREATE TABLE labecn_v1.labecn_v1_article_asset_map_11092024 (
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
