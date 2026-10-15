-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_cart_details
-- Type: TABLE

-- Name: dd_product_cart_details; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_cart_details (
    product_cart_details_id numeric NOT NULL,
    product_cart_id numeric NOT NULL,
    product_sku_id numeric NOT NULL,
    sku_code character varying,
    product_price numeric NOT NULL,
    quantity numeric NOT NULL,
    is_customize numeric NOT NULL,
    product_customize_map_id numeric,
    customize_text character varying,
    payment_info character varying,
    is_return numeric,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    pcd_guid character varying NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    customize_price numeric,
    delivery_charges numeric,
    product_id numeric
);


--
