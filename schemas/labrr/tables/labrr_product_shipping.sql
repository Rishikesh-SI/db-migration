-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_shipping
-- Type: TABLE

-- Name: labrr_product_shipping; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_product_shipping (
    product_shipping_id numeric NOT NULL,
    product_id numeric,
    weight numeric,
    length numeric,
    width numeric,
    height numeric,
    is_shipping_enabled numeric,
    is_free_shipping numeric,
    is_ship_separated numeric,
    additional_shipping_charges numeric,
    delivery_date timestamp without time zone,
    shipping_json json,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    product_shipping_guid character varying(100),
    is_active numeric,
    is_deleted numeric,
    is_published numeric
);


--
