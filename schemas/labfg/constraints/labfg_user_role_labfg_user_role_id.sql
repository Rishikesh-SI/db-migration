-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labfg
-- Object: labfg_user_role labfg_user_role_id
-- Type: CONSTRAINT

-- Name: labfg_user_role labfg_user_role_id; Type: CONSTRAINT; Schema: labfg; Owner: -
--

ALTER TABLE ONLY labfg.labfg_user_role
    ADD CONSTRAINT labfg_user_role_id PRIMARY KEY (user_role_id);


--
