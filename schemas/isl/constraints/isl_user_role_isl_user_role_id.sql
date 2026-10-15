-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: isl
-- Object: isl_user_role isl_user_role_id
-- Type: CONSTRAINT

-- Name: isl_user_role isl_user_role_id; Type: CONSTRAINT; Schema: isl; Owner: -
--

ALTER TABLE ONLY isl.isl_user_role
    ADD CONSTRAINT isl_user_role_id PRIMARY KEY (user_role_id);


--
