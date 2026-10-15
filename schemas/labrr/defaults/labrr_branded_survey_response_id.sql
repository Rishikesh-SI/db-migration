-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrr
-- Object: labrr_branded_survey_response id
-- Type: DEFAULT

-- Name: labrr_branded_survey_response id; Type: DEFAULT; Schema: labrr; Owner: -
--

ALTER TABLE ONLY labrr.labrr_branded_survey_response ALTER COLUMN id SET DEFAULT nextval('labrr.labrr_branded_survey_response_id_seq'::regclass);


--
