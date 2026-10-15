-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbsc
-- Object: labbsc_user_role labbsc_user_role_id
-- Type: CONSTRAINT

-- Name: labbsc_user_role labbsc_user_role_id; Type: CONSTRAINT; Schema: labbsc; Owner: -
--

ALTER TABLE ONLY labbsc.labbsc_user_role
    ADD CONSTRAINT labbsc_user_role_id PRIMARY KEY (user_role_id);


--
