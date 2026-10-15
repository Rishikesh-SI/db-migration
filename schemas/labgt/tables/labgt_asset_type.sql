-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_asset_type
-- Type: TABLE

-- Name: labgt_asset_type; Type: TABLE; Schema: labgt; Owner: -
--

CREATE TABLE labgt.labgt_asset_type (
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
    custom_meta_info jsonb,
    is_publish numeric,
    status numeric
);


--
