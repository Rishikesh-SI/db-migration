-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: orders
-- Type: TABLE

-- Name: orders; Type: TABLE; Schema: test14; Owner: -
--

CREATE TABLE test14.orders (
    order_id integer NOT NULL,
    user_id integer,
    order_amount numeric(10,2),
    order_date timestamp without time zone DEFAULT now()
);


--
