-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_uuid_storage uuid_id
-- Type: DEFAULT

-- Name: labdd_v1_uuid_storage uuid_id; Type: DEFAULT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_uuid_storage ALTER COLUMN uuid_id SET DEFAULT nextval('labdd_v1.labdd_v1_uuid_storage_uuid_id_seq'::regclass);


--
