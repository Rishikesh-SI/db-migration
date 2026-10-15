-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_cart
-- Type: TABLE

-- Name: dd_product_cart; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_cart (
    product_cart_id numeric,
    user_id numeric,
    user_emailid character varying(500),
    user_cart_guid character varying,
    is_login_user numeric NOT NULL,
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
    cart_json jsonb
);


--
