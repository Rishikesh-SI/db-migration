-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labrstg
-- Object: labrstg_user_role labrstg_user_role_id
-- Type: CONSTRAINT

-- Name: labrstg_user_role labrstg_user_role_id; Type: CONSTRAINT; Schema: labrstg; Owner: -
--

ALTER TABLE ONLY labrstg.labrstg_user_role
    ADD CONSTRAINT labrstg_user_role_id PRIMARY KEY (user_role_id);


--
