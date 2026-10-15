-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labdd_v1
-- Object: labdd_v1_user_role labdd_v1_user_role_id
-- Type: CONSTRAINT

-- Name: labdd_v1_user_role labdd_v1_user_role_id; Type: CONSTRAINT; Schema: labdd_v1; Owner: -
--

ALTER TABLE ONLY labdd_v1.labdd_v1_user_role
    ADD CONSTRAINT labdd_v1_user_role_id PRIMARY KEY (user_role_id);


--
