-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_draft
-- Type: TABLE

-- Name: swa_asset_draft; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_asset_draft (
    asset_draft_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    version_number numeric NOT NULL,
    asset_data jsonb NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    asset_draft_guid character varying(256) NOT NULL
);


--
