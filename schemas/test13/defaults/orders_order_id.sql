-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test13
-- Object: orders order_id
-- Type: DEFAULT

-- Name: orders order_id; Type: DEFAULT; Schema: test13; Owner: -
--

ALTER TABLE ONLY test13.orders ALTER COLUMN order_id SET DEFAULT nextval('test13.orders_order_id_seq'::regclass);


--
