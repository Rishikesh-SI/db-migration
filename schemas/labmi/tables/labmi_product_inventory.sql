-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_inventory
-- Type: TABLE

-- Name: labmi_product_inventory; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_inventory (
    product_inventory_id numeric NOT NULL,
    inventory_method_id numeric,
    product_id numeric NOT NULL,
    product_sku_id numeric,
    stock_quantity numeric NOT NULL,
    inventory_json json,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    product_inventory_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
