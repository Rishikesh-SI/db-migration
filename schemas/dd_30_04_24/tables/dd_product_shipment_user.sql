-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: dd_30_04_24
-- Object: dd_product_shipment_user
-- Type: TABLE

-- Name: dd_product_shipment_user; Type: TABLE; Schema: dd_30_04_24; Owner: -
--

CREATE TABLE dd_30_04_24.dd_product_shipment_user (
    product_shipment_user_id numeric NOT NULL,
    product_cart_id numeric NOT NULL,
    shipment_name character varying(200) NOT NULL,
    shipment_address1 character varying(200) NOT NULL,
    shipment_address2 character varying(200),
    shipment_state character varying(200) NOT NULL,
    shipment_city character varying(200) NOT NULL,
    shipment_pincode character varying(10) NOT NULL,
    shipment_mobile_no character varying(20) NOT NULL,
    is_shipment_billing_address_same numeric NOT NULL,
    billing_name character varying(200) NOT NULL,
    billing_address1 character varying(200) NOT NULL,
    billing_address2 character varying(200),
    billing_state character varying(200) NOT NULL,
    billing_city character varying(200) NOT NULL,
    billing_pincode character varying(10) NOT NULL,
    billing_mobile_no character varying(20) NOT NULL,
    promocode character varying(10),
    bill_amount numeric NOT NULL,
    fees numeric,
    taxes numeric,
    deductions numeric,
    total_amount numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    shipment_guid character varying(256) NOT NULL,
    billing_user_emailid character varying(200),
    billing_country character varying(200),
    shipping_country character varying(200),
    order_tracking_status text,
    order_tracking_id text,
    ord_tracking_status_value numeric
);


--
