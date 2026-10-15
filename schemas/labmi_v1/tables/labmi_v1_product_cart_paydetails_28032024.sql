-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_cart_paydetails_28032024
-- Type: TABLE

-- Name: labmi_v1_product_cart_paydetails_28032024; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_cart_paydetails_28032024 (
    product_cart_paydetails_id numeric,
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
    is_status_flag numeric,
    user_guid character varying(1000),
    response_count numeric,
    invoice_id character varying(50),
    is_mail_sent numeric,
    customer_note text,
    note_status numeric,
    note_updated_by numeric,
    note_updated_date timestamp without time zone,
    refund_reason text
);


--
