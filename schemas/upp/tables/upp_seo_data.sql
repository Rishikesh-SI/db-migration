-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upp
-- Object: upp_seo_data
-- Type: TABLE

-- Name: upp_seo_data; Type: TABLE; Schema: upp; Owner: -
--

CREATE TABLE upp.upp_seo_data (
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
