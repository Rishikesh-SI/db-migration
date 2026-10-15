-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjdtest
-- Object: labjdtest_asset_delete_log labjdtest_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labjdtest_asset_delete_log labjdtest_asset_delete_log_id; Type: CONSTRAINT; Schema: labjdtest; Owner: -
--

ALTER TABLE ONLY labjdtest.labjdtest_asset_delete_log
    ADD CONSTRAINT labjdtest_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
