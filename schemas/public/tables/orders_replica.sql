-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: orders_replica
-- Type: TABLE

-- Name: orders_replica; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders_replica (
    id integer,
    customer_name text,
    product_name text,
    amount numeric(10,2),
    status text,
    created_at timestamp without time zone
);


--
