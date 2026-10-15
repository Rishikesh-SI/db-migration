-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_user_transaction dd_user_transaction_id
-- Type: CONSTRAINT

-- Name: labjdtest_user_transaction dd_user_transaction_id; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_user_transaction
    ADD CONSTRAINT dd_user_transaction_id PRIMARY KEY (user_transaction_id);


--
