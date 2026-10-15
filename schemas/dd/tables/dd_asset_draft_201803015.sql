-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_asset_draft_201803015
-- Type: TABLE

-- Name: dd_asset_draft_201803015; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_asset_draft_201803015 (
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
