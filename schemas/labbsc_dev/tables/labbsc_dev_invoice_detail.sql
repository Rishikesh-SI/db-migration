-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_invoice_detail
-- Type: TABLE

-- Name: labbsc_dev_invoice_detail; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_invoice_detail (
    invoice_detail_id numeric NOT NULL,
    first_name text,
    last_name text,
    state_name text,
    pan_number text,
    gst_number text,
    bill_date character varying(500),
    bill_no numeric,
    tax_rate character varying(50),
    service_type character varying(500),
    sac_code numeric,
    taxable_amount numeric,
    igst character varying(50),
    cgst character varying(50),
    sgst character varying(50),
    total_amount numeric,
    transaction_id text,
    transaction_status character varying(50) DEFAULT 'Success'::character varying,
    invoice_id text,
    invoice_status character varying(50) DEFAULT 'Success'::character varying,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    user_id numeric,
    is_state numeric,
    counseller_id numeric,
    counseller_name character varying(500),
    merchant_name character varying(500),
    invoice_no numeric,
    activity_id numeric
);


--
