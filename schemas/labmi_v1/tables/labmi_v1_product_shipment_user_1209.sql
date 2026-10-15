-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labmi_v1
-- Object: labmi_v1_product_shipment_user_1209
-- Type: TABLE

-- Name: labmi_v1_product_shipment_user_1209; Type: TABLE; Schema: labmi_v1; Owner: -
--

CREATE TABLE labmi_v1.labmi_v1_product_shipment_user_1209 (
    product_shipment_user_id numeric,
    product_cart_id numeric,
    shipment_name character varying(200),
    shipment_address1 character varying(200),
    shipment_address2 character varying(200),
    shipment_state character varying(200),
    shipment_city character varying(200),
    shipment_pincode character varying(100),
    shipment_mobile_no character varying(200),
    is_shipment_billing_address_same numeric,
    billing_name character varying(200),
    billing_address1 character varying(200),
    billing_address2 character varying(200),
    billing_state character varying(200),
    billing_city character varying(200),
    billing_pincode character varying(100),
    billing_mobile_no character varying(200),
    promocode character varying(100),
    bill_amount numeric,
    fees numeric,
    taxes numeric,
    deductions numeric,
    total_amount numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone,
    is_active numeric,
    is_deleted numeric,
    shipment_guid character varying(256),
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
