-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_beta_22042024
-- Object: labmi_product_shipment_user
-- Type: TABLE

-- Name: labmi_product_shipment_user; Type: TABLE; Schema: labmi_beta_22042024; Owner: -
--

CREATE TABLE labmi_beta_22042024.labmi_product_shipment_user (
    product_shipment_user_id numeric NOT NULL,
    product_cart_id numeric NOT NULL,
    shipment_name character varying(200) NOT NULL,
    shipment_address1 character varying NOT NULL,
    shipment_address2 character varying,
    shipment_state character varying(200),
    shipment_city character varying(200),
    shipment_pincode character varying(100) NOT NULL,
    shipment_mobile_no character varying(200) NOT NULL,
    is_shipment_billing_address_same numeric NOT NULL,
    billing_name character varying(200) NOT NULL,
    billing_address1 character varying NOT NULL,
    billing_address2 character varying(200),
    billing_state character varying(200),
    billing_city character varying(200),
    billing_pincode character varying(100) NOT NULL,
    billing_mobile_no character varying(200) NOT NULL,
    promocode character varying(100),
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
    ord_tracking_status_value numeric,
    shipment_state_id numeric,
    shipment_city_id numeric,
    shipment_country_id numeric,
    service_provider character varying(200),
    date_of_dispatch timestamp without time zone,
    aw_bill_number character varying(200),
    courier_status character varying(200),
    received_by character varying(200),
    remarks text,
    gst_no text,
    billing_district character varying(1000),
    billing_landmark character varying(1000)
);


--
