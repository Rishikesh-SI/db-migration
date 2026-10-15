-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labgrl
-- Object: labgrl_user_activity labgrl_user_activity_id
-- Type: CONSTRAINT

-- Name: labgrl_user_activity labgrl_user_activity_id; Type: CONSTRAINT; Schema: labgrl; Owner: -
--

ALTER TABLE ONLY labgrl.labgrl_user_activity
    ADD CONSTRAINT labgrl_user_activity_id PRIMARY KEY (user_activity_id);


--
