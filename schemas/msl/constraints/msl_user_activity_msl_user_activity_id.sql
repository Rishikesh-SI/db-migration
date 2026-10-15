-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: msl
-- Object: msl_user_activity msl_user_activity_id
-- Type: CONSTRAINT

-- Name: msl_user_activity msl_user_activity_id; Type: CONSTRAINT; Schema: msl; Owner: -
--

ALTER TABLE ONLY msl.msl_user_activity
    ADD CONSTRAINT msl_user_activity_id PRIMARY KEY (user_activity_id);


--
