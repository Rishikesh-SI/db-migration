-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrg
-- Object: labrg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labrg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labrg; Owner: -
--

ALTER TABLE ONLY labrg.labrg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
