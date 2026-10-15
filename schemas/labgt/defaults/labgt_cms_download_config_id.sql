-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_cms_download_config id
-- Type: DEFAULT

-- Name: labgt_cms_download_config id; Type: DEFAULT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_cms_download_config ALTER COLUMN id SET DEFAULT nextval('labgt.labgt_cms_download_config_id_seq'::regclass);


--
