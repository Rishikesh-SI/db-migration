-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_discount_coupon
-- Type: TABLE

-- Name: labmi_v1_product_discount_coupon; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_discount_coupon (
    product_discount_coupon_id numeric NOT NULL,
    from_product_id numeric,
    to_product_id numeric,
    discount_name text,
    discount_percent numeric,
    is_active numeric,
    start_date timestamp without time zone,
    end_date timestamp without time zone,
    old_user numeric,
    discount_base_amt numeric,
    discount_gst_amt numeric,
    discount_personalised_gst_amt numeric,
    discount_personalised_base_amt numeric
);


--
