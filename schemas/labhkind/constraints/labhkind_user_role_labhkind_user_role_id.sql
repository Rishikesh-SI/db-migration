-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhkind
-- Object: labhkind_user_role labhkind_user_role_id
-- Type: CONSTRAINT

-- Name: labhkind_user_role labhkind_user_role_id; Type: CONSTRAINT; Schema: labhkind; Owner: -
--

ALTER TABLE ONLY labhkind.labhkind_user_role
    ADD CONSTRAINT labhkind_user_role_id PRIMARY KEY (user_role_id);


--
