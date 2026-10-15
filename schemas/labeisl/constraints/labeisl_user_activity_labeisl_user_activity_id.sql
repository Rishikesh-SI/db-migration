-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labeisl
-- Object: labeisl_user_activity labeisl_user_activity_id
-- Type: CONSTRAINT

-- Name: labeisl_user_activity labeisl_user_activity_id; Type: CONSTRAINT; Schema: labeisl; Owner: -
--

ALTER TABLE ONLY labeisl.labeisl_user_activity
    ADD CONSTRAINT labeisl_user_activity_id PRIMARY KEY (user_activity_id);


--
