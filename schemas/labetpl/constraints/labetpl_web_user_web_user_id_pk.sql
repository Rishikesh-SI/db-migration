-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labetpl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
