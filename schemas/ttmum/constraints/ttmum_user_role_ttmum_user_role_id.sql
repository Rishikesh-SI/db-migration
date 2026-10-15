-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: ttmum
-- Object: ttmum_user_role ttmum_user_role_id
-- Type: CONSTRAINT

-- Name: ttmum_user_role ttmum_user_role_id; Type: CONSTRAINT; Schema: ttmum; Owner: -
--

ALTER TABLE ONLY ttmum.ttmum_user_role
    ADD CONSTRAINT ttmum_user_role_id PRIMARY KEY (user_role_id);


--
