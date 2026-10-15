-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labiis
-- Object: labiis_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labiis_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labiis; Owner: -
--

ALTER TABLE ONLY labiis.labiis_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
