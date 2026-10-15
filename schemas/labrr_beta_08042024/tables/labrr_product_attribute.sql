-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_attribute
-- Type: TABLE

-- Name: labrr_product_attribute; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_attribute (
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
