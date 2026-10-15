-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_cart_archive_01022024
-- Type: TABLE

-- Name: labmi_v1_product_cart_archive_01022024; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_cart_archive_01022024 (
    product_cart_id numeric,
    user_id numeric,
    user_emailid character varying(500),
    user_cart_guid character varying,
    is_login_user numeric,
    total_select_product numeric,
    total_price numeric,
    delivery_charges numeric,
    payment_gateway_reference_no character varying(500),
    payment_gateway_cancel_url character varying(4000),
    payment_gateway_redirect_url character varying(4000),
    payment_status numeric,
    transaction_date timestamp without time zone,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    cart_json jsonb,
    user_guid character varying(1000),
    product_id numeric,
    expiry_date timestamp without time zone,
    membership_owner text,
    name_on_card text,
    whatsapp_consent numeric,
    discount_percent numeric
);


--
