-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_discount_coupon_7_1_2016
-- Type: TABLE

-- Name: labmi_product_discount_coupon_7_1_2016; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_discount_coupon_7_1_2016 (
    product_discount_coupon_id numeric,
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
