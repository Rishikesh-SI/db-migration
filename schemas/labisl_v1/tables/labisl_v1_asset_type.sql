-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labisl_v1
-- Object: labisl_v1_asset_type
-- Type: TABLE

-- Name: labisl_v1_asset_type; Type: TABLE; Schema: labisl_v1; Owner: -
--

CREATE TABLE labisl_v1.labisl_v1_asset_type (
    asset_type_id numeric NOT NULL,
    title character varying(500),
    asset_desc character varying(1000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    asset_type_guid character varying(256),
    entity_role_id numeric,
    is_content_type numeric,
    component_id numeric,
    status numeric,
    custom_meta_info jsonb,
    is_publish numeric
);


--
