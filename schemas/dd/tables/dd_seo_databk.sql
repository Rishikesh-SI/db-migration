-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_seo_databk
-- Type: TABLE

-- Name: dd_seo_databk; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_seo_databk (
    seo_data_id numeric,
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
