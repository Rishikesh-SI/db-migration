-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: spacing id
-- Type: DEFAULT

-- Name: spacing id; Type: DEFAULT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.spacing ALTER COLUMN id SET DEFAULT nextval('lb_wf.spacing_id_seq'::regclass);


--
