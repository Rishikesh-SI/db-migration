-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tmmimg_upd
-- Object: tmmimg_upd_asset_type_meta
-- Type: TABLE

-- Name: tmmimg_upd_asset_type_meta; Type: TABLE; Schema: tmmimg_upd; Owner: -
--

CREATE TABLE tmmimg_upd.tmmimg_upd_asset_type_meta (
    asset_type_meta_id numeric NOT NULL,
    asset_type_id numeric,
    asset_label character varying(500),
    asset_name character varying(500),
    allow_multiple numeric,
    asset_options text,
    include_in_search numeric,
    published_version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    asset_type_meta_guid character varying(256)
);


--
