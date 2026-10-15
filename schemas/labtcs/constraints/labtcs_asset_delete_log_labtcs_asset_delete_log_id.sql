-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labtcs
-- Object: labtcs_asset_delete_log labtcs_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labtcs_asset_delete_log labtcs_asset_delete_log_id; Type: CONSTRAINT; Schema: labtcs; Owner: -
--

ALTER TABLE ONLY labtcs.labtcs_asset_delete_log
    ADD CONSTRAINT labtcs_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
