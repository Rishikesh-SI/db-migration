-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi
-- Object: labmi_product_discount_19082021
-- Type: TABLE

-- Name: labmi_product_discount_19082021; Type: TABLE; Schema: labmi; Owner: -
--

CREATE TABLE labmi.labmi_product_discount_19082021 (
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
