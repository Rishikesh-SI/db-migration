-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: pcm
-- Object: pcm_asset_draft_20170802
-- Type: TABLE

-- Name: pcm_asset_draft_20170802; Type: TABLE; Schema: pcm; Owner: -
--

CREATE TABLE pcm.pcm_asset_draft_20170802 (
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
