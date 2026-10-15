-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: orders id
-- Type: DEFAULT

-- Name: orders id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.orders ALTER COLUMN id SET DEFAULT nextval('public.orders_id_seq'::regclass);


--
