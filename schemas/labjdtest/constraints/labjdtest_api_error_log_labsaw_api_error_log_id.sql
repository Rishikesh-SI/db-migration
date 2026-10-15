-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_api_error_log labsaw_api_error_log_id
-- Type: CONSTRAINT

-- Name: labjdtest_api_error_log labsaw_api_error_log_id; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_api_error_log
    ADD CONSTRAINT labsaw_api_error_log_id PRIMARY KEY (api_error_log_id);


--
