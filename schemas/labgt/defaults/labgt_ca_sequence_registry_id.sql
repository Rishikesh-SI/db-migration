-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_sequence_registry id
-- Type: DEFAULT

-- Name: labgt_ca_sequence_registry id; Type: DEFAULT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_ca_sequence_registry ALTER COLUMN id SET DEFAULT nextval('labgt.labgt_ca_sequence_registry_id_seq'::regclass);


--
