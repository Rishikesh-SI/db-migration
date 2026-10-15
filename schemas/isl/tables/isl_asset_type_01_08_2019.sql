-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_asset_type_01_08_2019
-- Type: TABLE

-- Name: isl_asset_type_01_08_2019; Type: TABLE; Schema: isl; Owner: -
--

CREATE TABLE isl.isl_asset_type_01_08_2019 (
    asset_type_id numeric,
    title character varying(500),
    asset_desc character varying(1000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    asset_type_guid character varying(256),
    entity_role_id numeric
);


--
