-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkxip
-- Object: labkxip_brightcove_video id
-- Type: DEFAULT

-- Name: labkxip_brightcove_video id; Type: DEFAULT; Schema: labkxip; Owner: -
--

ALTER TABLE ONLY labkxip.labkxip_brightcove_video ALTER COLUMN id SET DEFAULT nextval('labkxip.labkxip_brightcove_video_id_seq'::regclass);


--
