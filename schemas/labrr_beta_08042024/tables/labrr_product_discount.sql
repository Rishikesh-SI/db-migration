-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_discount
-- Type: TABLE

-- Name: labrr_product_discount; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_discount (
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
