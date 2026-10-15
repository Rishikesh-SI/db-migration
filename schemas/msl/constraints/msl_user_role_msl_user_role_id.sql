-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_user_role msl_user_role_id
-- Type: CONSTRAINT

-- Name: msl_user_role msl_user_role_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_user_role
    ADD CONSTRAINT msl_user_role_id PRIMARY KEY (user_role_id);


--
