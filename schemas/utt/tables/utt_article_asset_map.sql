-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: utt
-- Object: utt_article_asset_map
-- Type: TABLE

-- Name: utt_article_asset_map; Type: TABLE; Schema: utt; Owner: -
--

CREATE TABLE utt.utt_article_asset_map (
    article_asset_map_id numeric NOT NULL,
    article_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    aamap_guid character varying(256) NOT NULL,
    is_cover numeric
);


--
