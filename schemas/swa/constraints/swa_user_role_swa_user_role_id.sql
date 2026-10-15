-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_user_role swa_user_role_id
-- Type: CONSTRAINT

-- Name: swa_user_role swa_user_role_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_user_role
    ADD CONSTRAINT swa_user_role_id PRIMARY KEY (user_role_id);


--
