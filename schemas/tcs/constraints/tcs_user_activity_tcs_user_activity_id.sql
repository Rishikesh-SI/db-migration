-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: tcs
-- Object: tcs_user_activity tcs_user_activity_id
-- Type: CONSTRAINT

-- Name: tcs_user_activity tcs_user_activity_id; Type: CONSTRAINT; Schema: tcs; Owner: -
--

ALTER TABLE ONLY tcs.tcs_user_activity
    ADD CONSTRAINT tcs_user_activity_id PRIMARY KEY (user_activity_id);


--
