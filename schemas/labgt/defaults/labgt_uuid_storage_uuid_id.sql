-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_uuid_storage uuid_id
-- Type: DEFAULT

-- Name: labgt_uuid_storage uuid_id; Type: DEFAULT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_uuid_storage ALTER COLUMN uuid_id SET DEFAULT nextval('labgt.labgt_uuid_storage_uuid_id_seq'::regclass);


--
