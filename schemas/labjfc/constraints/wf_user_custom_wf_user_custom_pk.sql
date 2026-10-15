-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: wf_user_custom wf_user_custom_pk
-- Type: CONSTRAINT

-- Name: wf_user_custom wf_user_custom_pk; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.wf_user_custom
    ADD CONSTRAINT wf_user_custom_pk PRIMARY KEY (cf_custom_userid);


--
