-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test13
-- Object: orders_order_id_seq
-- Type: SEQUENCE OWNED BY

-- Name: orders_order_id_seq; Type: SEQUENCE OWNED BY; Schema: test13; Owner: -
--

ALTER SEQUENCE test13.orders_order_id_seq OWNED BY test13.orders.order_id;


--
