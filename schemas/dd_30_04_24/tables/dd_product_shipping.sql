-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_shipping
-- Type: TABLE

-- Name: dd_product_shipping; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_shipping (
    product_shipping_id numeric NOT NULL,
    product_id numeric NOT NULL,
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
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone,
    created_by numeric NOT NULL,
    updated_by numeric,
    product_shipping_guid character varying(100) NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    is_published numeric NOT NULL
);


--
