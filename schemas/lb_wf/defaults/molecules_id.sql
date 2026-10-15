-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecules id
-- Type: DEFAULT

-- Name: molecules id; Type: DEFAULT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.molecules ALTER COLUMN id SET DEFAULT nextval('lb_wf.molecules_id_seq'::regclass);


--
