-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: orders
-- Type: TABLE

-- Name: orders; Type: TABLE; Schema: public; Owner: -
--

CREATE TABLE public.orders (
    id integer NOT NULL,
    customer_name text,
    product_name text,
    amount numeric(10,2),
    status text,
    created_at timestamp without time zone DEFAULT now()
);


--
