-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbg
-- Object: labbg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labbg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labbg; Owner: -
--

ALTER TABLE ONLY labbg.labbg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
