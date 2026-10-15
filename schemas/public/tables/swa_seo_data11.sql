-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: swa_seo_data11
-- Type: TABLE

-- Name: swa_seo_data11; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.swa_seo_data11 (
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
