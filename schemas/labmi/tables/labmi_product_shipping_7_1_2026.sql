-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_shipping_7_1_2026
-- Type: TABLE

-- Name: labmi_product_shipping_7_1_2026; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_shipping_7_1_2026 (
    product_shipping_id numeric,
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
