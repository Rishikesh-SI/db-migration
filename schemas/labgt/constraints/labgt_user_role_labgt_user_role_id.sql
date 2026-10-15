-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgt
-- Object: labgt_user_role labgt_user_role_id
-- Type: CONSTRAINT

-- Name: labgt_user_role labgt_user_role_id; Type: CONSTRAINT; Schema: labgt; Owner: -
--

ALTER TABLE ONLY labgt.labgt_user_role
    ADD CONSTRAINT labgt_user_role_id PRIMARY KEY (user_role_id);


--
