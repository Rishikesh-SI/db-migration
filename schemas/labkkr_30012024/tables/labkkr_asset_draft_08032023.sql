-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkkr_30012024
-- Object: labkkr_asset_draft_08032023
-- Type: TABLE

-- Name: labkkr_asset_draft_08032023; Type: TABLE; Schema: labkkr_30012024; Owner: -
--

CREATE TABLE labkkr_30012024.labkkr_asset_draft_08032023 (
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
