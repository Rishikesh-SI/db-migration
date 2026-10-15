-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: hsl
-- Object: hsl_user_role hsl_user_role_id
-- Type: CONSTRAINT

-- Name: hsl_user_role hsl_user_role_id; Type: CONSTRAINT; Schema: hsl; Owner: -
--

ALTER TABLE ONLY hsl.hsl_user_role
    ADD CONSTRAINT hsl_user_role_id PRIMARY KEY (user_role_id);


--
