-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_cart_details_15012024
-- Type: TABLE

-- Name: labrr_product_cart_details_15012024; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_product_cart_details_15012024 (
    product_cart_details_id numeric,
    product_cart_id numeric,
    product_sku_id numeric,
    sku_code character varying,
    product_price numeric,
    quantity numeric,
    is_customize numeric,
    product_customize_map_id numeric,
    customize_text character varying,
    payment_info character varying,
    is_return numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    pcd_guid character varying,
    is_active numeric,
    is_deleted numeric,
    customize_price numeric,
    delivery_charges numeric,
    product_id numeric
);


--
