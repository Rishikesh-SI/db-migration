-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_dynamic_content_type_data
-- Type: TABLE

-- Name: labrr_dynamic_content_type_data; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_dynamic_content_type_data (
    dynamic_content_type_data_id numeric NOT NULL,
    title character varying(4000),
    title_alias character varying(4000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    published_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    ct_guid character varying(256),
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    is_trashed numeric,
    published_version_number numeric,
    asset_meta jsonb,
    content_type_id numeric
);


--
