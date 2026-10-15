-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lablsg_v1
-- Object: lablsg_v1_seo_data
-- Type: TABLE

-- Name: lablsg_v1_seo_data; Type: TABLE; Schema: lablsg_v1; Owner: -
--

CREATE TABLE lablsg_v1.lablsg_v1_seo_data (
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
