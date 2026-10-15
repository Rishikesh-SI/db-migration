-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labeisl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labeisl; Owner: -
--

ALTER TABLE ONLY labeisl.labeisl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
