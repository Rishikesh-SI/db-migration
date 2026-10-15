-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_sku_09022024
-- Type: TABLE

-- Name: labmi_v1_product_sku_09022024; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_sku_09022024 (
    product_sku_id numeric,
    product_id numeric,
    sku_code character varying,
    attribute_specification_ids numeric[],
    product_price numeric,
    is_customize numeric,
    sku_json json,
    sku_guid character varying,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
