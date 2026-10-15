-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc_old
-- Object: labbsc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labbsc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labbsc_old; Owner: -
--

ALTER TABLE ONLY labbsc_old.labbsc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
