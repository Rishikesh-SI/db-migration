-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: abpp
-- Object: abp_asset_type_meta
-- Type: TABLE

-- Name: abp_asset_type_meta; Type: TABLE; Schema: abpp; Owner: -
--

CREATE TABLE abpp.abp_asset_type_meta (
    asset_type_meta_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    asset_label character varying(500),
    asset_name character varying(500),
    allow_multiple numeric NOT NULL,
    asset_options text,
    include_in_search numeric NOT NULL,
    published_version_number numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    asset_type_meta_guid character varying(256) NOT NULL
);


--
