-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_settlement_data
-- Type: TABLE

-- Name: labbsc_dev_settlement_data; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_settlement_data (
    sd_id numeric NOT NULL,
    pay_id numeric,
    pay_id_txn_details jsonb,
    type character varying,
    created_date timestamp with time zone,
    updated_date timestamp with time zone,
    transaction_ref_no text
);


--
