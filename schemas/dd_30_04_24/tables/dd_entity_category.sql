-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_entity_category
-- Type: TABLE

-- Name: dd_entity_category; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_entity_category (
    entity_category_id numeric NOT NULL,
    entity_role_id numeric,
    category_name character varying(500),
    category_desc character varying(2000),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric,
    published_date timestamp without time zone,
    asset_guid character varying(256)
);


--
