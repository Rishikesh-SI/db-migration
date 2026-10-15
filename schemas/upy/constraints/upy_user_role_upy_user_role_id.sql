-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: upy
-- Object: upy_user_role upy_user_role_id
-- Type: CONSTRAINT

-- Name: upy_user_role upy_user_role_id; Type: CONSTRAINT; Schema: upy; Owner: -
--

ALTER TABLE ONLY upy.upy_user_role
    ADD CONSTRAINT upy_user_role_id PRIMARY KEY (user_role_id);


--
