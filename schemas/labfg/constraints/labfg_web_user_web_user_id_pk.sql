-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labfg_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
