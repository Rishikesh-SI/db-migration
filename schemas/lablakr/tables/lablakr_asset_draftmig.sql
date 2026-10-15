-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablakr
-- Object: lablakr_asset_draftmig
-- Type: TABLE

-- Name: lablakr_asset_draftmig; Type: TABLE; Schema: lablakr; Owner: -
--

CREATE TABLE lablakr.lablakr_asset_draftmig (
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
