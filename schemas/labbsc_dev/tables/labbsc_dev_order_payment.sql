-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_order_payment
-- Type: TABLE

-- Name: labbsc_dev_order_payment; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_order_payment (
    payment_id numeric NOT NULL,
    order_id numeric,
    transaction_id character varying(100),
    payment_details jsonb,
    status character varying(50),
    payment_date character varying(500),
    version_number numeric,
    created_date timestamp without time zone,
    updated_date timestamp without time zone
);


--
