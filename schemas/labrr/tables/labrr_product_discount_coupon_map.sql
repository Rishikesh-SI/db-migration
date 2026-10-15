-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_product_discount_coupon_map
-- Type: TABLE

-- Name: labrr_product_discount_coupon_map; Type: TABLE; Schema: labrr; Owner: -
--

CREATE TABLE labrr.labrr_product_discount_coupon_map (
    product_discount_coupon_map_id numeric NOT NULL,
    discount_code character varying,
    user_guid character varying NOT NULL,
    used_date timestamp without time zone,
    product_code character varying
);


--
