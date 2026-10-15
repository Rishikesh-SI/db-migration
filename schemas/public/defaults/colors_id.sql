-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: colors id
-- Type: DEFAULT

-- Name: colors id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.colors ALTER COLUMN id SET DEFAULT nextval('public.colors_id_seq'::regclass);


--
