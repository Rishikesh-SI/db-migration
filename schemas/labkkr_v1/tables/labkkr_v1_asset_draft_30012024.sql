-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_v1
-- Object: labkkr_v1_asset_draft_30012024
-- Type: TABLE

-- Name: labkkr_v1_asset_draft_30012024; Type: TABLE; Schema: labkkr_v1; Owner: -
--

CREATE TABLE labkkr_v1.labkkr_v1_asset_draft_30012024 (
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
