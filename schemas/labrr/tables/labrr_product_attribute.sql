-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_attribute
-- Type: TABLE

-- Name: labrr_product_attribute; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_product_attribute (
    product_attribute_id numeric NOT NULL,
    attribute_name character varying,
    description text,
    product_attribute_json json,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    attribute_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
