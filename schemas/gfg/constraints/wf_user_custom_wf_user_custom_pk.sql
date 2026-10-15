-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: gfg
-- Object: wf_user_custom wf_user_custom_pk
-- Type: CONSTRAINT

-- Name: wf_user_custom wf_user_custom_pk; Type: CONSTRAINT; Schema: gfg; Owner: -
--

ALTER TABLE ONLY gfg.wf_user_custom
    ADD CONSTRAINT wf_user_custom_pk PRIMARY KEY (cf_custom_userid);


--
