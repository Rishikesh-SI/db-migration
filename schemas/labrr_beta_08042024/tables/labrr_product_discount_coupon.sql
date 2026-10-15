-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_discount_coupon
-- Type: TABLE

-- Name: labrr_product_discount_coupon; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_discount_coupon (
    discount_code character varying(256),
    discount_type character varying(256),
    discount numeric,
    is_used numeric,
    is_active numeric,
    expiry_date timestamp without time zone,
    is_percent numeric,
    "desc" character varying,
    created_date timestamp without time zone,
    product_code character varying
);


--
