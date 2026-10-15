-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_purchase_order
-- Type: TABLE

-- Name: labbsc_purchase_order; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_purchase_order (
    order_id numeric NOT NULL,
    cart_id numeric,
    billing_details_json jsonb,
    is_ba_sa_same numeric,
    shipment_details_json jsonb,
    amount numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    send_email numeric,
    page_flag character varying(10),
    email_subject text
);


--
