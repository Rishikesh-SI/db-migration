-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labetpl
-- Object: labetpl_user_role labetpl_user_role_id
-- Type: CONSTRAINT

-- Name: labetpl_user_role labetpl_user_role_id; Type: CONSTRAINT; Schema: labetpl; Owner: -
--

ALTER TABLE ONLY labetpl.labetpl_user_role
    ADD CONSTRAINT labetpl_user_role_id PRIMARY KEY (user_role_id);


--
