-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd
-- Object: dd_product_cart_paydetails
-- Type: TABLE

-- Name: dd_product_cart_paydetails; Type: TABLE; Schema: dd; Owner: -
--

CREATE TABLE dd.dd_product_cart_paydetails (
    product_cart_paydetails_id numeric NOT NULL,
    product_cart_id numeric,
    tracking_id numeric,
    bank_ref_no character varying(500),
    order_status character varying(50),
    failure_message text,
    payment_mode character varying(500),
    card_name character varying(500),
    status_code character varying(50),
    status_message text,
    amount numeric,
    payment_json jsonb,
    transaction_date timestamp without time zone,
    payment_guid character varying(500),
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    created_by numeric,
    updated_by numeric,
    is_active numeric,
    is_deleted numeric,
    favcy_responce_status numeric,
    favcy_responce_status_json jsonb,
    is_status_flag numeric
);


--
