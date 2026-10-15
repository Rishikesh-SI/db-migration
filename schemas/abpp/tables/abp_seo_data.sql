-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_seo_data
-- Type: TABLE

-- Name: abp_seo_data; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_seo_data (
    seo_data_id numeric NOT NULL,
    asset_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    meta_info jsonb,
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    seo_data_guid character varying(256) NOT NULL
);


--
