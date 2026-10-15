-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: public
-- Object: otp_details id
-- Type: DEFAULT

-- Name: otp_details id; Type: DEFAULT; Schema: public; Owner: -
--

ALTER TABLE ONLY public.otp_details ALTER COLUMN id SET DEFAULT nextval('public.otp_details_id_seq'::regclass);


--
