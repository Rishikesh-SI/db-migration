-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: employee_detail employee_id
-- Type: DEFAULT

-- Name: employee_detail employee_id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.employee_detail ALTER COLUMN employee_id SET DEFAULT nextval('public.employee_detail_employee_id_seq'::regclass);


--
