-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_product_discount_01022024
-- Type: TABLE

-- Name: labmi_product_discount_01022024; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_product_discount_01022024 (
    from_product_id numeric,
    to_product_id numeric,
    discount numeric,
    is_active numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    old_user numeric,
    base_amt numeric,
    gst_amt numeric,
    personalised_base_amt numeric,
    personalised_gst_amt numeric
);


--
