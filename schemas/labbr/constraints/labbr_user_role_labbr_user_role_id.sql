-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labbr
-- Object: labbr_user_role labbr_user_role_id
-- Type: CONSTRAINT

-- Name: labbr_user_role labbr_user_role_id; Type: CONSTRAINT; Schema: labbr; Owner: -
--

ALTER TABLE ONLY labbr.labbr_user_role
    ADD CONSTRAINT labbr_user_role_id PRIMARY KEY (user_role_id);


--
