-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: test14
-- Object: orders order_id
-- Type: DEFAULT

-- Name: orders order_id; Type: DEFAULT; Schema: test14; Owner: -
--

ALTER TABLE ONLY test14.orders ALTER COLUMN order_id SET DEFAULT nextval('test14.orders_order_id_seq'::regclass);


--
