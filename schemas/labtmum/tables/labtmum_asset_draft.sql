-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtmum
-- Object: labtmum_asset_draft
-- Type: TABLE

-- Name: labtmum_asset_draft; Type: TABLE; Schema: labtmum; Owner: -
--

CREATE TABLE labtmum.labtmum_asset_draft (
    asset_draft_id numeric NOT NULL,
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
