-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labuww
-- Object: labuww_payment_validation_log log_id
-- Type: DEFAULT

-- Name: labuww_payment_validation_log log_id; Type: DEFAULT; Schema: labuww; Owner: -
--

ALTER TABLE ONLY labuww.labuww_payment_validation_log ALTER COLUMN log_id SET DEFAULT nextval('labuww.labuww_payment_validation_log_log_id_seq'::regclass);


--
