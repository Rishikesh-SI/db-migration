-- Generated from pg_dump; do not hand-edit this baseline without review.
-- Schema: labjfc
-- Object: labjfc_asset_delete_log labjfc_asset_delete_log_id
-- Type: CONSTRAINT

-- Name: labjfc_asset_delete_log labjfc_asset_delete_log_id; Type: CONSTRAINT; Schema: labjfc; Owner: -
--

ALTER TABLE ONLY labjfc.labjfc_asset_delete_log
    ADD CONSTRAINT labjfc_asset_delete_log_id PRIMARY KEY (asset_delete_log_id);


--
