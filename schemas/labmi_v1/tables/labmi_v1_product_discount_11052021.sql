-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_discount_11052021
-- Type: TABLE

-- Name: labmi_v1_product_discount_11052021; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_discount_11052021 (
    from_product_id numeric,
    to_product_id numeric,
    discount numeric,
    is_active numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    old_user numeric,
    base_amt numeric,
    gst_amt numeric
);


--
