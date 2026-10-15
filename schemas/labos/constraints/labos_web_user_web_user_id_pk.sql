-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labos
-- Object: labos_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labos_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labos; Owner: -
--

ALTER TABLE ONLY labos.labos_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
