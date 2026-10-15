-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: rfg
-- Object: rfg_user_role rfg_user_role_id
-- Type: CONSTRAINT

-- Name: rfg_user_role rfg_user_role_id; Type: CONSTRAINT; Schema: rfg; Owner: -
--

ALTER TABLE ONLY rfg.rfg_user_role
    ADD CONSTRAINT rfg_user_role_id PRIMARY KEY (user_role_id);


--
