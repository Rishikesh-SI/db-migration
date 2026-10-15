-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: yho
-- Object: yho_user_role yho_user_role_id
-- Type: CONSTRAINT

-- Name: yho_user_role yho_user_role_id; Type: CONSTRAINT; Schema: yho; Owner: -
--

ALTER TABLE ONLY yho.yho_user_role
    ADD CONSTRAINT yho_user_role_id PRIMARY KEY (user_role_id);


--
