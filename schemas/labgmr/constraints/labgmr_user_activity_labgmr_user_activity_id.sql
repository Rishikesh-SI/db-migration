-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgmr
-- Object: labgmr_user_activity labgmr_user_activity_id
-- Type: CONSTRAINT

-- Name: labgmr_user_activity labgmr_user_activity_id; Type: CONSTRAINT; Schema: labgmr; Owner: -
--

ALTER TABLE ONLY labgmr.labgmr_user_activity
    ADD CONSTRAINT labgmr_user_activity_id PRIMARY KEY (user_activity_id);


--
