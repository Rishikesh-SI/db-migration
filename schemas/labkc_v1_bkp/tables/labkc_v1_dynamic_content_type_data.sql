-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1_bkp
-- Object: labkc_v1_dynamic_content_type_data
-- Type: TABLE

-- Name: labkc_v1_dynamic_content_type_data; Type: TABLE; Schema: labkc_v1_bkp; Owner: -
--

CREATE TABLE labkc_v1_bkp.labkc_v1_dynamic_content_type_data (
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
