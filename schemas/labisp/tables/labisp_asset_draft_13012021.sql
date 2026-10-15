-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisp
-- Object: labisp_asset_draft_13012021
-- Type: TABLE

-- Name: labisp_asset_draft_13012021; Type: TABLE; Schema: labisp; Owner: -
--

CREATE TABLE labisp.labisp_asset_draft_13012021 (
    asset_draft_id numeric,
    asset_id numeric,
    asset_type_id numeric,
    version_number numeric,
    asset_data jsonb,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    asset_draft_guid character varying(256)
);


--
