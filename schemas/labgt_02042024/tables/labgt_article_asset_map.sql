-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt_02042024
-- Object: labgt_article_asset_map
-- Type: TABLE

-- Name: labgt_article_asset_map; Type: TABLE; Schema: labgt_02042024; Owner: -
--

CREATE TABLE labgt_02042024.labgt_article_asset_map (
    article_asset_map_id numeric NOT NULL,
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
