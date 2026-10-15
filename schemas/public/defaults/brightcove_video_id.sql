-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: brightcove_video id
-- Type: DEFAULT

-- Name: brightcove_video id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.brightcove_video ALTER COLUMN id SET DEFAULT nextval('public.brightcove_video_id_seq'::regclass);


--
