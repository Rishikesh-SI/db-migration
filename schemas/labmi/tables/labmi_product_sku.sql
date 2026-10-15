-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_sku
-- Type: TABLE

-- Name: labmi_product_sku; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_sku (
    product_sku_id numeric NOT NULL,
    product_id numeric NOT NULL,
    sku_code character varying,
    attribute_specification_ids numeric[] NOT NULL,
    product_price numeric NOT NULL,
    is_customize numeric NOT NULL,
    sku_json json NOT NULL,
    sku_guid character varying NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
