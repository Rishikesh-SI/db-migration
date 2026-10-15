-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: practice_questions q_id
-- Type: DEFAULT

-- Name: practice_questions q_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.practice_questions ALTER COLUMN q_id SET DEFAULT nextval('public.practice_questions_q_id_seq'::regclass);


--
