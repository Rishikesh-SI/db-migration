-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_titans_fifer_2026 id
-- Type: DEFAULT

-- Name: labgt_titans_fifer_2026 id; Type: DEFAULT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_titans_fifer_2026 ALTER COLUMN id SET DEFAULT nextval('labgt.labgt_titans_fifer_2026_id_seq'::regclass);


--
