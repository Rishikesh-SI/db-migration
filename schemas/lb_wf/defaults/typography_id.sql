-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: typography id
-- Type: DEFAULT

-- Name: typography id; Type: DEFAULT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.typography ALTER COLUMN id SET DEFAULT nextval('lb_wf.typography_id_seq'::regclass);


--
