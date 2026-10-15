-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_video_ingestion_audit id
-- Type: DEFAULT

-- Name: labuww_video_ingestion_audit id; Type: DEFAULT; Schema: labuww; Owner: -
--

ALTER TABLE ONLY labuww.labuww_video_ingestion_audit ALTER COLUMN id SET DEFAULT nextval('labuww.labuww_video_ingestion_audit_id_seq'::regclass);


--
