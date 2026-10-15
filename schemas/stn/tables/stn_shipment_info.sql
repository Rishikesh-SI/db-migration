-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: stn
-- Object: stn_shipment_info
-- Type: TABLE

-- Name: stn_shipment_info; Type: TABLE; Schema: stn; Owner: -
--

CREATE TABLE stn.stn_shipment_info (
    shipment_id numeric NOT NULL,
    shipment_name character varying(100) NOT NULL,
    shipment_address1 character varying(100) NOT NULL,
    shipment_address2 character varying(100),
    shipment_state character varying(100) NOT NULL,
    shipment_city character varying(100) NOT NULL,
    shipment_pincode character varying(10) NOT NULL,
    shipment_mobile_no character varying(20) NOT NULL,
    is_shipment_billing_address_same numeric NOT NULL,
    billing_name character varying(100) NOT NULL,
    billing_address1 character varying(100) NOT NULL,
    billing_address2 character varying(100),
    billing_state character varying(100) NOT NULL,
    billing_city character varying(100) NOT NULL,
    billing_pincode character varying(10) NOT NULL,
    billing_mobile_no character varying(20) NOT NULL,
    promocode character varying(10),
    bill_amount numeric NOT NULL,
    fees numeric NOT NULL,
    taxes numeric NOT NULL,
    deductions numeric,
    total_amount numeric NOT NULL,
    team_id numeric NOT NULL,
    created_date timestamp without time zone NOT NULL,
    updated_date timestamp without time zone NOT NULL,
    is_active numeric NOT NULL,
    is_deleted numeric NOT NULL,
    shipment_guid character varying(256) NOT NULL
);


--
