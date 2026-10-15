-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_user_role labsm_user_role_id
-- Type: CONSTRAINT

-- Name: labsm_user_role labsm_user_role_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_user_role
    ADD CONSTRAINT labsm_user_role_id PRIMARY KEY (user_role_id);


--
