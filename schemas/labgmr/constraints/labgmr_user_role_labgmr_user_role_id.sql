-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_user_role labgmr_user_role_id
-- Type: CONSTRAINT

-- Name: labgmr_user_role labgmr_user_role_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_user_role
    ADD CONSTRAINT labgmr_user_role_id PRIMARY KEY (user_role_id);


--
