-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr_beta_08042024
-- Object: labrr_product_cart_archive
-- Type: TABLE

-- Name: labrr_product_cart_archive; Type: TABLE; Schema: labrr_beta_08042024; Owner: -
--

CREATE TABLE labrr_beta_08042024.labrr_product_cart_archive (
    product_cart_id numeric NOT NULL,
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
    discount_percent numeric,
    personalised_name character varying,
    personalised_number numeric,
    is_personalised numeric,
    donation_cause character varying
);


--
