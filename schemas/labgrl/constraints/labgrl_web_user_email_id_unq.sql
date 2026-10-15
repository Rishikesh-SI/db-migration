-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labgrl_web_user email_id_unq; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
