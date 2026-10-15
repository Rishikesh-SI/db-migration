-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labsm
-- Object: labsm_user_activity labsm_user_activity_id
-- Type: CONSTRAINT

-- Name: labsm_user_activity labsm_user_activity_id; Type: CONSTRAINT; Schema: labsm; Owner: -
--

ALTER TABLE ONLY labsm.labsm_user_activity
    ADD CONSTRAINT labsm_user_activity_id PRIMARY KEY (user_activity_id);


--
