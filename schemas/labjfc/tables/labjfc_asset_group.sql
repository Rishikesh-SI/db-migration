-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_asset_group
-- Type: TABLE

-- Name: labjfc_asset_group; Type: TABLE; Schema: labjfc; Owner: -
--

CREATE TABLE labjfc.labjfc_asset_group (
    asset_group_id numeric NOT NULL,
    asset_type_id numeric,
    canonical_url character varying(4000),
    asset_group_text text,
    title character varying(500),
    asset_group_desc character varying(1000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    asset_group_guid character varying(256)
);


--
