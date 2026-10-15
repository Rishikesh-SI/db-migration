-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_fp_req wf_user_fp_req_pkey
-- Type: CONSTRAINT

-- Name: wf_user_fp_req wf_user_fp_req_pkey; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.wf_user_fp_req
    ADD CONSTRAINT wf_user_fp_req_pkey PRIMARY KEY (cf_user_fbid);


--
