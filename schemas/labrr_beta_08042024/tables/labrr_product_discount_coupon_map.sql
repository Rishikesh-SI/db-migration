-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_discount_coupon_map
-- Type: TABLE

-- Name: labrr_product_discount_coupon_map; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_discount_coupon_map (
    product_discount_coupon_map_id numeric NOT NULL,
    discount_code character varying,
    user_guid character varying NOT NULL,
    used_date timestamp without time zone
);


--
