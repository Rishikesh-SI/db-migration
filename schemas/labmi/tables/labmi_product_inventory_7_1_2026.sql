-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_inventory_7_1_2026
-- Type: TABLE

-- Name: labmi_product_inventory_7_1_2026; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_inventory_7_1_2026 (
    product_inventory_id numeric,
    inventory_method_id numeric,
    product_id numeric,
    product_sku_id numeric,
    stock_quantity numeric,
    inventory_json json,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    product_inventory_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
