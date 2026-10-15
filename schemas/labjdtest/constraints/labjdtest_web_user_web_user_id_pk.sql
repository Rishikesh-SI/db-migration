-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_web_user web_user_id_pk
-- Type: CONSTRAINT

-- Name: labjdtest_web_user web_user_id_pk; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_web_user
    ADD CONSTRAINT web_user_id_pk PRIMARY KEY (user_id);


--
