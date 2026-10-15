-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: colors id
-- Type: DEFAULT

-- Name: colors id; Type: DEFAULT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.colors ALTER COLUMN id SET DEFAULT nextval('lb_wf.colors_id_seq'::regclass);


--
