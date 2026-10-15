-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpvl
-- Object: labpvl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labpvl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labpvl; Owner: -
--

ALTER TABLE ONLY labpvl.labpvl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
