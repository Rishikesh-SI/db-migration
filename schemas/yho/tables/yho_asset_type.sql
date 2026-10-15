-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_asset_type
-- Type: TABLE

-- Name: yho_asset_type; Type: TABLE; Schema: yho; Owner: -
--

CREATE TABLE yho.yho_asset_type (
    asset_type_id numeric NOT NULL,
    title character varying(500),
    asset_desc character varying(1000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    asset_type_guid character varying(256) NOT NULL,
    entity_role_id numeric
);


--
