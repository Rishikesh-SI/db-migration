-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: swa_web_user web_user_id_pk; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
