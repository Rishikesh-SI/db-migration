-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtkrold
-- Object: labtkr_seo_data
-- Type: TABLE

-- Name: labtkr_seo_data; Type: TABLE; Schema: labtkrold; Owner: -
--

CREATE TABLE labtkrold.labtkr_seo_data (
    seo_data_id numeric NOT NULL,
    asset_id numeric,
    asset_type_id numeric,
    meta_info jsonb,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    seo_data_guid character varying(256)
);


--
