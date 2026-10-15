-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_ca_campaign_metadata id
-- Type: DEFAULT

-- Name: labgt_ca_campaign_metadata id; Type: DEFAULT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_ca_campaign_metadata ALTER COLUMN id SET DEFAULT nextval('labgt.labgt_ca_campaign_metadata_id_seq'::regclass);


--
