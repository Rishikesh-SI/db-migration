-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_fp_req cf_user_fbid
-- Type: DEFAULT

-- Name: wf_user_fp_req cf_user_fbid; Type: DEFAULT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.wf_user_fp_req ALTER COLUMN cf_user_fbid SET DEFAULT nextval('labpkl_v1.wf_user_fp_req_cf_user_fbid_seq'::regclass);


--
