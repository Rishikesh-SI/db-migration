-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: lb_wf
-- Object: molecule_atom_map id
-- Type: DEFAULT

-- Name: molecule_atom_map id; Type: DEFAULT; Schema: lb_wf; Owner: -
--

ALTER TABLE ONLY lb_wf.molecule_atom_map ALTER COLUMN id SET DEFAULT nextval('lb_wf.molecule_atom_map_id_seq'::regclass);


--
