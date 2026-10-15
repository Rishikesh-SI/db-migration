-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_list_detail
-- Type: TABLE

-- Name: yho_asset_list_detail; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_asset_list_detail (
    asset_list_det_id numeric,
    assset_list_id numeric,
    asset_type_id numeric,
    web_listing_json jsonb,
    published_date timestamp without time zone,
    entity_id numeric[],
    asset_id numeric,
    ent_col integer[]
);


--
