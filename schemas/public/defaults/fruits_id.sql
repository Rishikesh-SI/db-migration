-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: fruits id
-- Type: DEFAULT

-- Name: fruits id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.fruits ALTER COLUMN id SET DEFAULT nextval('public.fruits_id_seq'::regclass);


--
