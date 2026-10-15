-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labyho
-- Object: labyho_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labyho_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labyho; Owner: -
--

ALTER TABLE ONLY labyho.labyho_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
