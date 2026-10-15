-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_inventory
-- Type: TABLE

-- Name: labrr_product_inventory; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_inventory (
    product_inventory_id numeric NOT NULL,
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
