-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_asset_draft
-- Type: TABLE

-- Name: labmi_asset_draft; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_asset_draft (
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
