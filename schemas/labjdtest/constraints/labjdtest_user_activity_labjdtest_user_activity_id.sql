-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_user_activity labjdtest_user_activity_id
-- Type: CONSTRAINT

-- Name: labjdtest_user_activity labjdtest_user_activity_id; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_user_activity
    ADD CONSTRAINT labjdtest_user_activity_id PRIMARY KEY (user_activity_id);


--
