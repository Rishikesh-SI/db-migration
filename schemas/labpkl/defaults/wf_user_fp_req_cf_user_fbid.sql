-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: wf_user_fp_req cf_user_fbid
-- Type: DEFAULT

-- Name: wf_user_fp_req cf_user_fbid; Type: DEFAULT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.wf_user_fp_req ALTER COLUMN cf_user_fbid SET DEFAULT nextval('labpkl.wf_user_fp_req_cf_user_fbid_seq'::regclass);


--
