-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labwpl
-- Object: labwpl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labwpl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labwpl; Owner: -
--

ALTER TABLE ONLY labwpl.labwpl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
