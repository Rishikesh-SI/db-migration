-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_web_user email_id_unq
-- Type: CONSTRAINT

-- Name: labjdtest_web_user email_id_unq; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_web_user
    ADD CONSTRAINT email_id_unq UNIQUE (email_id);


--
