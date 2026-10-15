-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_entity_category
-- Type: TABLE

-- Name: swa_entity_category; Type: TABLE; Schema: swa; Owner: -
--

CREATE TABLE swa.swa_entity_category (
    entity_category_id numeric NOT NULL,
    entity_role_id numeric NOT NULL,
    category_name character varying(500) NOT NULL,
    category_desc character varying(2000) NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    created_by numeric NOT NULL,
    updated_by numeric NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL,
    published_date timestamp without time zone,
    asset_guid character varying(256)
);


--
