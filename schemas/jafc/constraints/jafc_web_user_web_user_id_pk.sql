-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: jafc
-- Object: jafc_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: jafc_web_user web_user_id_pk; Type: CONSTRAINT; Schema: jafc; Owner: -
--

ALTER TABLE ONLY jafc.jafc_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
