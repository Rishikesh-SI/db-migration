-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labhsl
-- Object: labhsl_user_role hsl_user_role_id
-- Type: CONSTRAINT

-- Name: labhsl_user_role hsl_user_role_id; Type: CONSTRAINT; Schema: labhsl; Owner: -
--

ALTER TABLE ONLY labhsl.labhsl_user_role
    ADD CONSTRAINT hsl_user_role_id PRIMARY KEY (user_role_id);


--
