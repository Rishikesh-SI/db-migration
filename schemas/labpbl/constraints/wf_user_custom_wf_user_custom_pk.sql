-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpbl
-- Object: wf_user_custom wf_user_custom_pk
-- Type: CONSTRAINT

-- Name: wf_user_custom wf_user_custom_pk; Type: CONSTRAINT; Schema: labpbl; Owner: -
--

ALTER TABLE ONLY labpbl.wf_user_custom
    ADD CONSTRAINT wf_user_custom_pk PRIMARY KEY (cf_custom_userid);


--
