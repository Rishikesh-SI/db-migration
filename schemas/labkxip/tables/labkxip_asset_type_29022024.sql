-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_asset_type_29022024
-- Type: TABLE

-- Name: labkxip_asset_type_29022024; Type: TABLE; Schema: labkxip; Owner: -
--

CREATE TABLE labkxip.labkxip_asset_type_29022024 (
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
