-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labrstg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
