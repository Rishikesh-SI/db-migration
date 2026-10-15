-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: yho_web_user web_user_id_pk; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
