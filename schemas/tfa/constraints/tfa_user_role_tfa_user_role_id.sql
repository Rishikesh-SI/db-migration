-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tfa
-- Object: tfa_user_role tfa_user_role_id
-- Type: CONSTRAINT

-- Name: tfa_user_role tfa_user_role_id; Type: CONSTRAINT; Schema: tfa; Owner: -
--

ALTER TABLE ONLY tfa.tfa_user_role
    ADD CONSTRAINT tfa_user_role_id PRIMARY KEY (user_role_id);


--
