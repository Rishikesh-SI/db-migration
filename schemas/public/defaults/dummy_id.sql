-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: dummy id
-- Type: DEFAULT

-- Name: dummy id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.dummy ALTER COLUMN id SET DEFAULT nextval('public.dummy_id_seq'::regclass);


--
