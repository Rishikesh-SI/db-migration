-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labkc_v1
-- Object: labkc_v1_otpless_lockout_log id
-- Type: DEFAULT

-- Name: labkc_v1_otpless_lockout_log id; Type: DEFAULT; Schema: labkc_v1; Owner: -
--

ALTER TABLE ONLY labkc_v1.labkc_v1_otpless_lockout_log ALTER COLUMN id SET DEFAULT nextval('labkc_v1.labkc_v1_otpless_lockout_log_id_seq'::regclass);


--
