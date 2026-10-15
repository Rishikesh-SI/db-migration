-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_uuid_storage uuid_id
-- Type: DEFAULT

-- Name: labrr_uuid_storage uuid_id; Type: DEFAULT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_uuid_storage ALTER COLUMN uuid_id SET DEFAULT nextval('labrr.labrr_uuid_storage_uuid_id_seq'::regclass);


--
