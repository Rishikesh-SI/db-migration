-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: spz
-- Object: spz_asset_type
-- Type: TABLE

-- Name: spz_asset_type; Type: TABLE; Schema: spz; Owner: -
--

CREATE TABLE spz.spz_asset_type (
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
    entity_role_id numeric
);


--
