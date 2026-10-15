-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_asset_group
-- Type: TABLE

-- Name: swa_asset_group; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_asset_group (
    asset_group_id numeric NOT NULL,
    asset_type_id numeric NOT NULL,
    canonical_url character varying(4000),
    asset_group_text text,
    title character varying(500),
    asset_group_desc character varying(1000),
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    asset_group_guid character varying(256) NOT NULL
);


--
