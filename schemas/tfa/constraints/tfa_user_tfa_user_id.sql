-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_user tfa_user_id
-- Type: CONSTRAINT

-- Name: tfa_user tfa_user_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_user
    ADD CONSTRAINT tfa_user_id PRIMARY KEY (user_id);


--
