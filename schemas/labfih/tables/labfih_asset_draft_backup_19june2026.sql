-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfih
-- Object: labfih_asset_draft_backup_19june2026
-- Type: TABLE

-- Name: labfih_asset_draft_backup_19june2026; Type: TABLE; Schema: labfih; Owner: -
--

CREATE TABLE labfih.labfih_asset_draft_backup_19june2026 (
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
