-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgfg
-- Object: labgfg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labgfg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labgfg; Owner: -
--

ALTER TABLE ONLY labgfg.labgfg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
