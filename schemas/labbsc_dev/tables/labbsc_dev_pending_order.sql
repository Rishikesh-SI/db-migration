-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_dev
-- Object: labbsc_dev_pending_order
-- Type: TABLE

-- Name: labbsc_dev_pending_order; Type: TABLE; Schema: labbsc_dev; Owner: -
--

CREATE TABLE labbsc_dev.labbsc_dev_pending_order (
    order_id numeric NOT NULL,
    cart_id numeric,
    status numeric,
    created_date timestamp without time zone DEFAULT CURRENT_TIMESTAMP,
    updated_date timestamp without time zone
);


--
