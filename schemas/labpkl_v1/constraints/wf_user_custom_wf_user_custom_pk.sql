-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl_v1
-- Object: wf_user_custom wf_user_custom_pk
-- Type: CONSTRAINT

-- Name: wf_user_custom wf_user_custom_pk; Type: CONSTRAINT; Schema: labpkl_v1; Owner: -
--

ALTER TABLE ONLY labpkl_v1.wf_user_custom
    ADD CONSTRAINT wf_user_custom_pk PRIMARY KEY (cf_custom_userid);


--
