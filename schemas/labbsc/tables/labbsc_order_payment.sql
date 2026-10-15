-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_order_payment
-- Type: TABLE

-- Name: labbsc_order_payment; Type: TABLE; Schema: labbsc; Owner: -
--

CREATE TABLE labbsc.labbsc_order_payment (
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
