-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labpkl
-- Object: labpkl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labpkl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labpkl; Owner: -
--

ALTER TABLE ONLY labpkl.labpkl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
