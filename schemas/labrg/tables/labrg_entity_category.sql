-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_entity_category
-- Type: TABLE

-- Name: labrg_entity_category; Type: TABLE; Schema: labrg; Owner: -
--

CREATE TABLE labrg.labrg_entity_category (
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
