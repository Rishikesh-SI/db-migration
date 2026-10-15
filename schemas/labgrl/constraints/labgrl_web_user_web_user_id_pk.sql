-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labgrl_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
