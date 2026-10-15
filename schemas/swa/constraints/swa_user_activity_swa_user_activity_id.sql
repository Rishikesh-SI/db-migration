-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: swa
-- Object: swa_user_activity swa_user_activity_id
-- Type: CONSTRAINT

-- Name: swa_user_activity swa_user_activity_id; Type: CONSTRAINT; Schema: swa; Owner: -
--

ALTER TABLE ONLY swa.swa_user_activity
    ADD CONSTRAINT swa_user_activity_id PRIMARY KEY (user_activity_id);


--
