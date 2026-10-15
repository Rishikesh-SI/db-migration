-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpr
-- Object: questions q_id
-- Type: DEFAULT

-- Name: questions q_id; Type: DEFAULT; Schema: labpr; Owner: -
--

ALTER TABLE ONLY labpr.questions ALTER COLUMN q_id SET DEFAULT nextval('labpr.questions_q_id_seq'::regclass);


--
